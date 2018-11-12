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
    
    var viewModel: CuriousKatieViewModel!
    var delegate: InterestsSharingDelegate!
    
    let placeholderText = "Add extra info or generate it"
    
    func initialSetUp() {
        Bundle.main.loadNibNamed("InterestSelectionView", owner: self, options: nil)
        addSubview(customView)
        customView.frame = self.bounds
        
        customView.backgroundColor = CustomColors2.secondColor
        extraTextView.layer.cornerRadius = 8.0
        
        initialAnimation()
        
        setUpCustomPickerView()
        createPlaceholderText()
        
        extraTextView.delegate = self
        
        generateAllButton.make2ndButton()
    }
    
    func initialAnimation() {
        self.frame.origin.x = -frame.width
        self.frame.origin.y += UIScreen.main.bounds.height
        self.roundCorners(corners: [.topRight, .bottomRight], radius: 10.0)
        
        UIView.animate(withDuration: 0.6) {
            self.frame.origin.x = 0
            self.frame.origin.y -= UIScreen.main.bounds.height
        }
    }
    
    func changePlayerAnimation() {
        UIView.animate(withDuration: 0.2, animations: {
                self.alpha = 0.5
        }, completion: { (error) in
                self.createPlaceholderText()
                self.levelSegmentedControl.selectedSegmentIndex = 2
                
                UIView.animate(withDuration: 0.2, animations: {
                        self.alpha = 1.0
                })
        })
        injectDataIntoPicker()
    }
    
    func createPlaceholderText() {
        let attribute = [NSAttributedString.Key.font: UIFont(name: "Avenir-Light", size: 12.0)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let fullString = NSMutableAttributedString(string: placeholderText, attributes: attribute)
        
        extraTextView.attributedText = fullString
    }
    
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
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == placeholderText {
            textView.text = ""
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.last == "\n" {
            textView.text = String(textView.text.dropLast())
            textView.resignFirstResponder()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeholderText
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
    
    @IBAction func confirmTapped(_ sender: UIButton) {
        let extraText = extraTextView.text!
        let level = levelSegmentedControl.selectedSegmentIndex
        
        let playerInterestCount = viewModel.addInterest(rowId: interestsPickerView.selectedRow, extraText: extraText, level: level)
        
        if playerInterestCount == 10
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
