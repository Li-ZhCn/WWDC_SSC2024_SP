//
//  MenuSettingView.swift
//  
//
//  Created by Li Zhicheng on 2024/2/18.
//

import Foundation
import SwiftUI


struct MenuSettingView: View {
    @EnvironmentObject var spViewModel: SPViewModel
    @State var buttonState: [VerticalTextPickerType : Bool] = .init()

    @State private var animateOnScreen: Bool = false
    @State private var forward: Int = 1
    
    var body: some View {
        VStack {
            if animateOnScreen {
                VStack {
                    Button(action: {
                        
                    }, label: {
                        Text(" Setting ")
                    })
                    .buttonStyle(SPButtonStyle())
                    
                    getSPButton(type: .camOpacity, text: "Camera Opacity")
                    getSPButton(type: .backgroundColor, text: "Background")
                    getSPButton(type: .gravity, text: "Gravity")
                    
                    VStack {
                        Button(action: {
                            withAnimation(spViewModel.animationQuick) {
                                spViewModel.verticalTextPickerType = .none
                            }
                            withAnimation(spViewModel.animationQuick.delay(0.5)) {
                                animateOnScreen = false
                            }
                            forward = 2
                            
                        }, label: {
                            Label("To learn more", systemImage: "lightbulb")
                        })
                        .buttonStyle(SPButtonStyle())
                        
                        Button(action: {
                            withAnimation(spViewModel.animationQuick) {
                                spViewModel.verticalTextPickerType = .none
                            }
                            withAnimation(spViewModel.animationQuick.delay(0.5)) {
                                animateOnScreen = false
                            }
                            forward = 0

                        }, label: {
                            Label("Workshop", systemImage: "arrowshape.left")
                        })
                        .buttonStyle(SPButtonStyle())
                        
                        Button(action: {
                            withAnimation(spViewModel.animationQuick) {
                                spViewModel.verticalTextPickerType = .none
                            }
                            withAnimation(spViewModel.animationQuick.delay(0.5)) {
                                animateOnScreen = false
                            }
                            forward = 1
                        }, label: {
                            Label("Play", systemImage: "arrowshape.right")
                        })
                        .buttonStyle(SPButtonStyle())
                    }
                    
                }
                .supported(by: .doubleStick, offsetX: 50, offsetY: 250, angle: 180)
//                .offset(x: -400)
                .sway()
                .transition(.asymmetric(insertion: .offset(x: -600, y: -600), removal: .offset(x: -600, y: 600)).combined(with: .scale(scale: 5)).combined(with: .opacity))
                .onDisappear() {
                    if forward == 1 {
                        spViewModel.menuType = .play
                    } else if forward == 0 {
                        spViewModel.menuType = .shape
                    } else if forward == 2 {
                        spViewModel.menuType = .learning
                    }
                }
            }
        }
        .onAppear() {
            print("setting view outer appeared")
            withAnimation(spViewModel.animationGeneral) {
                animateOnScreen = true
            }
        }
    }
    
    private func getSPButton(type: VerticalTextPickerType, text: String) -> some View {
        Button(action: {
            withAnimation(spViewModel.animationQuick) {
                if spViewModel.verticalTextPickerType == type{
                    spViewModel.verticalTextPickerType = .none
                    return
                }
                spViewModel.verticalTextPickerType = type
            }
        }, label: {
            Text(text)
        })
        .buttonStyle(SPButtonStyle())
        .rotation3DEffect(.degrees(-5), axis: (x: 0, y: 1, z: 0))
        .onAppear() {
            buttonState[type] = false
        }
        .onChange(of: spViewModel.verticalTextPickerType) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                if type == spViewModel.verticalTextPickerType {
                    spViewModel.captionText = spViewModel.settingTextDict[spViewModel.verticalTextPickerType]
                    buttonState[type] = true
                } else {
                    buttonState[type] = false
                }
            }
        }
        .rotation3DEffect((buttonState[type] ?? false) ? .degrees(10) : .zero, axis: (x: 0, y: 1, z: 0))

    }
}
