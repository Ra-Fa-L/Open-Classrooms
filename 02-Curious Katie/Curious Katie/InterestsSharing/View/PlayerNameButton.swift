//
//  PlayerNameButton.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 09.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class PlayerNameButton: UIButton {

    override func awakeFromNib() {
        self.backgroundColor = CustomColors2.thirdColor
        self.tintColor = CustomColors4.sixthColor
        self.frame.size.height = 30.0
        
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = 0.5
        self.titleLabel?.baselineAdjustment = .alignCenters
        
        self.roundLeftCorners()
    }
    
    func activate() {
        self.isEnabled = true
        self.alpha = 1.0
        self.noCorners()
        self.changeColors()
    }

}
