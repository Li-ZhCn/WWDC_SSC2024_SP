//
//  CaptionView.swift
//  
//
//  Created by Li Zhicheng on 2024/2/19.
//

import Foundation
import SwiftUI

struct CaptionView: View {
    @EnvironmentObject var spViewModel: SPViewModel
    @State private var animateOnScreen: Bool = false
    
    @State private var showA: Bool = false
    
    var body: some View {
        ZStack() {
            if animateOnScreen {
                if showA {
                    Text(spViewModel.captionText ?? "...")
                        .font(spViewModel.shadowFontBody)
                        .background(Color("shadow"))
                        .foregroundColor(.white)
                        .padding()
                        .blendMode(.luminosity)
                        .supported(by: .doubleStick, offsetX: 100, offsetY: 0, angle: 120, blur: false)
                        .transition(.asymmetric(insertion: .offset(x: -50, y: -spViewModel.screenSize.height * 0.3), removal: .offset(x: -100, y: -spViewModel.screenSize.height * 0.3)))
                } else {
                    Text(spViewModel.captionText ?? "...")
                        .font(spViewModel.shadowFontBody)
                        .background(Color("shadow"))
                        .foregroundColor(.white)
                        .padding()
                        .blendMode(.luminosity)
                        .supported(by: .doubleStick, offsetX: 100, offsetY: 0, angle: 120, blur: false)
                        .transition(.asymmetric(insertion: .offset(x: -50, y: -spViewModel.screenSize.height * 0.4), removal: .offset(x: 100, y: -spViewModel.screenSize.height * 0.3)))
                }
                
            }
        }
        .padding(100)
        .padding()
//        .frame(maxWidth: spViewModel.screenSize.width, maxHeight: spViewModel.screenSize.height)
        .onChange(of: spViewModel.captionText) { captionText in
            guard let text = captionText else {
                withAnimation(spViewModel.animationQuick) {
                    animateOnScreen = false
                }
                return
            }
            
            if showA {
                withAnimation(spViewModel.animationQuick) {
                    showA = true
                }
            } else {
                withAnimation(spViewModel.animationQuick) {
                    showA = true
                }
            }
            
            if animateOnScreen == false {
                withAnimation(spViewModel.animationQuick.delay(1.2)) {
                    animateOnScreen = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
                withAnimation(spViewModel.animationQuick) {
                    if text == spViewModel.captionText {
                        animateOnScreen = false
                    }
                }
            })
        }
    }
}
