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
    
    // Set up colors of each element
    // All UI elements but View should be hidden until they reach end of the first animation (moveToTheRight)
    func setUpCustomView() {
        allElements(show: false)
        
        customView.setAddedPlayerView()
        
        for view in customView.subviews {
            if view.isKind(of: UILabel.self) {
                (view as? UILabel)?.setColors()
            }
        }
        lineView.backgroundColor = UIColor.white.withAlphaComponent(0.15)
    }
    
    func setUpLabels(number: Int, name: String, city: String) {
        playerNumberLabel.text = String(number) + ". Player"
        playerNameLabel.text = name
        playerCityLabel.text = city
    }
    
    // Grow in size and move to the right
    func moveToTheRight() {
        self.alpha = 1.0
        self.frame.size.height = 70
        self.frame.size.width = 100
        
        self.frame.origin.y -= 10.0
        self.frame.origin.x = UIScreen.main.bounds.width - self.frame.size.width - 10
        
        customView.layer.cornerRadius = 8.0
    }
    
    // Show all elements again and move to the bottom
    func moveDown() {
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
