//
//  HandPoseDetectorHelperView.swift
//  
//
//  Created by Li Zhicheng on 2024/1/19.
//

import Foundation
import SwiftUI


struct HandPoseDetectorHelperView: View {
    @EnvironmentObject var spViewModel: SPViewModel
    @EnvironmentObject var handPoseDetectorOutput: VisionHandPoseDetectorOutput
    
    var body: some View {
        ZStack {
            // Draw circle for each joint in each hand
            ForEach(0..<(handPoseDetectorOutput.detectedHandNum*handPoseDetectorOutput.jointNames.count), id: \.self) { index in
                if let p = handPoseDetectorOutput.criticalPoints[index] {
                    Circle()
                        .fill(.blue)
                        .frame(width: 20)
                        .position(p)
                        .onAppear(perform: {
                            print(p)
                            print("detected hand num \(handPoseDetectorOutput.detectedHandNum)")
                        })
                }
            }
            
        }
    }
}
