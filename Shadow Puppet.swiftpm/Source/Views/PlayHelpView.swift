//
//  SwiftUIView.swift
//  
//
//  Created by Li Zhicheng on 2024/2/23.
//

import SwiftUI

struct PlayHelpView: View {
    @EnvironmentObject var spViewModel: SPViewModel

    @State private var animatedOnscreen = false
    @State private var isShowingPopover = false
    
    var body: some View {
        HStack() {
            Spacer()
            
            Button(action: {
                isShowingPopover.toggle()
            }, label: {
                Text("?").font(spViewModel.shadowFontBody)
            })
            .buttonStyle(.bordered)
            .padding()
            .clipShape(Circle())
            .transition(.move(edge: .trailing))
            .popover(isPresented: $isShowingPopover, content: {
                PlayHelpContentView()
                    .frame(width: spViewModel.screenSize.width * 0.6, alignment: .leadingFirstTextBaseline)
                
            })
        }
//        .frame(maxWidth: spViewModel.screenSize.width, maxHeight: spViewModel.screenSize.height)
//        .offset(x: spViewModel.screenSize.width * 0.45, y: -spViewModel.screenSize.height * 0.45)
    }
}


struct PlayHelpContentView: View {
//    @EnvironmentObject var spViewModel: SPViewModel

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text("FAQ:").font(.largeTitle).padding()
                Text("Why did I fail to manipulate my puppet?").font(.title2)
                Text("1.Check the camera permission. Camera will be used to detect your hand.")
                Text("2.Check the screen orientation. This playground should be run on iPad in landscape orientation. (Note that camera is on the left size)")
                Text("3.Keep a suitable distance from the screen. Being to close to the camera may lead to failures of hand detection. Being to far will increase the difficulty of detection.")
                Text("4.Use in a well-lit environment.")
                Image("helpImg1").resizable().scaledToFit().padding()
                
                Text("Why cannot I hear background music?").font(.title2)
                Text("Try restart. If still fail, maybe you can re-add music in the root folder to the Resourse.")
                
                Text("Why cannot I see the caption?").font(.title2).padding(.top)
                Text("Try restart.")
            }
        }.padding()
    }
}
