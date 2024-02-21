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
                    SPText(text: (spViewModel.captionText ?? "..."), font: spViewModel.shadowFontBody, blurRadius: 0, padding: 10)
                        .supported(by: .doubleStick, offsetX: 200, offsetY: 0, angle: 120, blur: false)
                        .rotation3DEffect(.degrees(0.1), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .transition(.asymmetric(insertion: .offset(x: -50, y: -200), removal: .offset(x: -100, y: -200)))
                } else {
                    SPText(text: (spViewModel.captionText ?? "..."), font: spViewModel.shadowFontBody, blurRadius: 0, padding: 10)
                        .supported(by: .doubleStick, offsetX: 200, offsetY: 0, angle: 120, blur: false)
                        .rotation3DEffect(.degrees(3), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .transition(.asymmetric(insertion: .offset(x: -50, y: -200), removal: .offset(x: 100, y: -200)))
                }
                
            }
        }
        .padding(100)
        .padding()
        .blendMode(.overlay)
        .offset(y: -(spViewModel.screenSize.height * 0.4))
        .onChange(of: spViewModel.captionText) { captionText in
            guard let text = captionText else {
                withAnimation(spViewModel.animationQuick) {
                    animateOnScreen = false
                }
                return
            }
            
            if showA {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(spViewModel.animationQuick) {
                        showA = false
                    }
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(spViewModel.animationQuick) {
                        showA = true
                    }
                }
            }
            
            if animateOnScreen == false {
                withAnimation(spViewModel.animationQuick.delay(1.2)) {
                    animateOnScreen = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 7, execute: {
                withAnimation(spViewModel.animationQuick) {
                    if text == spViewModel.captionText {
                        animateOnScreen = false
                    }
                }
            })
        }
    }
}
