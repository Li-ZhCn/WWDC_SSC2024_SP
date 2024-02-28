//
//  PuppetNode.swift
//
//
//  Created by Li Zhicheng.
//

import SwiftUI
import SpriteKit

class PuppetNode: SKSpriteNode {
    var pBody: SKSpriteNode!
    
    var pHead: SKSpriteNode!
    var pHat: SKSpriteNode!
    
    var pRArm: SKSpriteNode!
    var pRHand: SKSpriteNode!
    
    var pLArm: SKSpriteNode!
    var pLHand: SKSpriteNode!
    
    var pRLeg: SKSpriteNode!
    var pRFoot: SKSpriteNode!

    var pLLeg: SKSpriteNode!
    var pLFoot: SKSpriteNode!
    
    
    var pRHandJ: SKShapeNode!
    var pRArmJ: SKShapeNode!
    
    var pLHandJ: SKShapeNode!
    var pLArmJ: SKShapeNode!
    
    var pRFootJ: SKShapeNode!
    var pLFootJ: SKShapeNode!

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.initPuppet()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initPuppet() {        
        self.pBody = SKSpriteNode(imageNamed: "body1")
        self.pBody.name = "body"
        self.pBody.xScale = 0.1
        self.pBody.yScale = 0.1
//        self.pBody.anchorPoint = .init(x: 0.5, y: 0.5)
//        self.pBody.position = .init(x: 50, y: 50)
        self.addChild(self.pBody)
        
        self.pHead = SKSpriteNode(imageNamed: "head1")
        self.pHead.name = "head"
        self.pHead.xScale = 0.6
        self.pHead.yScale = 0.6
        self.pHead.anchorPoint = .init(x: 0.5, y: 0.1)
        self.pHead.position = .init(x: 0, y: 200)
        self.pHead.zPosition = -1
        self.pBody.addChild(self.pHead)
        
        self.pHat = SKSpriteNode(imageNamed: "hat1")
        self.pHat.name = "hat"
        self.pHat.anchorPoint = .init(x: 0.5, y: 0.1)
        self.pHat.position = .init(x: 0, y: 20)
        self.pHat.zPosition = 1
        self.pHead.addChild(self.pHat)
        
        self.pRArm = SKSpriteNode(imageNamed: "arm1a")
        self.pRArm.name = "arm"
        self.pRArm.xScale = 1
        self.pRArm.yScale = 1
        self.pRArm.anchorPoint = .init(x: 0.8, y: 0.8)
        self.pRArm.position = .init(x: 0, y: 200)
        self.pRArm.zPosition = -1
        self.pBody.addChild(self.pRArm)
        
        self.pRHand = SKSpriteNode(imageNamed: "hand1a")
        self.pRHand.name = "arm"
        self.pRHand.xScale = 0.8
        self.pRHand.yScale = 0.8
        self.pRHand.anchorPoint = .init(x: 0.8, y: 0.2)
        self.pRHand.position = .init(x: -150, y: -150)
        self.pRHand.zPosition = -1
        self.pRArm.addChild(self.pRHand)
        
        self.pLArm = SKSpriteNode(imageNamed: "arm1a")
        self.pLArm.name = "arm"
        self.pLArm.xScale = 1
        self.pLArm.yScale = 1
        self.pLArm.zRotation = CGFloat.pi / 3
        self.pLArm.anchorPoint = .init(x: 0.8, y: 0.8)
        self.pLArm.position = .init(x: 0, y: 200)
        self.pLArm .zPosition = 1
        self.pBody.addChild(self.pLArm)
        
        self.pLHand = SKSpriteNode(imageNamed: "hand1a")
        self.pLHand.name = "arm"
        self.pLHand.xScale = 0.8
        self.pLHand.yScale = 0.8
        self.pLHand.anchorPoint = .init(x: 0.8, y: 0.2)
        self.pLHand.position = .init(x: -150, y: -150)
        self.pLHand .zPosition = -1
        self.pLArm.addChild(self.pLHand)
        
        self.pRLeg = SKSpriteNode(imageNamed: "leg1a")
        self.pRLeg.name = "leg"
        self.pRLeg.xScale = 0.8
        self.pRLeg.yScale = 0.8
        self.pRLeg.anchorPoint = .init(x: 0.5, y: 0.8)
        self.pRLeg.position = .init(x: -10, y: -200)
        self.pRLeg.zPosition = -1
        self.pBody.addChild(self.pRLeg)
        
        self.pRFoot = SKSpriteNode(imageNamed: "foot1")
        self.pRFoot.name = "leg"
        self.pRFoot.xScale = 1
        self.pRFoot.yScale = 1
        self.pRFoot.anchorPoint = .init(x: 0.5, y: 0.5)
        self.pRFoot.position = .init(x: -30, y: -300)
        self.pRFoot.zPosition = -1
        self.pRLeg.addChild(self.pRFoot)
        
        self.pLLeg = SKSpriteNode(imageNamed: "leg1b")
        self.pLLeg.name = "leg"
        self.pLLeg.xScale = 0.8
        self.pLLeg.yScale = 0.8
        self.pLLeg.anchorPoint = .init(x: 0.5, y: 0.8)
        self.pLLeg.position = .init(x: 60, y: -200)
        self.pLLeg.zPosition = -2
        self.pBody.addChild(self.pLLeg)
        
        self.pLFoot = SKSpriteNode(imageNamed: "foot1")
        self.pLFoot.name = "leg"
        self.pLFoot.xScale = 1
        self.pLFoot.yScale = 1
        self.pLFoot.anchorPoint = .init(x: 0.5, y: 0.5)
        self.pLFoot.position = .init(x: 60, y: -300)
        self.pLFoot.zPosition = -1
        self.pLLeg.addChild(self.pLFoot)
        
        self.enumerateChildNodes(withName: "//*") { (node, stop) in
            guard let node = node as? SKSpriteNode else { return }
            node.color = UIColor(named: "shadow") ?? .black
            node.colorBlendFactor = 0.5
//            node.blendMode = .subtract
        }
        
        self.pRHandJ = SKShapeNode(circleOfRadius: 20)
        self.pRHandJ.position = .init(x: -150, y: 150)
        self.pRHandJ.fillColor = .red
        self.pRHand.addChild(self.pRHandJ)
        
        self.pLHandJ = SKShapeNode(circleOfRadius: 20)
        self.pLHandJ.position = .init(x: -150, y: 150)
        self.pLHandJ.fillColor = .red
        self.pLHand.addChild(self.pLHandJ)
        
        self.pRFootJ = SKShapeNode(circleOfRadius: 20)
        self.pRFootJ.fillColor = .red
        self.pRFootJ.position = .init(x: 0, y: 0)
        self.pRFoot.addChild(self.pRFootJ)
        
        self.pLFootJ = SKShapeNode(circleOfRadius: 20)
        self.pLFootJ.fillColor = .red
        self.pLFootJ.position = .init(x: 0, y: 0)
        self.pLFoot.addChild(self.pLFootJ)
    }
}
