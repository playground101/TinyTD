//
//  StartScene.swift
//  FootBallGame
//
//  Created by Mekhala Vithala on 2/9/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import SpriteKit

class StartScene: SKScene {
    
    override func didMove(to view: SKView) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
        if let gameScene = SKScene(fileNamed: "GameScene") {
            gameScene.scaleMode = .fill
            self.view?.presentScene(gameScene, transition: transition)
        }
    }
}
