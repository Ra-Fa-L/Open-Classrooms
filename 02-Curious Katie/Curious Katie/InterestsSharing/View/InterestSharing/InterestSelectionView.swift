//
//  InterestSelectionView.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 09.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class InterestSelectionView: UIView {
    
    @IBOutlet var customView: UIView!
    
    @IBOutlet var extraInformationLabel: UILabel!
    @IBOutlet var levelOfInterestLabel: UILabel!
    @IBOutlet var extraTextView: UITextView!
    @IBOutlet var levelSegmentedControl: UISegmentedControl!
    @IBOutlet var generateAllButton: UIButton!
    @IBOutlet var noMoreButton: UIButton!
    @IBOutlet var interestsPickerView: CustomPickerView!
    
    var viewModel: CuriousKatieViewModel!
    var delegate: InterestsSharingDelegate!
    
    var activePlayer: Player!
    
    func initalAnim() {
        Bundle.main.loadNibNamed("InterestSelectionView", owner: self, options: nil)
        addSubview(customView)
        customView.frame = self.bounds
        
        customView.backgroundColor = CustomColors2.secondColor
        
        self.frame.origin.x = -frame.width
        self.frame.origin.y += UIScreen.main.bounds.height
        
        self.roundCorners(corners: [.topRight, .bottomRight], radius: 10.0)
        
        UIView.animate(withDuration: 0.6) {
            self.frame.origin.x = 0
            self.frame.origin.y -= UIScreen.main.bounds.height
        }
        
        extraTextView.layer.cornerRadius = 8.0
        
        setUpCustomPickerView()
        createPlaceholderText()
    }
    
    func changePlayerAnimation(with player: Player)
    {
        activePlayer = player
        
        UIView.animate(withDuration: 0.4, animations:
            {
                self.alpha = 0.6
        }, completion:
            { (error) in
                self.createPlaceholderText()
                self.levelSegmentedControl.selectedSegmentIndex = 2
                
                UIView.animate(withDuration: 0.4, animations:
                    {
                        self.alpha = 1.0
                })
        })
        injectDataIntoPicker()
    }
    
    func createPlaceholderText() {
        let attribute = [NSAttributedString.Key.font: UIFont(name: "Avenir-Light", size: 12.0)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        
        let fullString = NSMutableAttributedString(string: "Add extra info or generate it", attributes: attribute)
        
        extraTextView.attributedText = fullString
    }
    
    func injectDataIntoPicker()
    {
        interestsPickerView.neededData = viewModel.getNeededData()
        interestsPickerView.reset()
    }
    
    func setUpCustomPickerView()
    {
        injectDataIntoPicker()
        
        interestsPickerView.interests = viewModel.allInterests()
        
        interestsPickerView.delegate = interestsPickerView
        interestsPickerView.dataSource = interestsPickerView
    }

    @IBAction func generateExtraInfoTapped(_ sender: UIButton?) {
        extraTextView.attributedText = NSAttributedString(string: viewModel.generateInterestExtras(id: interestsPickerView.selectedRow))
    }
    
    @IBAction func generateInterestLevelTapped(_ sender: UIButton?) {
        levelSegmentedControl.selectedSegmentIndex = viewModel.generateLevel()
    }
    
    @IBAction func generateInterestTapped(_ sender: UIButton?) {
        let interestId = viewModel.generateInterest()
        interestsPickerView.selectRow(interestId, inComponent: 0, animated: true)
        
        generateExtraInfoTapped(nil)
    }
    
    @IBAction func generateAllTapped(_ sender: UIButton) {
        generateInterestTapped(nil)
        generateInterestLevelTapped(nil)
    }
    
    @IBAction func confirmTapped(_ sender: UIButton) {
        
        let extraText = extraTextView.text!
        let level = levelSegmentedControl.selectedSegmentIndex
        let number = viewModel.addInterest(rowId: interestsPickerView.selectedRow, extraText: extraText, level: level)
        
        if number == 9
        {
            viewModel.noMoreInterest()
            delegate.fadeButton()
        }
        delegate.confirmChoice()
    }
    
    @IBAction func noMoreTapped(_ sender: UIButton) {
        
        viewModel.noMoreInterest()
        
        delegate.fadeButton()
        delegate.confirmChoice()
    }
}
