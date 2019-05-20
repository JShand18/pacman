//
//  GameOverScene.swift
//  pacman
//
//  Created by Savir Madan on 5/16/19.
//  Copyright © 2019 Jordan Shand. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    
    
    var scoreLabel:SKLabelNode!
    var newGameButtonNode:SKSpriteNode!
    
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        
        let scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: \(gameScore)"
        scoreLabel.fontSize = 75
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.5)
        scoreLabel.zPosition = 1
        self.addChild(scoreLabel)
        
        let gameOverLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 75
        gameOverLabel.fontColor = SKColor.white
        gameOverLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.85 )
        gameOverLabel.zPosition = 1
        self.addChild(gameOverLabel)
        
        let playAgainLabel = SKLabelNode(fontNamed: "Chalkduster")
        playAgainLabel.text = "Tap anywhere to play again."
        playAgainLabel.fontSize = 35
        playAgainLabel.fontColor = SKColor.white
        playAgainLabel.position = CGPoint(x: self.size.width * 0.5, y: self.size.height * 0.1 )
        playAgainLabel.zPosition = 1
        self.addChild(playAgainLabel)
        
//        let defaults = UserDefaults()
//        var highScoreNumber = defaults.integer(forKey: "Chalkduster")
//        if gameScore > highScoreNumber {
//            highScoreNumber = gameScore
//            defaults.set(highScoreNumber, forKey: "highScoreSaved")
//        }
//
//
//        let highScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
//        highScoreLabel.text = "High Score: \(highScoreNumber)"
//        highScoreLabel.fontSize = 75
//        highScoreLabel.fontColor = SKColor.white
//        highScoreLabel.zPosition = 1
//        highScoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.6)
//        self.addChild(highScoreLabel)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
 
        if let view = self.view {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
        }
        //            }
        //        }
        
        //        let sceneToMoveTo = GameScene(size: self.size)
        //        sceneToMoveTo.scaleMode = self.scaleMode
        //        let myTransition = SKTransition.fade(withDuration: 0.5)
        //        self.view!.presentScene(sceneToMoveTo, transition: myTransition)
        
        
    }
}
