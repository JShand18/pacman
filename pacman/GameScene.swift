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
    static let deadGhost: UInt32 = 0b10 // dead ghost by secondbit
    static let liveGhost: UInt32 = 0b100 // live ghosts by thrid bit
}


class GameScene: SKScene {
    
    // the three sprites used for pacman
    let pacman = SKSpriteNode(imageNamed: "pacman")
    
    let pacmanEat = SKSpriteNode(imageNamed: "pacman_closed")
          let pacmanHit = SKSpriteNode(imageNamed: "pacman_hit")
    
    //hey jordan licker
    
    
    //lives and score labels
    var livesLabel: SKLabelNode!
    
    var lives = 3 {
        didSet{
            livesLabel.text = "Lives: \(lives)"
        }
    }
    
    var scoreLabel: SKLabelNode!
    
    var score = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    // functions to creat random y-axis locations for spawn
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
    
    override func didMove(to view: SKView) {
        
        livesLabel = SKLabelNode(fontNamed: "Chalkduster")
        livesLabel.text = "Lives: 3"
        livesLabel.horizontalAlignmentMode = .center
        livesLabel.position = CGPoint(x: size.width/4, y: size.height/2.5)
        addChild(livesLabel)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: -size.width/4, y: size.height/2.5)
        addChild(scoreLabel)
        
        backgroundColor = SKColor.black //changing the backforund color of the scheme
        pacman.anchorPoint = CGPoint(x: 0.5, y: 0.5) // setting the postion of the sprite
        pacman.position = CGPoint(x: 0, y: 0)
        addChild(pacman)  //to make the sprite appear
        
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.wait(forDuration: 1.0),
                SKAction.run(pinkGhost)
                
                ])
        ))
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.wait(forDuration: 1.0),
                SKAction.run(redGhost)
                
                ])
        ))
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.wait(forDuration: 3.0),
                SKAction.run(deadGhost)
                ])
        ))
        
        physicsWorld.gravity = .zero //set the gravity of the of the game scene to none
        physicsWorld.contactDelegate = self  // allows the delegate to contact when two bodies collide
        
        
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
            pacman.physicsBody?.contactTestBitMask = PhysicsCategory.deadGhost
            pacman.physicsBody?.contactTestBitMask = PhysicsCategory.liveGhost
            pacman.physicsBody?.collisionBitMask = PhysicsCategory.none
            pacman.physicsBody?.usesPreciseCollisionDetection = true
            
            pacmanEat.position.x = location.x
            pacmanEat.position.y = location.y
            
            pacmanHit.position.x = location.x
            pacmanHit.position.y = location.y

        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
 
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func pacmanDidCollideWithDeadGhost(deadGhost: SKSpriteNode, pacman: SKSpriteNode) {
        print("Eaten!")
        score += 1
        deadGhost.removeFromParent()
        pacman.removeFromParent()
        addChild(pacmanEat)
        delay(bySeconds: 0.1) {
            self.pacmanEat.removeFromParent()
            self.addChild(pacman)
        }
    }
    
    func pacmanDidCollideWithLiveGhost(liveGhost: SKSpriteNode, pacman: SKSpriteNode){
        lives -= 1
        print(lives)

        liveGhost.removeFromParent()
        pacman.removeFromParent()
        addChild(pacmanHit)
        delay(bySeconds: 0.3) {
            self.pacmanHit.removeFromParent()
            self.addChild(pacman)
        }
    }
    

// delay function from StackOverflow, DSCHEE
    public func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
        let dispatchTime = DispatchTime.now() + seconds
        dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
    }
    
    public enum DispatchLevel {
        case main, userInteractive, userInitiated, utility, background
        var dispatchQueue: DispatchQueue {
            switch self {
            case .main:                 return DispatchQueue.main
            case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
            case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
            case .utility:              return DispatchQueue.global(qos: .utility)
            case .background:           return DispatchQueue.global(qos: .background)
            }
        }
    }
    
}

extension GameScene: SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        
        if ((firstBody.categoryBitMask & PhysicsCategory.pacman != 0) && (secondBody.categoryBitMask & PhysicsCategory.deadGhost != 0)) {
            if let pacman = firstBody.node as? SKSpriteNode,
                let deadGhost = secondBody.node as? SKSpriteNode {
                pacmanDidCollideWithDeadGhost(deadGhost: deadGhost, pacman: pacman)
            }
        }

        if ((firstBody.categoryBitMask & PhysicsCategory.pacman != 0) && (secondBody.categoryBitMask & PhysicsCategory.liveGhost != 0)) {
            if let pacman = firstBody.node as? SKSpriteNode,
                let liveGhost = secondBody.node as? SKSpriteNode {
                    pacmanDidCollideWithLiveGhost(liveGhost: liveGhost, pacman: pacman)
                }
            }
        
    }
}
