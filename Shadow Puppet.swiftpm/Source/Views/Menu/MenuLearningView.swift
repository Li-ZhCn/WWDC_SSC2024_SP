//
//  MenuLearningView.swift
//  
//
//  Created by Li Zhicheng on 2024/2/19.
//

import Foundation
import SwiftUI


struct MenuLearningView: View {
    @EnvironmentObject var spViewModel: SPViewModel
    @State var animateOnScreen: Bool = false
    
    @State var textIndex: Int = 0
    @State var showSettingButton: Bool = false
    
    var body: some View {
        VStack {
            if animateOnScreen {
                VStack {
                    if showSettingButton {
                        Button(action: {
                            withAnimation(spViewModel.animationGeneral) {
                                animateOnScreen = false
                            }
                        }, label: {
                            Label("Setting", systemImage: "arrowshape.right")
                        })
                        .buttonStyle(SPButtonStyle())
                        
                    } else {
                        Button(action: {
                            withAnimation(spViewModel.animationQuick) {
                                textIndex += 1
                            }
                            if textIndex >= (spViewModel.learningTexts.count - 1) {
                                showSettingButton = true
                            }
                        }, label: {
                            Label("Next", systemImage: "arrowshape.right")
                        })
                        .buttonStyle(SPButtonStyle())
                        .onAppear() {
                                withAnimation(spViewModel.animationQuick) {
                                    spViewModel.captionText = spViewModel.learningTexts[0]
                                    spViewModel.focusNodeName = spViewModel.learningTextFocus[0]
                                }
                            }
                        .onChange(of: textIndex) { index in
                            withAnimation(spViewModel.animationQuick) {
                                spViewModel.captionText = spViewModel.learningTexts[index]
                                spViewModel.focusNodeName = spViewModel.learningTextFocus[index]
                            }
                        }
                    }
                }
                .supported(by: .doubleStick, offsetX: 50, offsetY: 250, angle: 180)
//                .offset(x: -400)
                .sway()
                .transition(.asymmetric(insertion: .offset(x: -600, y: -600), removal: .offset(x: -600, y: 600)).combined(with: .scale(scale: 5)).combined(with: .opacity))
                .onDisappear() {
                    textIndex = 0
                    spViewModel.menuType = .setting
                    spViewModel.focusNodeName = nil
                }
            }
        }
        .onAppear() {
            withAnimation(spViewModel.animationGeneral) {
                animateOnScreen = true
            }
        }
        .onDisappear() {
            print("Shape View outer Disappeared")
            withAnimation(spViewModel.animationQuick) {
                spViewModel.captionText = "Now, let's modify some settings, then you can manipulate it with Vision Framework!"
            }
        }
    }
}
