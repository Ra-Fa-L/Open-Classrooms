//
//  SingleInterestView.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 09.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class SingleInterestView: UIView {
    
    @IBOutlet var customView: UIView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var checkButton: UIButton!
    
    override init(frame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 10)) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("SingleInterestView", owner: self, options: nil)
        addSubview(customView)
        
        customView.frame = self.bounds
        
        self.customView.backgroundColor = customColorTheme.lightGray
    }
}
