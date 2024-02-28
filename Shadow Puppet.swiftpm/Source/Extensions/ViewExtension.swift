//
//  ViewExtension.swift
//  
//
//  Created by Li Zhicheng on 2024/2/7.
//

import Foundation
import SwiftUI

extension View {
    func supported(by item: SupportiveItem) -> some View{
        modifier(SupportedEffect(supportiveItem: item))
    }
    
    func supported(by item: SupportiveItem, offsetX: Double, angle: Double) -> some View{
        modifier(SupportedEffect(supportiveItem: item, offsetX: offsetX, angle: angle))
    }
    
    func supported(by item: SupportiveItem, offsetY: Double, angle: Double) -> some View{
        modifier(SupportedEffect(supportiveItem: item, offsetY: offsetY, angle: angle))
    }
    
    func supported(by item: SupportiveItem, offsetX: Double, offsetY: Double, angle: Double, stickWidth: CGFloat = 0.5, blur: Bool = true) -> some View{
        modifier(SupportedEffect(supportiveItem: item, offsetX: offsetX, offsetY: offsetY, angle: angle, stickWidth: stickWidth, blur: blur))
    }
    
    func sway(amplitude: CGFloat, interval: TimeInterval) -> some View{
        modifier(SwayEffect(amplitude: amplitude, interval: interval))
    }
    
    func sway() -> some View{
        modifier(SwayEffect())
    }
    
}
