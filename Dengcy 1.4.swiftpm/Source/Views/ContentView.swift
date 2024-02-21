//
//  ContentView.swift
//
//
//  Created by Li Zhicheng.
//

import SwiftUI

struct ContentView: View {
    var textValue: CGFloat = 120
    @State var show: Bool = false
    @State var textnum: CGFloat = 0
    
    @StateObject var spViewModel: SPViewModel = SPViewModel()
    @StateObject var puppetConfig = PuppetConfig()

    var body: some View {
        ZStack {

            BackgroundView()
//            Color.white
            CaptionView()

            if spViewModel.finishedOnBoarding {
                PuppetView()
                MenuView()
            } else {
                OnBoardingView()
            }
            
        }.environmentObject(spViewModel)
            .environmentObject(puppetConfig)
    }
}
