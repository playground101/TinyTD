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
        let actionSound = SKAction.playSoundFileNamed("sadTrombone.mp3", waitForCompletion: true)
        self.run(actionSound)
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.doorsCloseHorizontal(withDuration: 1.0)
        if let gameScene = SKScene(fileNamed: "GameScene"){
            gameScene.scaleMode = .aspectFill
            self.view?.presentScene(gameScene, transition: transition)
        }
    }
}
