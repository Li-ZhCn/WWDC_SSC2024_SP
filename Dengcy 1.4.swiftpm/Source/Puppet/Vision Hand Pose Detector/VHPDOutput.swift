//
//  VisionHandPoseDetectorOutput.swift
//  
//
//  Created by Li Zhicheng on 2024/1/18.
//

import SwiftUI
import Vision

class VisionHandPoseDetectorOutput: ObservableObject {
    @Published private(set) var status = UUID()
    
    @Published var jointNames: [VNHumanHandPoseObservation.JointName]
    @Published var criticalPoints: [CGPoint?] {
        didSet {
            self.status = UUID()
        }
    }
    @Published var detectedHandNum: Int
    @Published var refDistances: [CGFloat?]
    
    init(jointNames: [VNHumanHandPoseObservation.JointName]) {
        self.jointNames = jointNames
        self.criticalPoints = [CGPoint?](repeating: nil, count: jointNames.count*2)
        self.detectedHandNum = 0
        self.refDistances = [nil, nil]
    }
}
