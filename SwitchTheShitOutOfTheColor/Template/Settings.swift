//
//  Settings.swift
//  SwitchTheShitOutOfTheColor
//
//  Created by NP2 on 5/4/19.
//  Copyright © 2019 shndrs. All rights reserved.
//

import SpriteKit

enum PhysicsCategories {
    
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1                           // 01
    static let switchCategory: UInt32 = 0x1 << 1 // bitwise shift   // 10
}

enum ZPositions {
    static let label: CGFloat = 0
    static let ball: CGFloat = 1
    static let colorSwitch: CGFloat = 2 
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

