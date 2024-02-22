//
//  MenuView.swift
//  
//
//  Created by Li Zhicheng on 2024/2/8.
//

import SwiftUI

enum MenuType {
    case none
    case shape
    case setting
    case play
    case learning
}

struct MenuView: View {
    @EnvironmentObject var spViewModel: SPViewModel
    @EnvironmentObject var puppetConfig: PuppetConfig

    var body: some View {
        ZStack {
            switch spViewModel.menuType {
            case .none:
                EmptyView()
            case .shape:
                MenuShapeView()
                    .zIndex(1)
                    .offset(x: -spViewModel.screenSize.width * 0.3)
                SPVerticalShapePickerView()
                    .offset(x: spViewModel.screenSize.width * 0.5)
            case .setting:
                MenuSettingView()
                    .zIndex(1)
                    .offset(x: -spViewModel.screenSize.width * 0.3)
                SPVerticalTextPickerView()
                    .offset(x: spViewModel.screenSize.width * 0.3)
            case .play:
                MenuPlayView()
                    .offset(x: -spViewModel.screenSize.width * 0.3)
            case .learning:
                MenuLearningView().offset(x: -spViewModel.screenSize.width * 0.3)
            }
        }
        .onAppear() {
            print("try play bgm")
            Sounds.loop(sound: "bgm", type: "m4a")
        }
    }
}
