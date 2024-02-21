//
//  SwayEffect.swift
//  
//
//  Created by Li Zhicheng on 2024/2/16.
//

import Foundation
import SwiftUI
import Combine

struct SwayEffect: ViewModifier {
    @State private var dx: CGFloat = 0
    @State private var dy: CGFloat = 0
    
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    let amplitude: CGFloat
    let interval: TimeInterval
    
    init(dx: CGFloat, dy: CGFloat, amplitude: CGFloat, interval: TimeInterval) {
        self.dx = dx
        self.dy = dy
        self.amplitude = amplitude
        self.interval = interval
        
        self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()

    }
    
    init(amplitude: CGFloat, interval: TimeInterval) {
        self.dx = 0
        self.dy = 0
        self.amplitude = amplitude
        self.interval = interval
        
        self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()

    }
    
    init() {
        self.dx = 0
        self.dy = 0
        self.amplitude = 20
        self.interval = 3
        
        self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()

    }
    
    func body(content: Content) -> some View {
        content
            .offset(x: dx, y: dy)
            .onReceive(timer) { _ in
                withAnimation(.easeInOut(duration: interval)) {
                    dx = CGFloat.random(in: -amplitude ..< amplitude)
                    dy = CGFloat.random(in: -amplitude ..< amplitude)
                }
            }
    }
}
