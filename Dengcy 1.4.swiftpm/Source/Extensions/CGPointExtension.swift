//
//  CGPointExtension.swift
//
//
//  Created by Li Zhicheng on 2023/9/30.
//

import SwiftUI

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow((point.x - x), 2) + pow((point.y - y), 2))
    }
    
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    } 
    
    static func *(lhs: CGPoint, rhs: Double) -> CGPoint {
        return CGPointMake(lhs.x * CGFloat(rhs), lhs.y * CGFloat(rhs))
    } 
    
    static func /(lhs: CGPoint, rhs: Int) -> CGPoint {
        return CGPointMake(lhs.x / CGFloat(rhs), lhs.y / CGFloat(rhs))
    }
    
    static func /(lhs: CGPoint, rhs: Double) -> CGPoint {
        return CGPointMake(lhs.x / CGFloat(rhs), lhs.y / CGFloat(rhs))
    }
}
