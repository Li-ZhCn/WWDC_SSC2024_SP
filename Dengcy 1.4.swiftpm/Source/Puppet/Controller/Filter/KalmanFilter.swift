//
//  KalmanFilter.swift
//
//
//  Created by Li Zhicheng.
//

import Foundation

/// This Kalman filter is specifically designed for CGFloat
public struct KalmanFilterCG: FilterCG {
    private let predictError: CGFloat
    private let measureError: CGFloat
    
    public var predictValue: CGFloat
    
    init(predictError: CGFloat, measureError:CGFloat, preditValue: CGFloat) {
        self.predictError = predictError
        self.measureError = measureError
        self.predictValue = preditValue
    }
    
    init(boundsWidth: CGFloat) {
        self.init(predictError: boundsWidth,
                  measureError: boundsWidth / 30, 
                  preditValue: boundsWidth / 6)
    }
    
    func predict(input: CGFloat) -> FilterCG {
        let K = predictError / (predictError + measureError)
        let newPredictValue = predictValue + K * (input - predictValue)
        let newPredictError = (1 - K) * predictError
        
        return KalmanFilterCG(
            predictError: newPredictError, 
            measureError: measureError, 
            preditValue: newPredictValue)
    }
}
