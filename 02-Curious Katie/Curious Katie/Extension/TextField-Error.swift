//
//  TextField-Error.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 09.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

extension UITextField {
    func animateError(with text: String = "Too short") {
        let oldValue = self.text!
        
        self.text = text
        
        self.textColor = UIColor.red
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1.6
        self.layer.cornerRadius = 4.0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.text = oldValue
            self.textColor = UIColor.black
            
            self.layer.borderColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.4).cgColor
            
        }
    }
    
    func restoreDefault() {
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.0
    }
}
