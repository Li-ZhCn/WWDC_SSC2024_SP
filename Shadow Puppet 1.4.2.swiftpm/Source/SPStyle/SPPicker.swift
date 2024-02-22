//
//  SPPicker.swift
//
//
//  Created by Li Zhicheng on 2024/2/18.
//

import Foundation
import SwiftUI

enum VerticalShapePickerType {
    case none
    case hat
    case head
    case body
    case leg
    case arm
}

struct SPImagePicker: View {
    @EnvironmentObject var spViewModel: SPViewModel

    var pickerType: VerticalShapePickerType
    @State var allItem: [String]
    @Binding var chosenItem: String
    
    @State var allItemStatus: [String : Bool] = .init()
        
    var body: some View {
        Picker("Picker", selection: $chosenItem) {
            ForEach(allItem, id: \.self) { item in
                getImage(item)
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 3)
                        .blendMode(.multiply)
                        .tag(item)
                        .supported(by: .singleStick, offsetX: 0, offsetY: 0, angle: -90, stickWidth: 0.5, blur: false)
                        .offset(x: (allItemStatus[item] ?? false) ? -5 : 5)
                        .scaleEffect((allItemStatus[item] ?? false) ? 1.4 : 1)
                        .sway(amplitude: 2, interval: 3)
                        .onAppear() {
                            allItemStatus[item] = false
                        }
                        .onChange(of: chosenItem) { _ in
                            spViewModel.learningTexts[spViewModel.pickerTypeIndex[pickerType]!] = spViewModel.learningPlayerPuppetDict[pickerType]![chosenItem]!
                            // MARK: Why no effect???
                            withAnimation(spViewModel.animationGeneral) {
                                if chosenItem == item {
                                    allItemStatus[item] = true                                    
                                } else {
                                    allItemStatus[item] = false
                                }
                            }
                        }
            }
        }
        .pickerStyle(.wheel)
        .labelsHidden()
        .scaledToFit()
        .scaleEffect(5)
        .frame(width: spViewModel.screenSize.width * 0.5, height: spViewModel.screenSize.height)
        .offset(x: -spViewModel.screenSize.width * 0.1)
        .clipped()
        .transition(.asymmetric(insertion: .offset(x: 500, y: -500), removal: .offset(x: 500, y: 500)))

    }
    
    // MARK: This is not useful now
    private func getImage(_ item: String) -> Image {
        if item == "empty" { return Image(systemName: "circle.slash") }
        switch self.pickerType {
        case .hat:
            return Image(item)
        case .arm:
            return Image("hand" + (item.last?.description ?? "1") + "a")
        case .none:
            return Image(systemName: "exclamationmark.square")
        case .head:
            return Image(item)
        case .body:
            return Image(item)
        case .leg:
            return Image(item + "a")
        }
    }
}

enum VerticalTextPickerType {
    case none
    case camOpacity
    case backgroundColor
    case gravity
}

struct SPTextPicker: View {
    @EnvironmentObject var spViewModel: SPViewModel

    var pickerType: VerticalTextPickerType
    @State var allItem: [String]
    @Binding var chosenItem: String

    @State var allItemStatus: [String : Bool] = .init()
        
    var body: some View {
        Picker("Picker", selection: $chosenItem) {
            ForEach(allItem, id: \.self) { item in
                SPText(text: item, font: spViewModel.shadowFontSmall, blurRadius: 0, padding: 2)
//                    .padding()
                        .tag(item)
                        .supported(by: .singleStick, offsetX: 0, offsetY: 0, angle: -90, stickWidth: 0.5, blur: false)
                        .offset(x: (allItemStatus[item] ?? false) ? -5 : 5)
                        .scaleEffect((allItemStatus[item] ?? false) ? 0.7 : 0.5)
                        .sway(amplitude: 2, interval: 3)
                        .onAppear() {
                            allItemStatus[item] = false
                        }
                        .onChange(of: chosenItem) { _ in
                            // MARK: Why no effect???
                            withAnimation(spViewModel.animationGeneral) {
                                if chosenItem == item {
                                    allItemStatus[item] = true
                                } else {
                                    allItemStatus[item] = false
                                }
                            }
                        }
            }
        }
        .pickerStyle(.wheel)
        .labelsHidden()
        .scaledToFit()
        .scaleEffect(4)
        .frame(width: spViewModel.screenSize.width * 0.5, height: spViewModel.screenSize.height)
//        .offset(x: -spViewModel.screenSize.width * 0.1)
        .clipped()
        .shadow(radius: 3)
        .transition(.asymmetric(insertion: .offset(x: 500, y: -500), removal: .offset(x: 500, y: 500)))

    }
    
}
