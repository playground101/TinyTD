//
//  winScene.swift
//  FootBallGame
//
//  Created by Anish Arepally on 5/24/20.
//  Copyright © 2020 Playground. All rights reserved.
//


import SpriteKit

class WinScene: SKScene {
    
    override func didMove(to view: SKView) {
        let actionSound = SKAction.playSoundFileNamed("newCrowdCheer.mp3", waitForCompletion: false)
        let transitionAction = SKAction.run {
            self.transition()
        }
        let action = SKAction.sequence ([actionSound, SKAction.wait(forDuration: 1.0), transitionAction])
         self.run(action)
    }
    
    fileprivate func transition() {
        let transition = SKTransition.doorsCloseHorizontal(withDuration: 1.0)
        if let gameScene = SKScene(fileNamed: "GameScene") {
            gameScene.scaleMode = .fill
            self.view?.presentScene(gameScene, transition: transition)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        transition()
    }
}
