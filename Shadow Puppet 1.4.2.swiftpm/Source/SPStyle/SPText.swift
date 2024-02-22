//
//  SPText.swift
//  
//
//  Created by Li Zhicheng on 2024/2/7.
//

import SwiftUI


struct SPText: View {
    @State var text: String
    let font: Font
    let blurRadius: Double
    
    let padding: CGFloat

    @EnvironmentObject var spViewModel: SPViewModel
    
    init(text: String, font: Font) {
        self.text = text
        self.font = font
        self.blurRadius = 3
        self.padding = 10
    }
    
    init(text: String, font: Font, blurRadius: Double, padding: CGFloat) {
        self.text = text
        self.font = font
        self.blurRadius = blurRadius
        self.padding = padding
    }
    
    var body: some View {
        if blurRadius == 0 {
            ZStack {
                Text(text)
                    .font(font)
                    .kerning(padding)
                    .padding(.all)
                    .background(Color("shadow"))
                    .foregroundStyle(.white)
                    .clipShape(Rectangle())
                    .shadow(radius: 3)
                    .opacity(0.9)
                
                Text(text)
                    .font(font)
                    .kerning(10)
                    .foregroundStyle(.white)
            }
//            .rotation3DEffect(.degrees(0), axis: (x: 0.0, y: 1.0, z: 0.0))
            .blendMode(.plusDarker)
        } else {
            ZStack {
                Text(text)
                    .font(font)
                    .kerning(10)
                    .padding(.all)
                    .background(Color("shadow"))
                    .foregroundStyle(.white)
                    .clipShape(Rectangle())
                    .blur(radius: blurRadius)
                    .shadow(radius: 3)
                    .opacity(0.9)
                
                Text(text)
                    .font(font)
                    .kerning(10)
                    .foregroundStyle(.white)
                    .blur(radius: 0.6)
            }
            .rotation3DEffect(.degrees(0), axis: (x: 0.0, y: 1.0, z: 0.0))
            .blendMode(.plusDarker)
        }

    }
}

