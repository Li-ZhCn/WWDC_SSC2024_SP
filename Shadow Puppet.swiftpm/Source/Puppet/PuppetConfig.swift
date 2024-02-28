//
//  PuppetConfig.swift
//  
//
//  Created by Li Zhicheng on 2024/2/12.
//

import Foundation
import SwiftUI
import SpriteKit


class PuppetConfig: ObservableObject {
    @Published var status = UUID()
    var hat: String = "hat1" {
        didSet {
            status = UUID()
        }
    }
    
    var head: String = "head1" {
        didSet {
            status = UUID()
        }
    }
    
    var body: String = "body1" {
        didSet {
            status = UUID()
        }
    }
    
    private(set) var armA = "arm1a"
    private(set) var handA = "hand1a"
    
    var arm: String = "arm1" {
        didSet {
            status = UUID()
            armA = arm + "a"
            handA = "hand" + arm.last!.description + "a"
        }
    }

    private(set) var legA = "leg1a"
    private(set) var legB = "leg1b"
    private(set) var foot = "foot1"

    var leg: String = "leg1" {
        didSet {
            status = UUID()
            legA = leg + "a"
            legB = leg + "b"
            foot = "foot" + leg.last!.description
        }
    }
    
}
