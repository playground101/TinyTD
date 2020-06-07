//
//  Constraints.swift
//  FootBallGame
//
//  Created by Mekhala Vithala on 2/23/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import SpriteKit

class Constraints: SKScene {
    
    let redNode = SKShapeNode(circleOfRadius: 50)
    let blueNode = SKShapeNode(circleOfRadius: 50)
    let pointer = SKSpriteNode(imageNamed: "Arrow.png")
    override func didMove(to view: SKView) {
        redNode.fillColor = .red
        blueNode.fillColor = .blue
        
        pointer.position = CGPoint(x: 200, y: 200)
        self.addChild(redNode)
        self.addChild(blueNode)
        self.addChild(pointer)
        
       // let loopUpConstraint = SKConstraint.orient(to: blueNode, offset: SKRange(constantValue: -CGFloat.pi / 2))
        let loopUpConstraint = SKConstraint.orient(to: blueNode, offset: SKRange(lowerLimit: 100, upperLimit: 100))
        pointer.constraints = [loopUpConstraint]
        
        
        
 //       let range = SKRange(lowerLimit: -300, upperLimit: 100)
//        let lockToCenter = SKConstraint.positionX(range, y: range)
//        let yConstraint =  SKConstraint.positionY(SKRange(lowerLimit: 0, upperLimit: 0))
        //redNode.constraints = [ lockToCenter, yConstraint ]
        
//        let distanceConstraint = SKConstraint.distance(SKRange(constantValue: 100), to: redNode)
        
 //       blueNode.constraints = [distanceConstraint]
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //pointer.position = touches.first?.location(in: self) ?? CGPoint.zero
        
        let currentLocation = touches.first?.location(in: self) ?? CGPoint.zero
        
        blueNode.position = currentLocation
    
        let moveAction = SKAction.move(to: currentLocation, duration: 1.0)
        pointer.run(moveAction)
        
    }
}
