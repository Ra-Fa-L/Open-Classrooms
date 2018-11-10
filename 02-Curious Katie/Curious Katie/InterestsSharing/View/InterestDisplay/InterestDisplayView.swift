//
//  InterestDisplayView.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 10.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class InterestDisplayView: UIView {
    
    @IBOutlet var customView: UIView!
    
    override func awakeFromNib() {
        print("AWAKEN")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("***INITIALIZED")
        initalize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func initalize() {
        Bundle.main.loadNibNamed("InterestDisplayView", owner: self, options: nil)
        addSubview(customView)
        customView.frame = self.bounds
        
        customView.backgroundColor = CustomColors4.sixthColor
        
        
    }
    
    func animate(moveBy: CGFloat) {
        self.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10.0)
        self.frame.origin.x = 0 + moveBy
    }

}
