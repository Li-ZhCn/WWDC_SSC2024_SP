//
//  BackgroundView.swift
//
//
//  Created by Li Zhicheng on 2024/2/19.
//

import SwiftUI

struct BackgroundView: View {
    @EnvironmentObject var spViewModel: SPViewModel
    @State var animate: Bool = false
    
    var body: some View {
        ZStack {
            spViewModel.backgroundColorDict[spViewModel.backgroundColor]
                .hueRotation(.degrees(animate ? 20 : 0))
                .onAppear() {
                    withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                        animate.toggle()
                    }
                }
//            Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
        }.ignoresSafeArea(.all)
            .background(GeometryReader { proxy in
                Color.clear.onAppear() {
                    spViewModel.screenSize = proxy.size
                }
            })
    }
}
