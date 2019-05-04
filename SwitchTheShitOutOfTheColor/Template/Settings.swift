//
//  Settings.swift
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

enum PhysicsCategories {
    
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1                           // 01
    static let switchCategory: UInt32 = 0x1 << 1 // bitwise shift   // 10
}

enum ZPositions {
    static let label: CGFloat = 1
    static let ball: CGFloat = 2
    static let colorSwitch: CGFloat = 3
}

public struct UserDefaultsManager {
    
    public static let shared = UserDefaultsManager()
    public let value = UserDefaults.standard
    private init() {}
}

public enum UserDefaultsKeys:String {
    case highscore
    case recentScroe
}

