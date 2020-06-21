//
//  GameScene.swift
//  FootBallGame
//
//  Created by Mekhala Vithala on 2/9/20.
//  Copyright © 2020 Playground. All rights reserved.
//

import SpriteKit
import GameplayKit

var score = 0

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var yardline: SKSpriteNode?
    var timer: Timer?
    var player: SKSpriteNode?
    var opponent: SKSpriteNode?
    var opponents: [SKSpriteNode] = []
    var touchDown: SKSpriteNode?
    var scoreLabel: SKLabelNode?
    var audioNode: SKAudioNode?
    var didScoreChange = false
    var dragable = false
    var opponentCount = 4
    var opponentMaxTime = 2.3
    var opponentMinTime = 0.5
    let textures = [SKTexture(imageNamed: "opponent-1"), SKTexture(imageNamed: "opponent-2"), SKTexture(imageNamed: "opponent-3"), SKTexture(imageNamed: "opponent-4")]
    
    fileprivate func backgroundMusic() {
        let backgroundNode = SKAudioNode(fileNamed: "background.mp3")
        self.addChild(backgroundNode)
        backgroundNode.run(SKAction.play())
        audioNode = backgroundNode
    }
    
    override func didMove(to view: SKView) {
        yardline = self.childNode(withName: "yardline") as? SKSpriteNode
        player = self.childNode(withName: "player") as? SKSpriteNode
        touchDown = self.childNode(withName: "touchDown") as? SKSpriteNode
        opponent = self.childNode(withName: "opponent") as? SKSpriteNode
        scoreLabel = self.childNode(withName: "scoreLabel") as? SKLabelNode
        scoreLabel?.text = String(score )
        physicsWorld.contactDelegate = self
        backgroundMusic()
        updateGameParameters()
        player?.size = CGSize(width: self.frame.width * 0.15, height: self.frame.width * 0.15)
        //creates 4 new nodes
        for i in 1...opponentCount {
            let factor = 50
            var x = 0
            if i % 2 == 0 {
                x =  -i * factor
            } else {
                x = i * factor
            }
            print("x = \(x)")
            let opponent = createOpponent(x: x, y: 300)
            //opponent.texture = SKTexture(imageNamed: "emoji\(i)")
            //let opponent = self.childNode(withName: "opponent") as? SKSpriteNode
            
            // checking for existence of player and opponent
            if let player = player, let opponent = opponent {
                // adding opponents
                self.addChild(opponent)
                //adding opponents to opponent array
                opponents.append(opponent)
                //makes opponent face the player
                let constraint = SKConstraint.orient(to: player, offset: SKRange(constantValue: 90))
                opponent.constraints = [constraint]
            }
        }
    }
    func updateGameParameters() {
        switch score {
        case ...0:
          opponentCount = 4
          opponentMaxTime = 2.5
          opponentMinTime = 0.4
        case 0...3:
          opponentCount = 5
          opponentMaxTime = 2.0
          opponentMinTime = 0.3
        case 4...9:
          opponentCount = 6
          opponentMaxTime = 1.5
          opponentMinTime = 0.2
        case 10...:
          opponentCount = 7
          opponentMaxTime = 1.0
          opponentMinTime = 0.1
        default:
          opponentCount = 5
          opponentMaxTime = 2.3
          opponentMinTime = 0.5
        }
    }
    func createOpponent(x: Int, y: Int) -> SKSpriteNode? {
        // makes copies of the opponent
        let node = opponent?.copy() as? SKSpriteNode
        node?.size = CGSize (width: self.frame.width * 0.175, height: self.frame.width * 0.175)
        //sets the position of the node in a way that it can be changed in another function without coming back here.
        node?.position = CGPoint(x: x, y: y)
        //checking for existence of node
        if let node = node {
            // making node look like opponent-1 texture
            node.texture = SKTexture(imageNamed: "opponent-1")
            // animating the opponents
            
        }
        return node
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first?.location(in: self)
        if let location = location {
            let nodes = self.nodes(at: location)
            for node in nodes {
                if node.name == "player" {
                    dragable = true
                }
            }
        }
        
        if dragable == true {
            // animating the opponents
            for opponent in opponents {
                let random = Double.random(in: 0.1...0.7)
                
                let runAction = SKAction.animate(with: textures, timePerFrame: random)
                // making animation repeat forever without stopping
                let foreverAction = SKAction.repeatForever(runAction)
                opponent.run(foreverAction)
                
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // makes location wherever the touch is
        let location = touches.first?.location(in: self)
        // checking for existence of location
        if let location = location {
            // returns nodes at the location
            let nodes = self.nodes(at: location)
            // for loop goes through nodes
            for node in nodes {
                // checks if a node's name is player and if it is dragable becomes true
                if node.name == "player" {
                    dragable = true
                    if dragable == true {
                        player?.position = location
                    }
                    // drags the player to the location
                    player?.position = location
                    // checks for existence of opponent
                    for opponent in opponents {
                        // generates a random number
                        let randomNumber = Double.random(in: opponentMinTime...opponentMaxTime)
                        // moves the opponent to the player
                        let action = SKAction.move(to: location, duration: TimeInterval(randomNumber))
                        opponent.run(action)
                    }
                }
            }
        }
    }
    
    // initializing all the nodes. gives starting coordinate of opponent.
    func didEnd(_ contact: SKPhysicsContact) {
        dragable = false
        // checking if there is contact between player and touchdown
        if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "touchdown") || (contact.bodyA.node?.name == "touchdown" && contact.bodyB.node?.name == "player")
        {
            
            //            let soundAction = SKAction.playSoundFileNamed("crowdCheer.mp3", waitForCompletion: true)
            //            opponent?.run(soundAction)
            // checking if didScoreChange is false
            if didScoreChange == false {
                //adding 1 to the score
                score += 1
                // changing what appears on the scoreLabel
                scoreLabel?.text = String(score)
                print(score)
            }
            // makes didScoreChange from false to true
            didScoreChange = true
            
            audioNode?.run(SKAction.stop())
            // transitioning out of the scene back to the start scene
            let transition = SKTransition.doorsCloseHorizontal(withDuration: 1.0)
            if let winScene = SKScene(fileNamed: "WinScene"){
                winScene.scaleMode = .fill
                self.view?.presentScene(winScene, transition: transition)
            }
            //checking if there is contact between player and opponent
        } else if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "opponent") || (contact.bodyA.node?.name == "opponent" && contact.bodyB.node?.name == "player")  {
            
            //            let actionSound = SKAction.playSoundFileNamed("sadTrombone.mp3", waitForCompletion: true)
            //            player?.run(actionSound)
            // checking id didScoreChange is false
            if didScoreChange == false {
                // subtracting 1 from the score
                score -= 1
                //changing what is on the scoreLabel
                scoreLabel?.text = String(score)
                print(score)
            }
            //makes didScoreChange true
            didScoreChange = true
            //transitioning to original gameScene
            
            audioNode?.run(SKAction.stop())
            
            let transition = SKTransition.doorsCloseHorizontal(withDuration: 1.0)
            if let gameOver = SKScene(fileNamed: "GameOver"){
                gameOver.scaleMode = .fill
                self.view?.presentScene(gameOver, transition: transition)
                
            }
        }
    }
}



