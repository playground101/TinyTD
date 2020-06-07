//
//  Constraints.swift
//  FootBallGame
//
//  Created by Mekhala Vithala on 2/21/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import SpriteKit

class ShapeNode: SKScene {
    
    let shapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 100, height: 100))
    let circleNode = SKShapeNode(circleOfRadius: 12.0)
    let rectWithCorner = SKShapeNode(rect: CGRect(x: 0, y: 0, width: 300, height: 50), cornerRadius: 15.0)
    let ellipse = SKShapeNode(ellipseOf: CGSize(width: 300, height: 100))
    let person = StickFigure.create()
    
    override func didMove(to view: SKView) {
//        shapeNode.fillColor = .blue
//        self.addChild(shapeNode)
//
//        circleNode.fillColor = .red
//        shapeNode.addChild(circleNode)
//
//        rectWithCorner.position = CGPoint(x: -139, y: -400)
//        rectWithCorner.fillColor = .yellow
//        circleNode.addChild(rectWithCorner)
//
//        ellipse.fillColor = .green
//        rectWithCorner.addChild(ellipse)
        
        self.addChild(person)
        
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        person.position = touches.first?.location(in: self) ?? CGPoint.zero
    }
}


class StickFigure {
    
    class func create() -> SKShapeNode {
        let head = SKShapeNode(circleOfRadius: 100.0)
        head.fillColor = .red
        
        let bodyHeight = 400
        let body = SKShapeNode(rect: CGRect(x: Int(head.frame.minX), y: Int(head.frame.minY) - bodyHeight, width: Int(head.frame.width), height: bodyHeight))
        body.fillColor = .green
        head.addChild(body)
        
        let legHeight = 200
        let legWidth = 70
        
        let leg1 = SKShapeNode(rect: CGRect(x: Int(body.frame.minX), y: Int(body.frame.minY) - legHeight, width: legWidth, height: legHeight))
        leg1.fillColor = .yellow
        body.addChild(leg1)
        
        let leg2 = SKShapeNode(rect: CGRect(x: Int(body.frame.maxX) - legWidth, y: Int(body.frame.minY) - legHeight, width: legWidth, height: legHeight))
        leg2.fillColor = .yellow
        body.addChild(leg2)
        
        
        let armWidth = 50
        let armHeight = 250
        
        let arm1 = SKShapeNode(rect: CGRect(x: Int(body.frame.minX) - armWidth, y: Int(body.frame.maxY) - armHeight, width: armWidth, height: armHeight))
        arm1.fillColor = .green
        body.addChild(arm1)
        
        let arm2 = SKShapeNode(rect: CGRect(x: Int(body.frame.maxX), y: Int(body.frame.maxY) - armHeight, width: armWidth, height: armHeight))
        arm2.fillColor = .green
        body.addChild(arm2)
 
        return head
    }
}





