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
            
            if spViewModel.finishedOnBoarding {
                PuppetView()
                MenuView()
            } else {
                OnBoardingView()
            }
            CaptionView()
        }.environmentObject(spViewModel)
            .environmentObject(puppetConfig)
    }
}
