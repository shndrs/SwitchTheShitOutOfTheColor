//
//  GameScene.swift
//  SwitchTheShitOutOfTheColor
//
//  Created by NP2 on 5/4/19.
//  Copyright © 2019 shndrs. All rights reserved.
//

import SpriteKit

enum PlayColors {
    static let colors = [
        UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0),
        UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1.0),
        UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),
        UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
    ]
}

enum SwitchState: Int {
    case red, yellow, green, blue
}

final class GameScene: SKScene {
    
    private var colorSwitch: SKSpriteNode!
    private var switchState = SwitchState.red
    private var currentColorIndex:Int?
    private let scoreLabel = SKLabelNode(text: "0")
    private var score = 0
    
    override func didMove(to view: SKView) {
        layoutScene()
        setupPhysics()
    }
    
    private func setupPhysics() {
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.8)
        physicsWorld.contactDelegate = self
    }
    
    private func layoutScene() {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        let backgroundImage = SKSpriteNode()
        backgroundImage.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        backgroundImage.zPosition = 0
        backgroundImage.texture = SKTexture(imageNamed: "bg7")
        backgroundImage.alpha = 0.9
        backgroundImage.aspectFillToSize(fillSize: view!.frame.size)
        
        addChild(backgroundImage)
        colorSwitch = SKSpriteNode(imageNamed: "ColorCircle")
        colorSwitch.size = CGSize(width: frame.size.width/3, height: frame.size.width/3)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height)
        colorSwitch.zPosition = ZPositions.colorSwitch
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width/2)
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory
        colorSwitch.physicsBody?.isDynamic = false
        addChild(colorSwitch)
        
        scoreLabel.fontName = "Copperplate"
        scoreLabel.fontSize = 60.0
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        scoreLabel.zPosition = ZPositions.label
        addChild(scoreLabel)
        spawnBall()
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = String(score)
    }
    
    private func spawnBall() {
        currentColorIndex = Int(arc4random_uniform(UInt32(4)))
        
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"),
                                color: PlayColors.colors[currentColorIndex!],
                                size: CGSize(width: 50, height: 50))
        ball.colorBlendFactor = 1.0
        ball.name = "Ball"
        ball.position = CGPoint(x: frame.midX, y: frame.maxY)
        ball.zPosition = ZPositions.ball
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none
        addChild(ball)
    }
    
    private func turnWheel() {
        if let newState = SwitchState(rawValue: switchState.rawValue + 1) {
            switchState = newState
        } else {
            switchState = .red
        }
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2 , duration: 0.25))
    }
    
    private func gameOver() {
        
        run(SKAction.playSoundFileNamed("gameover", waitForCompletion: false))
        
        UserDefaultsManager.shared.value.set(score, forKey: UserDefaultsKeys.recentScroe.rawValue)
        if score > UserDefaultsManager.shared.value.integer(forKey: UserDefaultsKeys.highscore.rawValue) {
            UserDefaultsManager.shared.value.set(score,forKey: UserDefaultsKeys.highscore.rawValue)
        }
        
        let actionSheet = GameoverActionSheet.show(restart: {
            
            self.turnWheel()
            self.score = 0
            self.updateScoreLabel()
            self.currentColorIndex = nil
            self.spawnBall()
        }) {
            let menuScene = MenuScene(size:self.view!.bounds.size)
            self.view?.presentScene(menuScene, transition: .reveal(with: .down, duration: 0.6))
        }
        
        self.view?.window?.rootViewController?.present(actionSheet, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnWheel()
    }
}

// MARK: - SKPhysicsContactDelegate

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory {
            
            if let ball = contact.bodyA.node?.name == "Ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                if currentColorIndex == switchState.rawValue {
                    run(SKAction.playSoundFileNamed("ding", waitForCompletion: false))
                    score += 1
                    updateScoreLabel()
                    ball.run(SKAction.fadeOut(withDuration: 0.25)) {
                        ball.removeFromParent()
                        self.spawnBall()
                    }
                } else {
                    gameOver()
                }
            }
        }
    }
}
