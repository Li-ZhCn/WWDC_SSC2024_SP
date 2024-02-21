//
//  PuppetScene.swift
//
//
//  Created by Li Zhicheng.
//

import SwiftUI
import SpriteKit

class PuppetScene: SKScene {
    let puppetNode: PuppetNode = PuppetNode()
    let camNode = SKCameraNode()
    
    override init(size: CGSize) {
        super.init(size: size)
        
//        self.scaleMode = .aspectFit
        
        // To hidden the background of the puppet
        self.backgroundColor = .clear
        self.view?.backgroundColor = .clear
        
        self.addChild(camNode)
        self.camera = self.camNode
        
        self.anchorPoint = .init(x: 0.5, y: 0.5)
        self.addChild(puppetNode)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
//        self.configurePhysics()
    }
    
    func resetCam() {
        let translateAction = SKAction.move(to: .zero, duration: 2)
        let zoomInAction = SKAction.scale(to: 1, duration: 2)

        self.camNode.run(translateAction)

        self.camNode.run(zoomInAction)

    }
    
    func zoomIn(to node: SKSpriteNode, scale: CGFloat) {
        let position = node.convert(node.position, to: self)
        
        let translateAction = SKAction.moveBy(x: position.x, y: position.y, duration: 2)
        let zoomInAction = SKAction.scale(by: scale, duration: 2)

        self.camNode.run(translateAction)
        self.camNode.run(zoomInAction)
    }
    
    func zoomIn(to position: CGPoint, scale: CGFloat) {
        let translateAction = SKAction.move(to: position, duration: 2)
        let zoomInAction = SKAction.scale(to: scale, duration: 2)

        self.camNode.run(translateAction)
        self.camNode.run(zoomInAction)
    }
    
