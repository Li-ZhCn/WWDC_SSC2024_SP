//
//  VisionHandPoseDetectorVC.swift
//
//
//  Created by Li Zhicheng.
//

import UIKit
import AVKit
import Vision

final class VisionHandPoseDetectorVC: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    weak var delegate: VisionHandPoseDetectorVCDelegate?

    private var orientation: UIInterfaceOrientation {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.interfaceOrientation ?? .portrait
    }

    private let captureSession = AVCaptureSession()
    private let videoDataOutput = AVCaptureVideoDataOutput()

    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    private var drawingLayers: [CAShapeLayer] = []
    private var lastFaceRectangleOrigin: CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()
        captureSessionSetup()
        captureSession.startRunning()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateConnectionOrientation()
        self.previewLayer.frame = self.view.frame
    }

    private func updateConnectionOrientation() {
        guard let connection = previewLayer.connection else { return }

        let previewLayerConnection: AVCaptureConnection = connection

        if previewLayerConnection.isVideoOrientationSupported {
            previewLayerConnection.videoOrientation = AVCaptureVideoOrientation(
                rawValue: orientation.rawValue) ?? .portrait
        }
        self.previewLayer.frame = self.view.frame
    }

    private func previewLayerSetup() {
        self.previewLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.view.frame

        self.videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString):
                                                NSNumber(value: kCVPixelFormatType_32BGRA)] as [String: Any]

        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camBufferQueue"))
        self.captureSession.addOutput(self.videoDataOutput)

        let videoConnection = self.videoDataOutput.connection(with: .video)
        videoConnection?.videoOrientation = .portrait
    }

    private func checkCamPermission() async -> Bool {
        let permission = AVCaptureDevice.authorizationStatus(for: .video)

        switch permission {
        case .authorized:
            return true
        case .notDetermined:
            return await withCheckedContinuation { continuation in
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    continuation.resume(returning: granted)
                }
            }
        default:
            return false
        }
    }

    private func captureSessionSetup() {

        Task(priority: .userInitiated) {
            if await !checkCamPermission() {
                delegate?.onCamInitComplete(VHPDError.camPermissionDenied)
                return
            }

            guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                              for: .video, position: .front) else {
                delegate?.onCamInitComplete(VHPDError.noCaptureDevices)
                return
            }

            if captureDevice.activeFormat.isCenterStageSupported {
                AVCaptureDevice.centerStageControlMode = .cooperative
                AVCaptureDevice.isCenterStageEnabled = true
            }

            guard let deviceInput = try? AVCaptureDeviceInput(device: captureDevice) else {
                delegate?.onCamInitComplete(VHPDError.noInputs)
                return
            }
            if captureSession.canAddInput(deviceInput) {
                captureSession.addInput(deviceInput)
                previewLayerSetup()
            } else {
                delegate?.onCamInitComplete(VHPDError.invalidInputs)
            }

            delegate?.onCamInitComplete(nil)
        }

    }
}

extension VisionHandPoseDetectorVC {
    private func getCGPoint(observation: VNHumanHandPoseObservation, jointName: VNHumanHandPoseObservation.JointName, confidenceThreshold: Float = 0.3) -> CGPoint? {
        guard let p = try? observation.recognizedPoint(jointName),
              p.confidence > confidenceThreshold
        else {
            return nil
        }
        
        return VNImagePointForNormalizedPoint(CGPoint(x: p.location.x, y: 1 - p.location.y), Int(self.view.bounds.width), Int(self.view.bounds.height))
    }
    
    private func getRefDistance(observation: VNHumanHandPoseObservation) -> CGFloat? {
        guard let wristPt = self.getCGPoint(observation: observation, jointName: .wrist),
        let middlePt = self.getCGPoint(observation: observation, jointName: .middleMCP) else {
            return nil
        }
        return wristPt.distance(to: middlePt)
    }
    
    private func handleHumanHandPoseDetectionObservations(observations: [VNHumanHandPoseObservation]) {
        delegate?.detectedHandNum = observations.count
        if observations.count <= 0 { return }
        
        var handIndex = 0
        observations.forEach { observation in
            delegate?.refDistances[handIndex] = self.getRefDistance(observation: observation)
            var jointIndex = 0
            delegate?.jointNames.forEach { joint in
                delegate?.criticalPoints[handIndex * 2 + jointIndex] = self.getCGPoint(observation: observation, jointName: joint)
                jointIndex = jointIndex + 1
            }
            handIndex = handIndex + 1
        }
        
        
    }

    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            print("VisionHandPoseDetectorVC: Cannot get image buffer!")
            return
        }
        
        let landmarksRequest = VNDetectHumanHandPoseRequest(completionHandler: { (request: VNRequest, _) in
            DispatchQueue.main.async {
                if let observations = request.results as? [VNHumanHandPoseObservation] {
                    self.handleHumanHandPoseDetectionObservations(observations: observations)
                }
            }
        })
        
        landmarksRequest.maximumHandCount = 2
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: imageBuffer,
                                                        orientation: .leftMirrored, options: [:])

        do {
            try imageRequestHandler.perform([landmarksRequest])
        } catch {
            print(error.localizedDescription)
        }
    }
}
