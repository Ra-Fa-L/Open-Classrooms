//
//  NamesTableViewCell.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 12.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class NamesTableViewCell: UITableViewCell {

    
    @IBOutlet var playerLabel: UILabel!
    @IBOutlet var interestCount: UILabel!
    @IBOutlet var imageStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // If interest is chosen change background and alpha
    func highlighChosen(_ interests: [Interest], _ unshared: [Int]) {
        for (index, image) in imageStackView.subviews.enumerated() {
            let imageView = (image as! UIImageView)
            
            imageView.alpha = 0.2
            imageView.backgroundColor = UIColor.clear
            imageView.image = UIImage(named: interests[index].name.lowercased())
            
            if unshared.contains(index) {
                imageView.backgroundColor = customColorTheme.darkGray.withAlphaComponent(0.2)
                imageView.layer.cornerRadius = 6.0
                imageView.alpha = 1.0
            }
        }
    }
}
