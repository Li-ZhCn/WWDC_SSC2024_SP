//
//  PuppetView.swift
//
//
//  Created by Li Zhicheng.
//

import SwiftUI
import SpriteKit

struct PuppetView: View {
    @EnvironmentObject var spViewModel: SPViewModel
    @EnvironmentObject var puppetConfig: PuppetConfig
    
    @State var animateOnScreen: Bool = false
    @State private var alertText: String?

    @StateObject var handPoseDetectorOutput = VisionHandPoseDetectorOutput(jointNames: [.indexTip, .thumbTip])
    
    // TODO: kalmanfilter cannot function as expected.
//    var kalmanFilter: KalmanFilterCG = KalmanFilterCG(boundsWidth: spViewModel.screenSize.width)
    var meanFilter: MeanFilterCG = MeanFilterCG()
    
    // These puppetInput convert the handPoseDetectorOutput to multible compatible input for puppet. It should be optimized if more hands are to be detected.
    @StateObject var puppetInput1: PuppetInput = PuppetInput()
    @StateObject var puppetInput2: PuppetInput = PuppetInput()
    
    @State var puppetScene = PuppetScene(size: CGSize(width: 150, height: 150))
    
    var body: some View {
        VStack {
            if animateOnScreen {
                ZStack {
                    if spViewModel.menuType == .play {
                        // The live capture that detect uses' hands
                        VisionHandPoseDetector(onCamInitComplete: handleCamInitComplete)
                            .opacity(spViewModel.camOpacity)
                        
                        // The points on the screen that help users to locate their hands.
                        HandPoseDetectorHelperView()
                    }
                    
                    // The puppet
                    SpriteView(scene: self.puppetScene, options: [.allowsTransparency])
                        .shadow(radius: 3)
                        .blur(radius: 3)
                        .blendMode(.multiply)
                        .supported(by: .singleStick)
                        .sway(amplitude: spViewModel.menuType == .play ? 0 : 5, interval: 3)
                        .frame(width: spViewModel.screenSize.width, height: spViewModel.screenSize.height)
                        
                }
                .transition(.offset(x: 100, y: spViewModel.screenSize.height).combined(with: .scale(scale: 5)))
                .environmentObject(handPoseDetectorOutput)
                .onAppear() {
                    self.puppetInput1.setFilter(filter: self.meanFilter)
                }
                .onChange(of: spViewModel.menuType) { _ in
                    handlePlayStatusUpdate()
                }
                .onChange(of: spViewModel.focusNodeName) { _ in
                    handleCamUpdate()
                }
                .onChange(of: puppetConfig.status) { _ in
                    handleConfigUpdate()
                }
                .onChange(of: handPoseDetectorOutput.status) { _ in
                    updatePuppetInput(controlPointDict: getControlPointDict())
                }
                .onChange(of: self.puppetInput1.pinchPos) { pinchPos in
                    handlePuppetInput(puppetInput: self.puppetInput1)
                }
                .onDisappear() {
                    withAnimation(spViewModel.animationGeneral) {
                        animateOnScreen = false
                    }
                }
            }
        }.onAppear() {
            withAnimation(spViewModel.animationQuick) {
                animateOnScreen = true
            }
        }
        
    }
    
    private func handlePlayStatusUpdate() {
        switch spViewModel.menuType {
        case .none:
            print("none")
        case .shape:
            print("shape")
            self.puppetScene.resetPosition()
        case .setting:
            print("setting")
            self.puppetScene.raiseHand()
            self.puppetScene.removePhysics()
        case .play:
            print("play")
            self.puppetScene.resetPosition()
            if spViewModel.gravity {
                self.puppetScene.configurePhysics()
            } else {
                self.puppetScene.removePhysics()
            }
        case .learning:
            self.puppetScene.resetPosition()
            self.puppetScene.removePhysics()
            print("learning")
        }
    }
    
    /// This is the cam in the SpriteKit
    private func handleCamUpdate() {
        var meanY: CGFloat = 0
        var nodeNum: CGFloat = 0
        if let focusNodeName = spViewModel.focusNodeName {
            self.puppetScene.puppetNode.enumerateChildNodes(withName: ".//\(focusNodeName)") { node, stop in
                nodeNum += 1
                let pos = node.parent!.convert(node.position, to: self.puppetScene)
                meanY += pos.y
            }
            
            meanY = meanY / nodeNum
            self.puppetScene.zoomIn(to: CGPoint(x: 0, y: meanY), scale: 0.5)

        } else {
            self.puppetScene.resetCam()
        }
    }
    
