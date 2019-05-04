//
//  ActionShit.swift
//  SwitchTheShitOutOfTheColor
//
//  Created by NP2 on 5/4/19.
//  Copyright © 2019 shndrs. All rights reserved.
//

import UIKit

public struct GameoverActionSheet {
    
    public static func show(restart: @escaping ()->Void, menuCB: @escaping ()->Void) -> UIAlertController {
        let actionSheet = UIAlertController(title: "Gameover", message: "Which one do you prefer?", preferredStyle: .actionSheet)
        
        let menu = UIAlertAction(title: "Go To The Menu", style: .destructive) { (action) in
            menuCB()
        }
        
        let yes = UIAlertAction(title: "Restart the game", style: .default) { (action) in
            restart()
        }
        
        actionSheet.addAction(yes)
        actionSheet.addAction(menu)
        
        return actionSheet
    }
}
