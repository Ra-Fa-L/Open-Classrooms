//
//  Button-ColorCorners.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

extension UIButton {
    func makeButton() {
        let height = self.bounds.height
        self.roundCorners(corners: .allCorners, radius: height / 3)
        self.backgroundColor = CustomColors4.fifthColor
    }
    
    func make2ndButton() {
        let height = self.bounds.height
        self.roundCorners(corners: .allCorners, radius: height / 4)
        self.backgroundColor = CustomColors4.firstColor
    }
    
    func roundLeftCorners() {
        let height = self.bounds.height
        self.roundCorners(corners: [.bottomLeft, .topLeft], radius: height / 4)
    }
    
    func changeColors() {
        self.backgroundColor = CustomColors.secondColor
        self.titleLabel?.textColor = CustomColors4.sixthColor
    }
    
    func noCorners() {
        self.roundCorners(corners: .allCorners, radius: 0.0)
    }
    
    func activateButton(goBack: Bool) {
        UIView.animate(withDuration: 0.3) {
            if goBack {
                self.changeColors()
            } else {
                self.backgroundColor = CustomColors4.secondColor
                self.setTitleColor(CustomColors4.firstColor, for: .normal)
            }
        }
    }
}