    private func handleConfigUpdate() {
        let puppetNode = puppetScene.puppetNode
        
        switch spViewModel.verticalShapePickerType {
        case .hat:
            let hat = self.puppetConfig.hat
            if hat == "empty" {
                print("hat is empty")
                puppetNode.pHat.texture = nil
                puppetNode.pHat.removeFromParent()
            } else {
                print("hat is not empty \(self.puppetConfig.hat)")
                puppetNode.pHat.texture = .init(imageNamed: self.puppetConfig.hat)
                if !puppetNode.pHat.inParentHierarchy(puppetNode.pHead) { puppetNode.pHead.addChild(puppetNode.pHat)
                }
                
            }
        case .arm:
            puppetNode.pRArm.texture = .init(imageNamed: self.puppetConfig.armA)
            puppetNode.pLArm.texture = .init(imageNamed: self.puppetConfig.armA)
            puppetNode.pRHand.texture = .init(imageNamed: self.puppetConfig.handA)
            puppetNode.pLHand.texture = .init(imageNamed: self.puppetConfig.handA)
        case .none:
            return
        case .head:
            puppetNode.pHead.texture = .init(imageNamed: self.puppetConfig.head)
        case .body:
            puppetNode.pBody.texture = .init(imageNamed: self.puppetConfig.body)
        case .leg:
            puppetNode.pRLeg.texture = .init(imageNamed: self.puppetConfig.legA)
            puppetNode.pLLeg.texture = .init(imageNamed: self.puppetConfig.legB)
            puppetNode.pRFoot.texture = .init(imageNamed: self.puppetConfig.foot)
            puppetNode.pLFoot.texture = .init(imageNamed: self.puppetConfig.foot)
        }
    }
    
    /// This is the real cam!
    private func handleCamInitComplete(error: VHPDError?) -> Void {
        DispatchQueue.main.async {
            if let error = error {
                switch error {
                case .camPermissionDenied:
                    alertText = """
                                Camera access is denied!\nTo use this app,\
                                 please allow camera access in settings.
                                """
                case .noCaptureDevices:
                    alertText = "There are no compatible cameras in your device."
                default:
                    alertText = "An unexpected error occurred while processing image data"
                }
            }
        }
    }
    
    /// Update the puppetInput when the output change.
    private func updatePuppetInput(controlPointDict: [ControlPoint : CGPoint]) {
        self.puppetInput1.update(
            pointA: handPoseDetectorOutput.criticalPoints[0], 
            pointB: handPoseDetectorOutput.criticalPoints[1],
            refDistance: handPoseDetectorOutput.refDistances[0],
            controlPointDict: controlPointDict)
        
        self.puppetInput2.update(
            pointA: handPoseDetectorOutput.criticalPoints[0], 
            pointB: handPoseDetectorOutput.criticalPoints[1],
            refDistance: handPoseDetectorOutput.refDistances[0],
            controlPointDict: controlPointDict)
        
//        print("MeanFilter: \(self.puppetInput1.pinchPos ?? .zero)")
//        print("no-filter: \(self.puppetInput2.pinchPos ?? .zero)")
    }
    
    private func getControlPointDict() -> [ControlPoint : CGPoint] {
        var dict: [ControlPoint : CGPoint] = .init()
        let puppetNode = puppetScene.puppetNode

        let pLFootInScene = puppetNode.pBody.convert(puppetNode.pLFoot.position, to: self.puppetScene)
        let pRFootInScene = puppetNode.pBody.convert(puppetNode.pRFoot.position, to: self.puppetScene)
        let pLHandInScene = puppetNode.pLHand.convert(puppetNode.pLHandJ.position, to: self.puppetScene)
        let pRHandInScene = puppetNode.pRHand.convert(puppetNode.pRHandJ.position, to: self.puppetScene)
        
        dict[.leftFoot] = self.puppetScene.convertPoint(toView: pLFootInScene)
        dict[.leftHand] = self.puppetScene.convertPoint(toView: pLHandInScene)
        dict[.rightFoot] = self.puppetScene.convertPoint(toView: pRFootInScene)
        dict[.rightHand] = self.puppetScene.convertPoint(toView: pRHandInScene)
        
        return dict
    }
    
    private func resetAllControlPointColor() {
        let puppetNode = puppetScene.puppetNode

        puppetNode.pLHandJ.fillColor = .red
        puppetNode.pRHandJ.fillColor = .red
        puppetNode.pLFootJ.fillColor = .red
        puppetNode.pRFootJ.fillColor = .red
    }
    
    private func handlePuppetInput(puppetInput: PuppetInput) {
        let puppetNode = puppetScene.puppetNode

        resetAllControlPointColor()
        guard let pinchPos = puppetInput.pinchPos else {
            return 
        }
        let pinchPosInSK = self.puppetScene.convertPoint(fromView: pinchPos)
        
        let reachAction: SKAction!
        var reachNode: SKShapeNode
        
        switch puppetInput.controlPoint {
        case .none:
            print("no control point")
            return
        case .rightHand:
            print("control point is right hand")
            reachNode = puppetNode.pRHandJ
            reachAction = SKAction.reach(to: pinchPosInSK, rootNode: puppetNode.pRArm, duration: spViewModel.IKDuration)
        case .leftHand:
            print("control point is left hand")
            reachNode = puppetNode.pLHandJ
            reachAction = SKAction.reach(to: pinchPosInSK, rootNode: puppetNode.pLArm, duration: spViewModel.IKDuration)
        case .rightFoot:
            reachNode = puppetNode.pRFootJ
            reachAction = SKAction.reach(to: pinchPosInSK, rootNode: puppetNode.pRLeg, duration: spViewModel.IKDuration)
        case .leftFoot:
            reachNode = puppetNode.pLFootJ
            reachAction = SKAction.reach(to: pinchPosInSK, rootNode: puppetNode.pLLeg, duration: spViewModel.IKDuration)
        }
        
        reachNode.fillColor = .green
        reachNode.run(reachAction)
    }
    
}
