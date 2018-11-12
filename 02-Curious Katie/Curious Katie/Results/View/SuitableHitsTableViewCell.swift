//
//  SuitableHitsTableViewCell.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 12.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class SuitableHitsTableViewCell: UITableViewCell {

    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var secondNameLabel: UILabel!
    @IBOutlet var imageStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func makeVisible(_ interests: [String], _ unshared: [Int]) {
        for (index, image) in imageStackView.subviews.enumerated() {
            (image as? UIImageView)?.alpha = 0.2
            (image as? UIImageView)?.image = UIImage(named: interests[index].lowercased())
            
            if unshared.contains(index) {
                (image as? UIImageView)?.alpha = 1.0
            }
        }
    }

}
