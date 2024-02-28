//
//  SwiftUIView.swift
//  
//
//  Created by Li Zhicheng on 2024/2/23.
//

import SwiftUI

struct BlurView: View {
    @EnvironmentObject var spViewModel: SPViewModel
    @State var animateOnScreen: Bool = false
    
    var body: some View {
        VStack {
            if animateOnScreen {
                Color.yellow.opacity(0.1)
                    .ignoresSafeArea()
                    .background(.regularMaterial)
                    .opacity(0.8)
                    .transition(.move(edge: .top))
                                
            }
        }.onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                withAnimation(spViewModel.animationGeneral) {
                    animateOnScreen = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 33) {
                withAnimation(spViewModel.animationGeneral) {
                    spViewModel.puppetBlur = 10
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 33) {
                withAnimation(spViewModel.animationGeneral) {
                    spViewModel.puppetBlur = 3
                }
            }
        }.transition(.move(edge: .top))
    }
}

