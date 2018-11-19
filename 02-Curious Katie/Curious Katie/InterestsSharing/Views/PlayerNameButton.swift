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
        self.backgroundColor = UIColor.lightGray
        self.tintColor = UIColor.white
        self.frame.size.height = 30.0
        
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = 0.5
        self.titleLabel?.baselineAdjustment = .alignCenters
        
        self.setTitleColor(customColorTheme.lightGray, for: .disabled)
        self.setTitleColor(customColorTheme.darkGray, for: .normal)
        
        let height = self.bounds.height
        self.roundCorners(corners: [.bottomLeft, .topLeft], radius: height / 4)
    }
    
    func activate() {
        self.isEnabled = true
        self.alpha = 1.0
        self.roundCorners(corners: .allCorners, radius: 0.0)
        self.changeColors()
    }

}
