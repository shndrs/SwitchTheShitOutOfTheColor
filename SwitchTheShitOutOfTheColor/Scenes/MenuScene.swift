//
//  MenuScene.swift
//  SwitchTheShitOutOfTheColor
//
//  Created by NP2 on 5/4/19.
//  Copyright © 2019 shndrs. All rights reserved.
//

import SpriteKit

final class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        addLogoAndBackground()
        addLabels()
    }
    
    private func addLogoAndBackground() {
        
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        let backgroundImage = SKSpriteNode()
        backgroundImage.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        backgroundImage.zPosition = 0
        backgroundImage.texture = SKTexture(imageNamed: SKShits.bg4.rawValue)
        backgroundImage.aspectFillToSize(fillSize: view!.frame.size)
        
        addChild(backgroundImage)
    }
    
    private func addLabels() {
        
        let playLabel = SKLabelNode(text: SKShits.tapToPlay.rawValue)
        playLabel.fontName = FontName.copperplate.rawValue
        playLabel.fontSize = 34.0
        playLabel.fontColor = .white
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLabel)
        animate(label: playLabel)
        
        let highscoreLabel = SKLabelNode(text: SKShits.highscore.rawValue + "\(UserDefaultsManager.shared.value.integer(forKey: UserDefaultsKeys.highscore.rawValue))")
        highscoreLabel.fontName = FontName.copperplate.rawValue
        highscoreLabel.fontSize = 27.0
        highscoreLabel.fontColor = .white
        highscoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highscoreLabel.frame.size.height*4)
        addChild(highscoreLabel)
        
        let recentScoreLabel = SKLabelNode(text: SKShits.recentScore.rawValue + "\(UserDefaultsManager.shared.value.integer(forKey: UserDefaultsKeys.recentScroe.rawValue))")
        recentScoreLabel.fontName = FontName.copperplate.rawValue
        recentScoreLabel.fontSize = 20.0
        recentScoreLabel.fontColor = .white
        recentScoreLabel.position = CGPoint(x: frame.midX,
                                            y: highscoreLabel.position.y - recentScoreLabel.frame.size.height*2)
        addChild(recentScoreLabel)
    }
    
    func animate(label:SKLabelNode) {
        
        let scaleUp = SKAction.scale(to: 1.02, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        
        let sequence = SKAction.sequence([scaleDown, scaleUp])
        label.run(SKAction.repeatForever(sequence))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view?.presentScene(gameScene, transition: .reveal(with: .up, duration: 0.6))
    }
}
