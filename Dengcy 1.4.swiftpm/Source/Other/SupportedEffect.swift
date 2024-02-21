//
//  SupportedEffect.swift
//  
//
//  Created by Li Zhicheng on 2024/2/7.
//

import Foundation
import SwiftUI

enum SupportiveItem {
    case singleStick
    case doubleStick
}

struct SupportedEffect: ViewModifier {
    let supportiveItem: SupportiveItem
    let offsetX: Double
    let offsetY: Double
    var angle: Double
    
    let stickWidth: CGFloat
    let blur: Bool
    
    init(supportiveItem: SupportiveItem, offsetX: Double, offsetY: Double, angle: Double, stickWidth: CGFloat, blur: Bool) {
        self.supportiveItem = supportiveItem
        self.offsetX = offsetX
        self.offsetY = offsetY
        self.angle = angle
        self.stickWidth = stickWidth
        self.blur = blur
    }
    
    init(supportiveItem: SupportiveItem, offsetY: Double, angle: Double) {
        self.supportiveItem = supportiveItem
        self.offsetX = 0
        self.offsetY = offsetY
        self.angle = angle
        self.stickWidth = 0.5
        self.blur = true
    }
    
    init(supportiveItem: SupportiveItem, offsetX: Double, angle: Double) {
        self.supportiveItem = supportiveItem
        self.offsetX = offsetX
        self.offsetY = 0
        self.angle = angle
        self.stickWidth = 0.5
        self.blur = true
    }
    
    init(supportiveItem: SupportiveItem) {
        self.supportiveItem = supportiveItem
        switch supportiveItem {
        case .singleStick:
            self.offsetX = 0
            self.offsetY = 0
            self.angle = 0
        case .doubleStick:
            self.offsetX = 220
            self.offsetY = 0
            self.angle = 60
        }
        self.stickWidth = 0.5
        self.blur = true
    }
    
    func body(content: Content) -> some View {
        ZStack {
            switch supportiveItem {
            case .singleStick:
                ZStack {
                    SupportiveStick(angle: angle, width: stickWidth, blur: blur)
                        .offset(x: offsetX, y: offsetY)
                }
                
            case .doubleStick:
                ZStack {
                    SupportiveStick(angle: angle, width: stickWidth, blur: blur)
                        .offset(x: -offsetX, y: offsetY)
                    SupportiveStick(angle: -angle, width: stickWidth, blur: blur)
                        .offset(x: offsetX, y: offsetY)
                }
            }
            
            content
        }
    }
}

struct SupportiveStick: View {
    @State var angle: Double = 0
    
    let length: CGFloat
    let width: CGFloat
    
    let blur: Bool
    
    init(angle: Double, length: CGFloat, width: CGFloat, blur: Bool) {
        self.angle = angle
        self.length = length
        self.width = width
        self.blur = blur
    }
    
    init(angle: Double, width: CGFloat, blur: Bool) {
        self.angle = angle
        self.length = 1000
        self.width = 0.5
        self.blur = blur
    }
    
    init(angle: Double) {
        self.angle = angle
        self.length = 1000
        self.width = 0.5
        self.blur = true
    }
    
    var body: some View {
        ZStack {
            if blur {
                RoundedRectangle(cornerSize: .init(width: 2, height: 5))
                    .fill(Color("shadow"))
                    .opacity(0.8)
                    .shadow(radius: 3)
                    .blur(radius: 3)
                    .blendMode(.plusDarker)
                    .frame(width: width, height: length)
                    .offset(x: 0, y: length / 2 + 5)
                    .rotationEffect(.degrees(angle))
            } else {
                RoundedRectangle(cornerSize: .init(width: 2, height: 5))
                    .fill(Color("shadow"))
                    .opacity(0.8)
                    .shadow(radius: 3)
                    .blendMode(.plusDarker)
                    .frame(width: width, height: length)
                    .offset(x: 0, y: length / 2 + 5)
                    .rotationEffect(.degrees(angle))
            }
            

        }
    }
}
