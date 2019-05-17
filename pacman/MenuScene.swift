//
//  MainMenu.swift
//  pacman
//
//  Created by Jordan Shand on 5/16/19.
//  Copyright © 2019 Jordan Shand. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene: SKScene{
    
    func addLogo() {
        let logo = SKSpriteNode(imageNamed: "pacman")
        logo.size = CGSize(width: logo.size.width*2, height: logo.size.height*2)
        logo.position = CGPoint(x: 0, y: size.height/4)
        addChild(logo)
    }
    
    func addLabel() {
        let playLabel = SKLabelNode(text: "Play")
        playLabel.fontName = "Chalkduster"
        playLabel.fontSize = 50.0
        playLabel.fontColor = UIColor.white
        playLabel.position = CGPoint(x: 0, y: -size.height/4)
        addChild(playLabel)
    }
    
    func addInstructions() {
        let instrucLabel = SKLabelNode(text: "Avoid red and pink ghosts! Eat the blue ghosts!")
        instrucLabel.fontName = "Chalkduster"
        instrucLabel.fontSize = 20.0
        instrucLabel.fontColor = UIColor.white
        instrucLabel.position = CGPoint(x: 0, y: -size.height/8)
        addChild(instrucLabel)
        
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(pinkGhost),
                SKAction.wait(forDuration: 1.0)
                
            ])
        ))
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(redGhost),
                SKAction.wait(forDuration: 1.0)
            ])
        ))
        
        addLogo()
        addLabel()
        addInstructions()
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
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min:CGFloat, max:CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    //red and pink ghosts are the live ghosts
    func redGhost() {
        
        let redGhost = SKSpriteNode(imageNamed: "red_ghost") // red ghost sprite
        
        redGhost.physicsBody = SKPhysicsBody(circleOfRadius: redGhost.size.width/2)
        redGhost.physicsBody?.isDynamic = true
        redGhost.physicsBody?.categoryBitMask = PhysicsCategory.liveGhost
        redGhost.physicsBody?.contactTestBitMask = PhysicsCategory.pacman
        redGhost.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        let ghost = redGhost
        
        let actualY = random(min: -size.height/2 + ghost.size.height, max: size.height/2 - ghost.size.height)
        
        redGhost.position = CGPoint(x: size.width + ghost.size.width/2, y: actualY)
        
        addChild(redGhost)
        
        let actualDuration = random(min: CGFloat(3.0), max: CGFloat(4.0))
        
        let destination = -size.width
        
        let actionMove = SKAction.move(to: CGPoint(x: destination, y: actualY), duration: TimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        
        redGhost.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
    func pinkGhost() {
        
        let pinkGhost = SKSpriteNode(imageNamed: "pink_ghost")
        
        pinkGhost.physicsBody = SKPhysicsBody(circleOfRadius: pinkGhost.size.width/2)
        pinkGhost.physicsBody?.isDynamic = true
        pinkGhost.physicsBody?.categoryBitMask = PhysicsCategory.liveGhost
        pinkGhost.physicsBody?.contactTestBitMask = PhysicsCategory.pacman
        pinkGhost.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        let ghost = pinkGhost
        
        let actualY = random(min: -size.height/2 + ghost.size.height, max: size.height/2 - ghost.size.height)
        
        pinkGhost.position = CGPoint(x: size.width + ghost.size.width/2, y: actualY)
        
        addChild(pinkGhost)
        
        let actualDuration = random(min: CGFloat(3.0), max: CGFloat(4.0))
        
        let destination = -size.width
        
        let actionMove = SKAction.move(to: CGPoint(x: destination, y: actualY), duration: TimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        
        pinkGhost.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
    func deadGhost() {
        
        let deadGhost = SKSpriteNode(imageNamed: "dead_ghost")
        
        deadGhost.physicsBody = SKPhysicsBody(circleOfRadius: deadGhost.size.width/2)
        deadGhost.physicsBody?.isDynamic = true
        deadGhost.physicsBody?.categoryBitMask = PhysicsCategory.deadGhost
        deadGhost.physicsBody?.contactTestBitMask = PhysicsCategory.pacman
        deadGhost.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        let ghost = deadGhost
        
        let actualY = random(min: -size.height/2 + ghost.size.height, max: size.height/4 - ghost.size.height)
        
        deadGhost.position = CGPoint(x: size.width + ghost.size.width/2, y: actualY)
        
        addChild(deadGhost)
        
        let actualDuration = random(min: CGFloat(5.0), max: CGFloat(6.0))
        
        let destination = -size.width
        
        let actionMove = SKAction.move(to: CGPoint(x: destination, y: actualY), duration: TimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        
        deadGhost.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
}
