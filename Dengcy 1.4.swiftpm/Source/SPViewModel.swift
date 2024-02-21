//
//  SPViewModel.swift
//
//
//  Created by Li Zhicheng.
//

import SwiftUI

class SPViewModel: ObservableObject {
    @Published var screenSize: CGSize = UIScreen.main.bounds.size
    
    @Published var finishedOnBoarding: Bool = false
    @Published var menuType: MenuType = .none
    @Published var captionText: String?
    
    @Published var backgroundColor: String = "Evening"
    let backgroundColorDict: [String : LinearGradient] = [
        "Evening" : LinearGradient(colors: [Color("bgEveGrad1"), Color("bgEveGrad2")], startPoint: .leading, endPoint: .trailing),
        "Dawn" : LinearGradient(colors: [Color("bgDawnGrad1"), Color("bgDawnGrad2")], startPoint: .leading, endPoint: .trailing),
        "Forest" : LinearGradient(colors: [Color("bgForestGrad1"), Color("bgForestGrad2")], startPoint: .leading, endPoint: .trailing)
    ]
    
    let shadowFontTitle: Font = .system(size: 64, weight: .black, design: .serif)
        .width(.expanded)
    
    let shadowFontBody: Font = .system(size: 32, weight: .black, design: .serif)
        .width(.expanded)
    
    let shadowFontSmall: Font = .system(size: 8, weight: .black, design: .serif)
        .width(.expanded)
    
    let animationGeneral: Animation = .easeInOut(duration: 5)
    let animationSlow: Animation = .spring(response: 5, dampingFraction: 5, blendDuration: 0.5)
//    let animationGeneral: Animation = .spring(response: 5, dampingFraction: 0.5, blendDuration: 0.5)

//    let animationGeneral: Animation = .interpolatingSpring(stiffness: 20, damping: 10)
    

//    let animationQuick: Animation = .easeInOut(duration: 2)
    let animationQuick: Animation = .interpolatingSpring(stiffness: 20, damping: 8)

    
    @Published var fingerColor: Color = .blue
    @Published var focusNodeName: String?
    @Published var verticalShapePickerType: VerticalShapePickerType = .none {
        didSet {
            switch verticalShapePickerType {
            case .none:
                focusNodeName = nil
            case .hat:
                focusNodeName = "head"
            case .head:
                focusNodeName = "head"
            case .body:
                focusNodeName = "body"
            case .leg:
                focusNodeName = "leg"
            case .arm:
                focusNodeName = "arm"
            }
        }
    }
    
    @Published var verticalTextPickerType: VerticalTextPickerType = .none
    
    @Published var camOpacity: Double = 0.5
    var camOpacityStatus: String = "Middle" {
        didSet {
            if camOpacityStatus == "Low" { camOpacity = 0.2 }
            else if camOpacityStatus == "Middle" { camOpacity = 0.5 }
            else if camOpacityStatus == "High" { camOpacity = 0.8 }
            else { camOpacity = 0.5 }
        }
    }

    @Published var gravity: Bool = true
    var gravityStatus: String = "true" {
        didSet {
            print("did set gravity status \(gravityStatus)")
            if gravityStatus == "true" {
                gravity = true
            } else {
                gravity = false
            }
        }
    }
    
    let IKDuration: Double = 0.5
    
    let shapeTextDict: [VerticalShapePickerType : String] = [
        .hat : "Hat off to you",
        .head : "Put its face on",
        .body : "Clothes make the man",
        .arm : "Choose arms for your puppet",
        .leg: "Choose legs for your puppet"
    ]
    
    let settingTextDict: [VerticalTextPickerType : String] = [
        .camOpacity : "Camera will be used to detect your hand",
        .backgroundColor : "Choose a theme for your background color",
        .gravity : "Whether or not gravity will be applied to your puppet?"
    ]
    
    var learningTexts: [String] = [
    "Do you know how to identify a character's role?",
    "Their clothes and accessories play a crucial role,",
    "not only adding color but also helping audience understand  a character's demeanor and social status",
    "For example,",
    "this headgear comes from a Daoist immortal", //4
    "With raised eyebrows, he is a youngster  with martial arts skills.", // 5
    "This cloth is one kind of miscellaneous items,  which indicates the wearer is a servant or a poor person.",// 6
    "His/Her loose and big sleeves are useful for carrying things.", // 7
    "Robe is convinient and easy to make, so it's  prevalent in ancient China.", // 8
    "With history more than 2000 years, it has been inscribed in 2011 on the Representative List of the Intangible Cultural Heritage of Humanity.",
    "Until now, many shodow puppet makers and players are still providing fresh ideas for this time-honored art.",
    "It is your own shadow puppet.",
    "It is also the common inheritance of the world!"
    ]
    
    let pickerTypeIndex: [VerticalShapePickerType : Int] = [
        .hat : 4,
        .head : 5,
        .body : 6,
        .arm : 7,
        .leg : 8
    ]
    
    let learningTextFocus: [String?] = [
    "head",
    "body",
    nil,
    nil,
    "head",
    "head",
    "body",
    "arm",
    "leg",
    nil,
    nil,
    nil,
    nil
    ]
    
    let learningPlayerPuppetDict: [VerticalShapePickerType : [String : String]] = [
        .hat : [
            "empty" : "your puppet wears no headgear, maybe he/she  was just resting?",
            "hat1" : "this headgear comes from a Daoist immortal",
            "hat2" : "this headgear comes from Hua Wu Sheng,  a character in a play skilled in martial arts"
        ],
        .head : [
            "head1" : "With raised eyebrows, he is a youngster  with martial arts skills.",
            "head2" : "With flat eyebrows, she is a frail woman.",
            "head3" : "With raised eyebrows and tied up hair,  he is a youngster with martial arts skills.",
            "head4" : "With flat eyebrows and grey hair,  he looks like a frail old man.",
            "head5" : "With a painted face, he is an actor  playing martial role in Chinese opras."
        ],
        .body : [
            "body1" : "This cloth is one kind of miscellaneous items,  which indicates the wearer is a servant or a poor person.",
            "body2" : "This robe is carved using a meandering lattice motif.  The Tai-chi symbol on the robe indicates that the wearer is a deity.",
            "body3" : "He/She wears \"Kaozi\", one kind of ancient body armors."
        ],
        .arm : [
            "arm1" : "His/Her loose and big sleeves are useful for carrying things",
            "arm2" : "His/Her cuffs are embellished with lotus flower pattern,  which plays an essential part in Taoism.",
            "arm3" : "His/Her white martial apparel can protect vulnerable parts from injury."
        ],
        .leg : [
            "leg1" : "Robe is convinient and easy to make, so it's  prevalent in ancient China.",
            "leg2" : "This is the lower part of armor, which consists \"Jingjia\"(jambeau) and \"Jiaqun\"(armor skirt)",
            "leg3" : ""
        ]
        
    ]
    
}
