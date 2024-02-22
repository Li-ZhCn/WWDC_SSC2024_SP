//
//  OnBoardingView.swift
//  
//
//  Created by Li Zhicheng on 2024/2/7.
//

import SwiftUI

struct OnBoardingView: View {
    @EnvironmentObject var spViewModel: SPViewModel
    
    @State var animateOnScreen: Bool = false

    var body: some View {
        ZStack {
            if animateOnScreen {
                SPText(text: "SHADOW", font: spViewModel.shadowFontTitle)
                    .supported(by: .doubleStick)
                    .offset(x: 0, y: -100)
                    .sway()
                    .transition(.move(edge: .top).combined(with: .scale(scale: 5)).combined(with: .opacity))
                
                SPText(text: "PUPPET", font: spViewModel.shadowFontTitle)
                    .supported(by: .doubleStick)
//                    .offset(x: 0, y: 0)
                    .sway()
                    .transition(.move(edge: .top).combined(with: .scale(scale: 5)).combined(with: .opacity))
                
                Button(action: {
                    print("OnBoardingFinished")
                    Sounds.play(sound: "gong", type: "m4a")
                    withAnimation(spViewModel.animationQuick) {
                        self.animateOnScreen = false
                    }
                    
                }, label: {
                    Text("Tap to create your own puppet!")
                })
                .buttonStyle(SPButtonStyle())
                .supported(by: .singleStick)
                .supported(by: .doubleStick, offsetX: 300, angle: 15)
                .offset(x: 0, y: 100)
//                .sway()
                .transition(.move(edge: .bottom).combined(with: .scale(scale: 5)).combined(with: .opacity))
                .onDisappear() {
                    spViewModel.finishedOnBoarding = true
                    spViewModel.menuType = .shape
                }
            }
            
        }.onAppear() {
            Sounds.play(sound: "drum", type: "m4a")
            withAnimation(spViewModel.animationSlow) {
                self.animateOnScreen = true
            }
        }
    }
}
