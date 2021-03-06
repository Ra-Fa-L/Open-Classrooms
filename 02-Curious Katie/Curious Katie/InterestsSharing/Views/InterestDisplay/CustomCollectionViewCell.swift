//
//  CustomCollectionViewCell.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 12.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var customImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // Change backgorund color depending whether the interest is chosen
    func prepareImage(chosen: Bool, name: String) {
        let alpha: CGFloat = chosen ? 1.0 : 0.1
        
        self.backgroundColor = customColorTheme.yellow.withAlphaComponent(alpha)
        self.layer.cornerRadius = chosen ? 16.0 : 6.0
        self.customImageView.image = UIImage(named: name)
    }
}
