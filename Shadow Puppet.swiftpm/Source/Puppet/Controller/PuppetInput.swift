//
//  PuppetInput.swift
//
//
//  Created by Li Zhicheng.
//

import SwiftUI

class PuppetInput: ObservableObject {
    @Published var handState: HandState = .unknown
    @Published var pinchPos: CGPoint?
    @Published var controlPoint: ControlPoint = .none
    
    private(set) var distance: CGFloat?
    private var originFilter: FilterCG?
    private var filter: FilterCG?
    private let threshold: CGFloat
    
    init(filter: FilterCG?, threshold: CGFloat) {
        self.threshold = threshold
        
        if let filter = filter {
            self.setFilter(filter: filter)
        }
    }
    
    convenience init() {
        self.init(filter: nil, threshold: 0.2)
    }
    
    func reset() {
        self.handState = .unknown
        self.pinchPos = nil
        self.filter = self.originFilter
    }
    
    /// Set the filter type
    func setFilter(filter: FilterCG) {
        self.originFilter = filter
        self.filter = filter
    }
    
    private func predcitDistance(filter: FilterCG, pointA: CGPoint, pointB: CGPoint) -> FilterCG {
        var distance = pointA.distance(to: pointB)
        let newFilter = filter.predict(input: distance)
        distance = newFilter.predictValue
        return newFilter
    }
    
    /// Update the disdance by new points input
    private func updateDistance(pointA: CGPoint?, pointB: CGPoint?) {
        guard let pointA = pointA,
              let pointB = pointB else { return }
        
        if let filter = filter {
            self.filter = self.predcitDistance(filter: filter, pointA: pointA, pointB: pointB)
            self.distance = filter.predictValue
        } else {
            self.distance = pointA.distance(to: pointB)
        }
    }
    
    /// Update hand state(.unknow, .pinched, .notPinched) and control point
    private func updateState(refDistance: CGFloat?, controlPointDict: [ControlPoint : CGPoint]) {
        guard let refDistance = refDistance,
              let distance = self.distance else { 
            self.handState = .unknown
            self.controlPoint = .none
            return
        }
        
        let norm = distance / refDistance
        if norm < self.threshold {
            if self.handState != .pinched || (self.handState == .pinched && self.controlPoint == .none) {
                updateControlPoint(pinchPos: self.pinchPos, controlPoints: controlPointDict)
            }
            self.handState = .pinched
        } else {
            self.handState = .notPinched
            self.controlPoint = .none
        }
        print("become \(self.handState)")
    }
    
    /// Get the position pinched on screen
    private func updatePinchPos(pointA: CGPoint?, pointB: CGPoint?) {
        guard let pointA = pointA,
              let pointB = pointB else { return }
        
        if self.handState == .pinched {
            self.pinchPos = (pointA + pointB) * 0.5
        } else {
            self.pinchPos = nil
        }
    }
    
    func updateControlPoint(pinchPos: CGPoint?, controlPoints: [ControlPoint : CGPoint]) {
        print("try update control point")
        guard let pinchPos = pinchPos else { return }
        var minDis: CGFloat = 100
        var target: ControlPoint = .none
        controlPoints.keys.forEach { key in
            let dis = controlPoints[key]!.distance(to: pinchPos)
            if dis < minDis {
                minDis = dis
                target = key
            }
        }
        print("update control point to: \(target)")
        self.controlPoint = target
    }
    
    public func update(pointA: CGPoint?, pointB: CGPoint?, refDistance: CGFloat?, controlPointDict: [ControlPoint : CGPoint]){
        updateDistance(pointA: pointA, pointB: pointB)
        updateState(refDistance: refDistance, controlPointDict: controlPointDict)
        updatePinchPos(pointA: pointA, pointB: pointB)
    }
}
