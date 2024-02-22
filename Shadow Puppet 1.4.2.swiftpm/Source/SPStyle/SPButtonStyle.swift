//
//  SPButtonStyle.swift
//  
//
//  Created by Li Zhicheng on 2024/2/6.
//

import SwiftUI

struct SPButtonStyle: ButtonStyle {
    @EnvironmentObject var spViewModel: SPViewModel

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
                .font(spViewModel.shadowFontBody)
                .kerning(10)
                .padding(.all)
                .background(Color("shadow"))
                .foregroundStyle(.white)
                .clipShape(Rectangle())
                .blur(radius: 3)
                .shadow(radius: 3)
                .opacity(0.9)
            
            configuration.label
                .font(spViewModel.shadowFontBody)
                .kerning(10)
                .foregroundStyle(.white)
                .blur(radius: 0.6)
        }
        .rotation3DEffect(.degrees(3), axis: (x: 0.0, y: 1.0, z: 0.0))
        .blendMode(.luminosity)


    }
}
