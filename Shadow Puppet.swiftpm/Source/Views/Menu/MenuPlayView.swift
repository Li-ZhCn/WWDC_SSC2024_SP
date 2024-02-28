//
//  MenuPlayView.swift
//  
//
//  Created by Li Zhicheng on 2024/2/18.
//

import Foundation
import SwiftUI

struct MenuPlayView: View {
    @EnvironmentObject var spViewModel: SPViewModel
    @State var animateOnScreen: Bool = false
    
    @State var forward: Bool = true
    
    var body: some View {
        VStack {
            if animateOnScreen {
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation(spViewModel.animationGeneral) {
                                spViewModel.verticalTextPickerType = .none
                                animateOnScreen = false
                            }
                            forward = false
                        }, label: {
                            Image(systemName: "arrowshape.left")
                        })
                        .clipShape(Circle())
                        .buttonStyle(SPButtonStyle())
                        
                        Button(action: {
                            withAnimation(spViewModel.animationGeneral) {
                                spViewModel.verticalTextPickerType = .none
                                animateOnScreen = false
                            }
                            forward = true
                            
                        }, label: {
                            Image(systemName: "tshirt")
                        })
                        .clipShape(Circle())
                        .buttonStyle(SPButtonStyle())
                    }
                    
                }
                .supported(by: .doubleStick, offsetX: 40, offsetY: 250, angle: 180)
//                .offset(x: -400)
                .sway()
                .transition(.asymmetric(insertion: .offset(x: -600, y: -600), removal: .offset(x: -600, y: 600)).combined(with: .scale(scale: 5)).combined(with: .opacity))
                .onDisappear() {
                    if forward {
                        spViewModel.menuType = .shape
                    } else {
                        spViewModel.menuType = .setting
                    }
                }
            }
        }
        .onAppear() {
            withAnimation(spViewModel.animationQuick) {
                animateOnScreen = true
                spViewModel.captionText = "Now, you can see yourself in the camera."
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                if spViewModel.menuType != .play { return }
                withAnimation(spViewModel.animationQuick) {
                    spViewModel.captionText = "Put your hand in front of the camera. You can see your fingers are marked by blue dots."
                }
            }
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
                if spViewModel.menuType != .play { return }
                withAnimation(spViewModel.animationQuick) {
                    spViewModel.captionText = "Pinch your index and thumb finger on the red point of the puppet."
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 18) {
                if spViewModel.menuType != .play { return }
                withAnimation(spViewModel.animationQuick) {
                    spViewModel.captionText = "If success, the red point will turn to green."
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 24) {
                if spViewModel.menuType != .play { return }
                withAnimation(spViewModel.animationQuick) {
                    spViewModel.captionText = "Then keep pinching and move your hand to manipulate your puppet!"
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                if spViewModel.menuType != .play { return }
                withAnimation(spViewModel.animationQuick) {
                    spViewModel.captionText = "Shadow Puppet should be held between a source of light and a translucent screen, so..."
                }
            }
        }
    }
}
