//
//  InterestsSharingDelegate.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 09.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import Foundation

// The delegate is needed to make a connection from InterestsSelectionView back to InterestSharingViewController
protocol InterestsSharingDelegate {
    func confirmChoice()
    func fadeButton()
}
