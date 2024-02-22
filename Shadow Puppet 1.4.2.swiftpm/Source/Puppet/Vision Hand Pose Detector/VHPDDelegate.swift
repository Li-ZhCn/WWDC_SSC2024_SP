//
//  VisionHandPoseDetectorVCDelegate.swift
//
//
//  Created by Li Zhicheng.
//

import SwiftUI
import Vision

protocol VisionHandPoseDetectorVCDelegate: AnyObject {
    // Runs when the camera initialization is complete, returning any errors inside the closure
    var onCamInitComplete: (VHPDError?) -> Void { get set }
    
    var jointNames: [VNHumanHandPoseObservation.JointName] { get set }
    var criticalPoints: [CGPoint?] { get set }
    var detectedHandNum: Int { get set }
    var refDistances: [CGFloat?] { get set }
}
