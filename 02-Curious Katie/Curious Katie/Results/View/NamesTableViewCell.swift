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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
