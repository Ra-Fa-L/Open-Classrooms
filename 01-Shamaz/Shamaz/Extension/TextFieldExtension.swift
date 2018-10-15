//
//  TextFieldExtension.swift
//  Shamaz
//
//  Created by Rafal Padberg on 15.10.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

extension UITextField
{
    func highlight(error: Bool)
    {
        self.layer.cornerRadius = error ? 4.0 : 0.0
        self.layer.borderWidth = error ? 1.0 : 0.0
        self.layer.borderColor = error ? UIColor.red.cgColor : nil
        self.textColor = error ? UIColor.red : UIColor.black
    }
}
