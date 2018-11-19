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
        self.backgroundColor = customColorTheme.lightGray
        self.tintColor = UIColor.white
    }
    
    func setDarkUIColors() {
        self.backgroundColor = customColorTheme.midGray
        self.tintColor = customColorTheme.lightGray
    }
    
    func setAddedPlayerView() {
        self.backgroundColor = customColorTheme.lightGray
        self.layer.borderWidth = 1.0
        self.layer.borderColor = customColorTheme.darkGray.withAlphaComponent(0.45).cgColor
        self.layer.cornerRadius = 25.0
    }
    
    func hide() {
        UIView.animate(withDuration: 0.6, animations: {
            self.alpha = 0
        }) { _ in
            self.isHidden = true
        }
    }
    
    func show() {
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
