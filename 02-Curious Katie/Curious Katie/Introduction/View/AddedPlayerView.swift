//
//  AddedPlayerView.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 09.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class AddedPlayerView: UIView {
    
    @IBOutlet var customView: UIView!
    @IBOutlet var lineView: UIView!

    @IBOutlet var playerNumberLabel: UILabel!
    @IBOutlet var playerNameLabel: UILabel!
    @IBOutlet var playerCityLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
        setUpCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
        setUpCustomView()
    }
    
    func setUpCustomView() {
        allElements(show: false)
        
        customView.setAddedPlayerColors()
        customView.layer.cornerRadius = 25.0
        
        for view in customView.subviews {
            if view.isKind(of: UILabel.self) {
                (view as? UILabel)?.textColor = CustomColors2.secondColor
            }
        }
        
        lineView.backgroundColor = CustomColors2.secondColor.withAlphaComponent(0.25)
    }
    
    func setUpLabels(number: Int, name: String, city: String) {
        playerNumberLabel.text = String(number) + ". Player"
        playerNameLabel.text = name
        playerCityLabel.text = city
    }
    
    func firstAnimation() {
        self.alpha = 1.0
        self.frame.size.height = 70
        self.frame.size.width = 100
        
        self.frame.origin.y -= 10.0
        self.frame.origin.x = UIScreen.main.bounds.width - self.frame.size.width - 10
        
        customView.layer.cornerRadius = 8.0
    }
    
    func secondAnimation() {
        allElements(show: true)
        
        self.frame.origin.y = UIScreen.main.bounds.height - self.frame.size.height - 10
    }
    
    func allElements(show: Bool) {
        customView.subviews.forEach { element in
            element.alpha = show ? 1.0 : 0.0
        }
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("AddedPlayerView", owner: self, options: nil)
        
        addSubview(customView)
        customView.frame = self.bounds
    }
}
