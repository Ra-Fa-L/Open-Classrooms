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
    }
    
    func makePlayerButtonRight() {
        let height = self.bounds.height
        self.roundCorners(corners: [.bottomLeft, .topLeft], radius: height / 4)
    }
}
