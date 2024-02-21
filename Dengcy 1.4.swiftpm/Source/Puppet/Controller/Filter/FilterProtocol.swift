//
//  FilterProtocol.swift
//
//
//  Created by Li Zhicheng.
//


import Foundation

/// These filters are used to smooth the input of CGFloat (distance)
protocol FilterCG {
    var predictValue: CGFloat { get }
    func predict(input: CGFloat) -> FilterCG
}
