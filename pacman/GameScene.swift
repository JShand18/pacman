//
//  GameScene.swift
//  pacman
//
//  Created by Jordan Shand on 5/8/19.
//  Copyright © 2019 Jordan Shand. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let none : UInt32 = 0
    static let all : UInt32 = UInt32.max
    static let pacman : UInt32 = 0b1 // pacman is represented by first bit
    static let badGhost: UInt32 = 0b10 // bad ghost by secondbit
    static let goodGhost: UInt32 = 0b100 // good ghost by thrid bit
}


class GameScene: SKScene {
    
    let pacman = SKSpriteNode(imageNamed: "pacman")
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min:CGFloat, max:CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func redGhost() {
    
        let redGhost = SKSpriteNode(imageNamed: "red_ghost")
        
        redGhost.physicsBody = SKPhysicsBody(circleOfRadius: redGhost.size.width/2)
        redGhost.physicsBody?.isDynamic = true
        redGhost.physicsBody?.categoryBitMask = PhysicsCategory.badGhost
        redGhost.physicsBody?.contactTestBitMask = PhysicsCategory.pacman
        redGhost.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        let ghost = redGhost
        
        let actualY = random(min: -size.height + ghost.size.height, max: size.height - ghost.size.height)
        
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
        pinkGhost.physicsBody?.categoryBitMask = PhysicsCategory.badGhost
        pinkGhost.physicsBody?.contactTestBitMask = PhysicsCategory.pacman
        pinkGhost.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        let ghost = pinkGhost
        
        let actualY = random(min: -size.height + ghost.size.height, max: size.height - ghost.size.height)
        
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
        deadGhost.physicsBody?.categoryBitMask = PhysicsCategory.goodGhost
        deadGhost.physicsBody?.contactTestBitMask = PhysicsCategory.pacman
        deadGhost.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        let ghost = deadGhost
        
        let actualY = random(min: -size.height + ghost.size.height, max: size.height - ghost.size.height)
        
        deadGhost.position = CGPoint(x: size.width + ghost.size.width/2, y: actualY)
        
        addChild(deadGhost)
        
        let actualDuration = random(min: CGFloat(4.0), max: CGFloat(5.0))
        
        let destination = -size.width
        
        let actionMove = SKAction.move(to: CGPoint(x: destination, y: actualY), duration: TimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        
        deadGhost.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.white //changing the backforund color of the scheme
        pacman.anchorPoint = CGPoint(x: 0.5, y: 0.5) // setting the postion of the sprite
        pacman.position = CGPoint(x: 0, y: 0)
        
        
        addChild(pacman)  //to make the sprite appear
        
        
        
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
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.wait(forDuration: 3.0),
                SKAction.run(deadGhost)
                ])
        ))
        
        physicsWorld.gravity = .zero //set the gravity of the of the game scene to none
        //physicsWorld.contactDelegate = self  // allows the delegate to contact when two bodies collide
        
        
    }

    
    func touchDown(atPoint pos : CGPoint) {
      
    }
    
    func touchMoved(toPoint pos : CGPoint) {
      
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            // moving kirby around following the user's finger
            let location = touch.location(in: self)
            pacman.position.x = location.x
            pacman.position.y = location.y
            
            pacman.physicsBody = SKPhysicsBody(rectangleOf: pacman.size)
            pacman.physicsBody?.isDynamic = true
            pacman.physicsBody?.categoryBitMask = PhysicsCategory.pacman
            pacman.physicsBody?.contactTestBitMask = PhysicsCategory.badGhost
            pacman.physicsBody?.collisionBitMask = PhysicsCategory.none
            pacman.physicsBody?.usesPreciseCollisionDetection = true
            
            
            print("x: \(pacman.position.x) y: \(pacman.position.y)")
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
 
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
