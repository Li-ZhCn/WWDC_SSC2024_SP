//
//  VerticalPickerView.swift
//
//
//  Created by Li Zhicheng on 2024/2/12.
//

import SwiftUI


struct SPVerticalShapePickerView: View {
    @EnvironmentObject var spViewModel: SPViewModel
    @EnvironmentObject var puppetConfig: PuppetConfig
        
    var body: some View {
        ZStack {
            switch spViewModel.verticalShapePickerType {
            case .none:
                EmptyView()
            case .hat:
                SPImagePicker(pickerType: .hat, allItem: ["empty", "hat1", "hat2"], chosenItem: $puppetConfig.hat)
            case .head:
                SPImagePicker(pickerType: .head, allItem: ["head1", "head2", "head3", "head4", "head5"], chosenItem: $puppetConfig.head)
            case .body:
                SPImagePicker(pickerType: .body, allItem: ["body1", "body2", "body3"], chosenItem: $puppetConfig.body)
            case .leg:
                SPImagePicker(pickerType: .leg, allItem: ["leg1", "leg2", "leg3"], chosenItem: $puppetConfig.leg)
            case .arm:
                SPImagePicker(pickerType: .arm, allItem: ["arm1", "arm2", "arm3"], chosenItem: $puppetConfig.arm)
            }
        }
    }
}

struct SPVerticalTextPickerView: View {
    @EnvironmentObject var spViewModel: SPViewModel
//    @EnvironmentObject var puppetConfig: PuppetConfig
        
    var body: some View {
        VStack {
            switch spViewModel.verticalTextPickerType {
            case .none:
                EmptyView()
            case .camOpacity:
                SPTextPicker(pickerType: .camOpacity, allItem: ["Low", "Middle", "High"], chosenItem: $spViewModel.camOpacityStatus)
            case .backgroundColor:
                SPTextPicker(pickerType: .backgroundColor, allItem: ["Evening", "Dawn"], chosenItem: $spViewModel.backgroundColor)
            case .gravity:
                SPTextPicker(pickerType: .gravity, allItem: ["true", "false"], chosenItem: $spViewModel.gravityStatus)
            }
        }
//        .offset(x: 500, y: -50)
    }
}
