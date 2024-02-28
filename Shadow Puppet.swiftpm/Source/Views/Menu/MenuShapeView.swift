//
//  MenuShapeView.swift
//  
//
//  Created by Li Zhicheng on 2024/2/18.
//

import Foundation
import SwiftUI

struct MenuShapeView: View {
    @EnvironmentObject var spViewModel: SPViewModel
    @EnvironmentObject var puppetConfig: PuppetConfig
    
    @State private var animateOnScreen: Bool = false
    @State var buttonState: [VerticalShapePickerType : Bool] = .init()

    var body: some View {
        VStack {
            if animateOnScreen {
                VStack {
                    Button(action: {
                        
                    }, label: {
                        Label("WORKSHOP: ", image: "tshirt")
                    })
                    .buttonStyle(SPButtonStyle())
                    
                    getSPButton(type: .hat, text: "Hat")
                    getSPButton(type: .head, text: "Head")
                    getSPButton(type: .body, text: "Body")
                    getSPButton(type: .arm, text: "Arm")
                    getSPButton(type: .leg, text: "Leg")
                    
                    Button(action: {
                        print("button was tapped")
                        
                        withAnimation(spViewModel.animationQuick) {
                            spViewModel.verticalShapePickerType = .none
                        }
                        withAnimation(spViewModel.animationQuick.delay(0.5)) {
                            animateOnScreen = false
                        }
                        
                    }, label: {
                        Label("To learn more", systemImage: "arrowshape.right")
//                        Image(systemName: "arrowshape.right")
                    })
                    .clipShape(RoundedRectangle(cornerSize: .init(width: 10, height: 10)))
                    .buttonStyle(SPButtonStyle())
                }
                .supported(by: .singleStick, offsetY: 250, angle: 180)
                .sway()
                .transition(.asymmetric(insertion: .offset(x: -600, y: -600), removal: .offset(x: -600, y: 600)).combined(with: .scale(scale: 5)).combined(with: .opacity))
                .onDisappear() {
                    print("Shape View inner disappeared")
                    spViewModel.menuType = .learning
                }
            }
        }
        .onAppear() {
            withAnimation(spViewModel.animationGeneral.delay(1)) {
                animateOnScreen = true
            }
            withAnimation(spViewModel.animationQuick) {
                spViewModel.captionText = "Let's design our own puppet now!"
            }
        }

    }
    
    private func getSPButton(type: VerticalShapePickerType, text: String) -> some View {
        Button(action: {
            withAnimation(spViewModel.animationQuick) {
                if spViewModel.verticalShapePickerType == type{
                    spViewModel.verticalShapePickerType = .none
                    return
                }
                spViewModel.verticalShapePickerType = type
            }
        }, label: {
            Text(text)
        })
        .buttonStyle(SPButtonStyle())
        .rotation3DEffect(.degrees(-5), axis: (x: 0, y: 1, z: 0))
        .onAppear() {
            buttonState[type] = false
        }
        .onChange(of: spViewModel.verticalShapePickerType) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                if type == spViewModel.verticalShapePickerType {
                    spViewModel.captionText = spViewModel.shapeTextDict[spViewModel.verticalShapePickerType]
                    buttonState[type] = true
                } else {
                    buttonState[type] = false
                }
            }
        }
        .rotation3DEffect((buttonState[type] ?? false) ? .degrees(30) : .zero, axis: (x: 0, y: 1, z: 0))

    }
    
}
