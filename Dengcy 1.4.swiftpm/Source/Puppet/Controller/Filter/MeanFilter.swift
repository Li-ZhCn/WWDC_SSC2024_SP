//
//  MeanFilter.swift
//
//
//  Created by Li Zhicheng.
//

import Foundation
import Accelerate

/// This mean filter is specifically designed for CGFloat
public struct MeanFilterCG: FilterCG {
    private let windowSize: Int
    private let data: [Double]
    public var predictValue: CGFloat
    
    init(preditValue: CGFloat, windowSize: Int, data: [Double]) {
        self.predictValue = preditValue
        self.windowSize = windowSize
        self.data = data
    }
    
    init(windowSize: Int) {
        self.init(preditValue: 0, windowSize: windowSize, data: [])
    }
    
    init() {
        self.init(preditValue: 0, windowSize: 2, data: [])
    }
    
    
    func predict(input: CGFloat) -> FilterCG {
        var newData = self.data + [Double(input)]
        if newData.count > self.windowSize {
            newData.remove(at: newData.startIndex)
        }

        let mean = vDSP.mean(newData)
    
        return MeanFilterCG(preditValue: mean, windowSize: windowSize, data: newData)
    }
}
