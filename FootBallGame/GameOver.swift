//
//  GameOver.swift
//  FootBallGame
//
//  Created by Mekhala Vithala on 3/1/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import SpriteKit

class GameOver: SKScene {
    override func didMove(to view: SKView) {
        let actionSound = SKAction.playSoundFileNamed("sadTrombone.mp3", waitForCompletion: false)
        let transitionAction = SKAction.run {
            self.transition()
        }
        if mute {
            let action = SKAction.sequence([SKAction.wait(forDuration: 1.0), transitionAction])
            self.run(action)
        } else {
            let action = SKAction.sequence([actionSound, SKAction.wait(forDuration: 1.0), transitionAction])
            self.run(action)
        }
        
    }

    fileprivate func transition() {
        let transition = SKTransition.doorsCloseHorizontal(withDuration: 1.0)
        if let gameScene = SKScene(fileNamed: "GameScene"){
            gameScene.scaleMode = .fill
            self.view?.presentScene(gameScene, transition: transition)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        transition()
    }
}
