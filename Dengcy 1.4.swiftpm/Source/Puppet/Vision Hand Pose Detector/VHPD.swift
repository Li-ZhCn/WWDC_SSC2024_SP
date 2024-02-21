//
//  VisionHandPoseDetector.swift
//
//
//  Created by Li Zhicheng.
//

import SwiftUI
import Vision

struct VisionHandPoseDetector: UIViewControllerRepresentable {
    @EnvironmentObject var handPoseDetectorOutput: VisionHandPoseDetectorOutput
    
    let onCamInitComplete: (VHPDError?) -> Void

    class Coordinator: NSObject, VisionHandPoseDetectorVCDelegate {
        var parent: VisionHandPoseDetector
        
        var jointNames: [VNHumanHandPoseObservation.JointName]

        var criticalPoints: [CGPoint?] {
            didSet {
                withAnimation() {
                    self.parent.handPoseDetectorOutput.criticalPoints = criticalPoints
                }
            }
        }
        var detectedHandNum: Int {
            didSet {
                withAnimation() {
                    self.parent.handPoseDetectorOutput.detectedHandNum = detectedHandNum
                }
            }
        }
        var refDistances: [CGFloat?] {
            didSet {
                withAnimation() {
                    self.parent.handPoseDetectorOutput.refDistances = refDistances
                }
            }
        }
        
        var onCamInitComplete: (VHPDError?) -> Void

        init(_ parent: VisionHandPoseDetector) {
            self.parent = parent
            
            self.jointNames = parent.handPoseDetectorOutput.jointNames
            self.criticalPoints = parent.handPoseDetectorOutput.criticalPoints
            self.detectedHandNum = parent.handPoseDetectorOutput.detectedHandNum
            self.refDistances = parent.handPoseDetectorOutput.refDistances
            
            func onCamInitCompleteAsync(_ error: VHPDError?) {
                DispatchQueue.main.async {
                    parent.onCamInitComplete(error)
                }
            }
            self.onCamInitComplete = onCamInitCompleteAsync
        }

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> VisionHandPoseDetectorVC {
        let visionVC = VisionHandPoseDetectorVC()
        visionVC.delegate = context.coordinator
        return visionVC
    }

    func updateUIViewController(_ visionHandPoseDetectorVC: VisionHandPoseDetectorVC, context: Context) {
        visionHandPoseDetectorVC.delegate?.onCamInitComplete = onCamInitComplete
    }
}
