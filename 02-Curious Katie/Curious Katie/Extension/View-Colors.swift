//
//  View-Colors.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

extension UIView {
    func setUIColors() {
        self.backgroundColor = CustomColors4.firstColor
        self.tintColor = CustomColors4.thirdColor
    }
    
    func setSecondaryUIColors() {
        self.backgroundColor = CustomColors2.thirdColor
        self.tintColor = CustomColors.secondColor
    }
    
    func setAddedPlayerView() {
        self.backgroundColor = CustomColors.firstColor
        self.layer.cornerRadius = 25.0
    }
    
    func disappear() {
        UIView.animate(withDuration: 0.6, animations: {
            self.alpha = 0
        }) { _ in
            self.isHidden = true
        }
    }
    
    func reappear() {
        UIView.animate(withDuration: 0.6) {
            self.alpha = 1
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
