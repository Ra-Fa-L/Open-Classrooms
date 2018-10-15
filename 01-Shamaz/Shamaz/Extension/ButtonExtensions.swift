//
//  Extensions.swift
//  Shamaz
//
//  Created by Rafal Padberg on 08.10.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

// Custom Methods extending UIButton to quickly change background and corderRadius
extension UIButton
{
    func display(enabled: Bool)
    {
        self.isEnabled = enabled
        self.alpha = enabled ? 1.0 : 0.55
    }
    
    func highlight()
    {
        self.alpha = 0.90
    }
    
    func setGreen()
    {
        self.backgroundColor = ColorTheme.navigationColor
        self.tintColor = ColorTheme.secondaryTextColor
        
        self.roundCorners(corners: [.allCorners], radius: self.frame.height / 3)
    }
    
    func setOrange()
    {
        self.backgroundColor = ColorTheme.buttonColor
        self.tintColor = ColorTheme.mainTextColor
        
        self.roundCorners(corners: [.bottomLeft, .bottomRight], radius: self.frame.height / 3)
    }
    
    private func roundCorners(corners: UIRectCorner, radius: CGFloat)
    {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
