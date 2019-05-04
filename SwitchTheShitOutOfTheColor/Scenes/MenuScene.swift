//
//  MenuScene.swift
//  SwitchTheShitOutOfTheColor
//
//  Created by NP2 on 5/4/19.
//  Copyright © 2019 shndrs. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        addLogo()
        addLabels()
    }
    
    private func addLogo() {
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.size = CGSize(width: frame.size.width/4, height: frame.size.width/4)
        logo.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height/4)
        addChild(logo)
    }
    
    private func addLabels() {
        
        let playLabel = SKLabelNode(text: "Tap To Play Pal!")
        playLabel.fontName = "Copperplate"
        playLabel.fontSize = 40.0
        playLabel.fontColor = .white
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLabel)
        
        let highscoreLabel = SKLabelNode(text: "Highscore: " + "\(UserDefaultsManager.shared.value.integer(forKey: UserDefaultsKeys.highscore.rawValue))")
        highscoreLabel.fontName = "Copperplate"
        highscoreLabel.fontSize = 25.0
        highscoreLabel.fontColor = .white
        highscoreLabel.position = CGPoint(x: frame.midX, y: frame.midY - highscoreLabel.frame.size.height*4)
        addChild(highscoreLabel)
        
        let recentScoreLabel = SKLabelNode(text: "Recent Score: " + "\(UserDefaultsManager.shared.value.integer(forKey: UserDefaultsKeys.recentScroe.rawValue))" )
        recentScoreLabel.fontName = "Copperplate"
        recentScoreLabel.fontSize = 30.0
        recentScoreLabel.fontColor = .white
        recentScoreLabel.position = CGPoint(x: frame.midX,
                                            y: highscoreLabel.position.y - recentScoreLabel.frame.size.height*2)
        addChild(recentScoreLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: view!.bounds.size)
        view?.presentScene(gameScene, transition: .reveal(with: .up, duration: 0.6))
    }
}
