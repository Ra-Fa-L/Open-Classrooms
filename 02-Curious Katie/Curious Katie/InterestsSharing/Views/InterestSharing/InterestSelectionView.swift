//
//  InterestSelectionView.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 09.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class InterestSelectionView: UIView, UITextViewDelegate {
    
    @IBOutlet var customView: UIView!
    
    @IBOutlet var extraInformationLabel: UILabel!
    @IBOutlet var levelOfInterestLabel: UILabel!
    @IBOutlet var extraTextView: UITextView!
    @IBOutlet var levelSegmentedControl: UISegmentedControl!
    @IBOutlet var generateAllButton: UIButton!
    @IBOutlet var noMoreButton: UIButton!
    @IBOutlet var interestsPickerView: CustomPickerView!
    
    var viewModel: CuriousKatieVM!
    // Connection to InterestsSharingViewController
    var delegate: InterestsSharingDelegate!
    
    // Workaround to make TextView show placeholderText
    let placeholderText = "Add extra info or generate it"
    
    func initialSetUp() {
        Bundle.main.loadNibNamed("InterestSelectionView", owner: self, options: nil)
        addSubview(customView)
        customView.frame = self.bounds
        
        initialAnimation()
        createPlaceholderText()
        
        extraTextView.delegate = self
        
        setUpCustomPickerView()
        
        // UI related
        customView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.75)
        extraTextView.layer.cornerRadius = 8.0
        generateAllButton.setUpLightColoredButton()
        tintColor = customColorTheme.darkGray
    }
    
    // Appear from the left of the screen
    func initialAnimation() {
        self.frame.origin.x = -frame.width
        self.roundCorners(corners: [.topRight, .bottomRight], radius: 10.0)
        
        UIView.animate(withDuration: 0.6) {
            self.frame.origin.x = 0
        }
    }
    
    // Animate reduction of alpha to indicate change of player
    // Injects needed data for the picker to show already chosen interesets by the active player
    func changePlayerAnimation() {
        UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 0.6
        }, completion: { (error) in
                self.createPlaceholderText()
                self.levelSegmentedControl.selectedSegmentIndex = 2
                
                UIView.animate(withDuration: 0.2, animations: {
                        self.alpha = 1.0
                })
        })
        injectDataIntoPicker()
    }
    
    // Placeholder text reduced in color
    func createPlaceholderText() {
        let attribute = [NSAttributedString.Key.font: UIFont(name: "Avenir-Light", size: 12.0)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let fullString = NSMutableAttributedString(string: placeholderText, attributes: attribute)
        
        extraTextView.attributedText = fullString
    }
    
    func createBlackText() {
        let attribute = [NSAttributedString.Key.font: UIFont(name: "Avenir", size: 12.0)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        let fullString = NSMutableAttributedString(string: " ", attributes: attribute)
        
        extraTextView.attributedText = fullString
        extraTextView.attributedText = NSAttributedString(string: "")
    }
    
    // Will be fired once on the appearance of the interestSelectionView
    // Sets picker delegates and injects neeeded data
    func setUpCustomPickerView() {
        injectDataIntoPicker()
        interestsPickerView.interests = viewModel.getAllInterests()
        
        interestsPickerView.delegate = interestsPickerView
        interestsPickerView.dataSource = interestsPickerView
    }
    
    func injectDataIntoPicker()
    {
        interestsPickerView.neededData = viewModel.getNeededPickerData()
        interestsPickerView.reloadPickerView()
    }
    
    // If the text == placeholderText => delete it
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == placeholderText {
            createBlackText()
        }
        return true
    }
    
    // Hide Keyboard on Return
    // It makes the user not able to make "\n" in the textView
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.last == "\n" {
            textView.text = String(textView.text.dropLast())
            textView.resignFirstResponder()
        }
    }
    
    // If no text was typed change to placeholder text
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            createPlaceholderText()
        }
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
    
    // Add new Interest to the player and chose next player through delegate.confirmChoice()
    // If its 10th chosen interest of the player, make player.stillChoosing = false
    @IBAction func confirmTapped(_ sender: UIButton) {
        let extraText = extraTextView.text == placeholderText ? "" : extraTextView.text!
        let level = levelSegmentedControl.selectedSegmentIndex
        
        let playerInterestCount = viewModel.addInterest(rowId: interestsPickerView.selectedRow, extraText: extraText, level: level)
        
        if playerInterestCount == 10
        {
            viewModel.noMoreInterest()
            delegate.fadeButton()
        }
        delegate.confirmChoice()
    }
    
    // Player.stillChoosing will be set to false
    @IBAction func noMoreTapped(_ sender: UIButton) {
        viewModel.noMoreInterest()
        
        delegate.fadeButton()
        delegate.confirmChoice()
    }
}