    func configurePhysics() {
        // body
        self.puppetNode.pBody.physicsBody = SKPhysicsBody(rectangleOf: .init(width: self.puppetNode.pBody.size.width, height: self.puppetNode.pBody.size.height))
        self.puppetNode.pBody.physicsBody?.isDynamic = false
        self.puppetNode.pBody.physicsBody?.collisionBitMask = 0b0

        // right arm
        let pRArmC = self.puppetNode.pRArm.convert(self.puppetNode.pRHand.position, to: self)
        self.puppetNode.pRArm.physicsBody = SKPhysicsBody(rectangleOf: .init(width: self.puppetNode.pRArm.size.width, height: self.puppetNode.pRArm.size.height), center: pRArmC)
        self.puppetNode.pRArm.physicsBody?.collisionBitMask = 0b0

        // pin joint: body and right arm
        let bodyArmPos = self.puppetNode.pBody.convert(self.puppetNode.pRArm.position, to: self)
        let pinBodyRArm = SKPhysicsJointPin.joint(withBodyA: self.puppetNode.pBody.physicsBody!,
                                               bodyB: self.puppetNode.pRArm.physicsBody!,
                                                  anchor: bodyArmPos)
//        pinBodyRArm.shouldEnableLimits = true
//        pinBodyRArm.lowerAngleLimit = -CGFloat.pi / 3
//        pinBodyRArm.upperAngleLimit = CGFloat.pi / 3
        self.physicsWorld.add(pinBodyRArm)
        
        // right hand
        let pRHandC = self.puppetNode.pRHand.convert(self.puppetNode.pRHandJ.position, to: self)
        self.puppetNode.pRHand.physicsBody = SKPhysicsBody(rectangleOf: .init(width: self.puppetNode.pRHand.size.width, height: self.puppetNode.pRHand.size.height), center: pRHandC)
        self.puppetNode.pRHand.physicsBody?.collisionBitMask = 0b0
        
        // pin joint: right arm and hand
        let rArmHandPos = self.puppetNode.pRArm.convert(self.puppetNode.pRHand.position, to: self)
        let pinRArmHand = SKPhysicsJointPin.joint(withBodyA: self.puppetNode.pRArm.physicsBody!,
                                               bodyB: self.puppetNode.pRHand.physicsBody!,
                                               anchor: rArmHandPos)
//        pinRArmHand.shouldEnableLimits = true
//        pinRArmHand.lowerAngleLimit = -1/6 * CGFloat.pi
//        pinRArmHand.upperAngleLimit = 2/3 * CGFloat.pi
        self.physicsWorld.add(pinRArmHand)
        
        // left arm
        let pLArmC = self.puppetNode.pLArm.convert(self.puppetNode.pLHand.position, to: self)
        self.puppetNode.pLArm.physicsBody = SKPhysicsBody(rectangleOf: .init(width: self.puppetNode.pLArm.size.width, height: self.puppetNode.pLArm.size.height), center: pLArmC)
        self.puppetNode.pLArm.physicsBody?.collisionBitMask = 0b0
        
        // pin joint: left arm and body
        let pinBodyLArm = SKPhysicsJointPin.joint(withBodyA: self.puppetNode.pBody.physicsBody!,
                                               bodyB: self.puppetNode.pLArm.physicsBody!,
                                               anchor: bodyArmPos)
//        pinBodyLArm.shouldEnableLimits = true
//        pinBodyLArm.lowerAngleLimit = -2/3 * CGFloat.pi
//        pinBodyLArm.upperAngleLimit = 0
        self.physicsWorld.add(pinBodyLArm)
        
        // left hand
        let pLHandC = self.puppetNode.pLHand.convert(self.puppetNode.pLHandJ.position, to: self)
        self.puppetNode.pLHand.physicsBody = SKPhysicsBody(rectangleOf: .init(width: self.puppetNode.pLHand.size.width, height: self.puppetNode.pLHand.size.height), center: pLHandC)
        self.puppetNode.pLHand.physicsBody?.collisionBitMask = 0b0
        
        // pin joint: left arm and hand
        let lArmHandPos = self.puppetNode.pLArm.convert(self.puppetNode.pLHand.position, to: self)
        let pinLArmHand = SKPhysicsJointPin.joint(withBodyA: self.puppetNode.pLArm.physicsBody!,
                                               bodyB: self.puppetNode.pLHand.physicsBody!,
                                               anchor: lArmHandPos)
//        pinLArmHand.shouldEnableLimits = true
//        pinLArmHand.lowerAngleLimit = -1/6 * CGFloat.pi
//        pinLArmHand.upperAngleLimit = 2/3 * CGFloat.pi
        self.physicsWorld.add(pinLArmHand)
        
        // right leg
        let pRLegC = self.puppetNode.pBody.convert(self.puppetNode.pRLeg.position, to: self)
        self.puppetNode.pRLeg.physicsBody = SKPhysicsBody(rectangleOf: .init(width: self.puppetNode.pRLeg.size.width, height: self.puppetNode.pRLeg.size.height), center: pRLegC)
        self.puppetNode.pRLeg.physicsBody?.collisionBitMask = 0b0
        
        // pin joint: body and right leg
        let bodyRLegPos = self.puppetNode.pBody.convert(self.puppetNode.pRLeg.position, to: self)
        let pinBodyRLeg = SKPhysicsJointPin.joint(withBodyA: self.puppetNode.pBody.physicsBody!,
                                                  bodyB: self.puppetNode.pRLeg.physicsBody!,
                                                  anchor: bodyRLegPos)
//        pinBodyRLeg.shouldEnableLimits = true
//        pinBodyRLeg.lowerAngleLimit = -1/3 * CGFloat.pi
//        pinBodyRLeg.upperAngleLimit = 1/2 * CGFloat.pi
        self.physicsWorld.add(pinBodyRLeg)
        
        // left leg
        let pLLegC = self.puppetNode.pBody.convert(self.puppetNode.pLLeg.position, to: self)
        self.puppetNode.pLLeg.physicsBody = SKPhysicsBody(rectangleOf: .init(width: self.puppetNode.pLLeg.size.width, height: self.puppetNode.pLLeg.size.height), center: pLLegC)
        self.puppetNode.pLLeg.physicsBody?.collisionBitMask = 0b0
        
        // pin joint: body and left leg
        let bodyLLegPos = self.puppetNode.pBody.convert(self.puppetNode.pLLeg.position, to: self)
        let pinBodyLLeg = SKPhysicsJointPin.joint(withBodyA: self.puppetNode.pBody.physicsBody!,
                                                  bodyB: self.puppetNode.pLLeg.physicsBody!,
                                                  anchor: bodyLLegPos)
//        pinBodyLLeg.shouldEnableLimits = true
//        pinBodyLLeg.lowerAngleLimit = -1/2 * CGFloat.pi
//        pinBodyLLeg.upperAngleLimit = 1/3 * CGFloat.pi
        self.physicsWorld.add(pinBodyLLeg)
        
        pinBodyRArm.frictionTorque = 0.5
        pinBodyLArm.frictionTorque = 0.5
        pinLArmHand.frictionTorque = 0.5
        pinRArmHand.frictionTorque = 0.5
        pinBodyLLeg.frictionTorque = 0.5
        pinBodyRLeg.frictionTorque = 0.5
    }
    
    func removePhysics() {
        self.puppetNode.pBody.physicsBody = nil
        self.puppetNode.pRArm.physicsBody = nil
        self.puppetNode.pRHand.physicsBody = nil
        self.puppetNode.pLArm.physicsBody = nil
        self.puppetNode.pLHand.physicsBody = nil
        self.puppetNode.pRLeg.physicsBody = nil
        self.puppetNode.pLLeg.physicsBody = nil
        
        self.physicsWorld.removeAllJoints()
    }
    
    func resetPosition() {
        let rotate = SKAction.rotate(toAngle: 0, duration: 1)
        let lArmRotate = SKAction.rotate(toAngle: CGFloat.pi / 3, duration: 1)

        self.puppetNode.pRArm.run(rotate)
        self.puppetNode.pRHand.run(rotate)
        self.puppetNode.pLArm.run(lArmRotate)
        self.puppetNode.pLHand.run(rotate)
        self.puppetNode.pHat.run(rotate)
        self.puppetNode.pRLeg.run(rotate)
        self.puppetNode.pRFoot.run(rotate)
        self.puppetNode.pLLeg.run(rotate)
        self.puppetNode.pLFoot.run(rotate)
    }
    
    func raiseHand() {
        resetPosition()
        let raiseHand = SKAction.rotate(toAngle: CGFloat.pi / 4, duration: 1)
        self.puppetNode.pRArm.run(raiseHand)
    }
    
}
