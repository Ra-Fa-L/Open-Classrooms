//
//  IntroductionViewController.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController, UITextFieldDelegate {
    
    enum textFieldType {
        case name
        case age
        case city
        case nationality
    }
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var activePlayerLabel: UILabel!
    @IBOutlet var generateLabel: UILabel!
    
    @IBOutlet var textFieldCollection: [UITextField]!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var nationalityTextField: UITextField!
    
    @IBOutlet var generateAllButton: UIButton!
    @IBOutlet var nextPlayerButton: UIButton!
    
    var viewModel: CuriousKatieVM!
    
    // Will be changed on start
    var activePlayerNumber: Int = 1
    var playersCount: Int = 12
    
    // Adding player allowed is used to allow only one animation at a time
    var addingPlayerAllowed: Bool = true {
        didSet {
            checkNextPlayerButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign Delegates to TextFields
        for textField in textFieldCollection {
            textField.delegate = self
        }
        playersCount = viewModel.playersCount
        changeActivePlayerLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if activePlayerNumber > 1 {
            // After clicking NewGame a chain of self.dismiss should fire including this one
            self.dismiss(animated: false, completion: nil)
        } else {
            DispatchQueue.main.async {
                self.setUI()
            }
        }
    }
    
    // This view should cover the whole screen. For newGame self.dismiss chain
    override func viewDidDisappear(_ animated: Bool) {
        let coverView = UIView(frame: view.frame)
        coverView.setUIColors()
        self.view.addSubview(coverView)
    }
    
    func setUI() {
        view.setUIColors()
        
        titleLabel.setColors()
        activePlayerLabel.setColors()
        generateLabel.setColors()
        
        nextPlayerButton.setUpButton()
        generateAllButton.setUpButton()
    }
    
    // Active player label shows "1. of 12 players". Because the digits are in bold a NSAttributedString will be used
    func changeActivePlayerLabel() {
        let boldAttribute = [NSAttributedString.Key.font: UIFont(name: "Avenir-Heavy", size: 18.0)!]
        
        let fullString = NSMutableAttributedString(string: String(activePlayerNumber), attributes: boldAttribute)
        let secondString = NSAttributedString(string: " of ")
        let thirdString = NSMutableAttributedString(string: String(playersCount), attributes: boldAttribute)
        let fourthString = NSAttributedString(string: " Players")
        
        fullString.append(secondString)
        fullString.append(thirdString)
        fullString.append(fourthString)
        
        activePlayerLabel.attributedText = fullString
    }
    
    func updateUI() {
        changeActivePlayerLabel()
        cleanTextFields()
    }
    
    func cleanTextFields() {
        for field in textFieldCollection {
            field.text = ""
        }
        checkNextPlayerButton()
    }
    
    // Check only if not empty
    func isEverythingFilledOut() -> Bool
    {
        for field in textFieldCollection {
            if field.text! == "" {
                return false
            }
        }
        return true
    }
    
    // Checks if is age is appropriate, name not repeating or minNumberOfLetter used
    func isEverythingCorrecttlyFilledOut() -> Bool {
        let minNumOfLetters = viewModel.minNumberOfLetters
        let ageBoundary = viewModel.ageBoundary
        
        var result = true
        
        for textField in textFieldCollection {
            if textField.tag == 1 {
                if let number = Int(textField.text!) {
                    if number < ageBoundary[0] || number > ageBoundary[1] {
                        textField.animateError(with: "Number is not allowed")
                        result = false
                    }
                } else {
                    textField.animateError(with: "It has to be a number")
                    result = false
                }
            } else {
                if textField.text!.count < minNumOfLetters {
                    textField.animateError()
                    result = false
                } else {
                    if textField.tag == 0 && !viewModel.checkIfPossible(name: textField.text!) {
                        textField.animateError(with: "Repeated Name")
                        result = false
                    }
                }
            }
        }
        
        return result
    }
    
    // Check if NextPlayerButton should be allowed
    func checkNextPlayerButton()
    {
        nextPlayerButton.isEnabled = isEverythingFilledOut() && addingPlayerAllowed
    }
    
    // Hide keyboard on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Add player and fire the animation
    func addPersonToViewModel()
    {
        var playerData = [String]()
        
        textFieldCollection.forEach { textField in
            playerData.append(textField.text!)
        }
        
        viewModel.addPerson(name: playerData[0], age: Int(playerData[1])!, city: playerData[2], nationality: playerData[3])
        
        animateNewPlayer(with: playerData)
    }
    
    // Animates the addition of player
    // It moved newly added player to the bottom right and stays there until a new player will be addded
    func animateNewPlayer(with data: [String])
    {
        let currentActivePlayer = activePlayerNumber
        addingPlayerAllowed = false
        
        let frame = CGRect(origin: nextPlayerButton.frame.origin, size: CGSize(width: 0, height: 0))
        
        let addedPlayerView = AddedPlayerView(frame: frame)
        addedPlayerView.setUpLabels(number: currentActivePlayer, name: data[0], city: data[2])
        
        self.view.addSubview(addedPlayerView)
        
        UIView.animate(withDuration: 0.6, animations: {
            addedPlayerView.moveToTheRight()
        }) { [weak self] _ in
            
            UIView.animate(withDuration: 0.9, animations: {
                addedPlayerView.moveDown()
                
                self?.addingPlayerAllowed = self!.viewModel.checkNextPersonNumber() == nil ? false : true
                
                if currentActivePlayer != 1 {
                    let subviews = self!.view.subviews
                    let lastAdded = subviews[subviews.count - 2]
                    
                    UIView.animate(withDuration: 0.9, animations: {
                            lastAdded.frame.origin.y += lastAdded.frame.size.height + 30
                            lastAdded.alpha = 0.2
                            
                    }, completion: { _ in
                            lastAdded.removeFromSuperview()
                    })
                }
            })
        }
    }
    
    func goToNextView() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "InterestsSharingVC") as? InterestsSharingViewController
        nextVC?.viewModel = viewModel
        
        // Wait for the animation to finish
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            self.present(nextVC!, animated: true, completion: {
                nextVC?.shuffleButtons(initially: true)
            })
        }
    }
    
    // Fires on every change in each textFields
    @IBAction func textFieldChanged(_ sender: UITextField) {
        sender.restoreDefault()
        
        checkNextPlayerButton()
    }
    
    @IBAction func generateButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let generateAll = viewModel.generateAll()
        
            nameTextField.change(text: generateAll[0])
            ageTextField.change(text: generateAll[1])
            cityTextField.change(text: generateAll[2])
            nationalityTextField.change(text: generateAll[3])
        case 1:
            nameTextField.change(text: viewModel.generateName(male: true))
        case 2:
            nameTextField.change(text: viewModel.generateName(male: false))
        case 3:
            ageTextField.change(text: viewModel.generateAge())
        case 4:
            cityTextField.change(text: viewModel.generateCity())
        case 5:
            nationalityTextField.change(text: viewModel.generateNationality())
        default:
            break
        }
        
        checkNextPlayerButton()
    }
    
    // Add new player and animate. If last player has been added goToNextView
    @IBAction func nextPlayerButtonTapped(_ sender: UIButton) {
        if isEverythingCorrecttlyFilledOut() {
            addPersonToViewModel()
            
            if let nextPersonNumber = viewModel.checkNextPersonNumber() {
                
                activePlayerNumber = nextPersonNumber
                updateUI()
                
                if nextPersonNumber == playersCount {
                    nextPlayerButton.setTitle("PROCEED", for: .normal)
                }
            } else {
                addingPlayerAllowed = false
                generateAllButton.isEnabled = false
                
                goToNextView()
            }
        }
    }
    
    // For quickly relaunching a game
    @IBAction func goBackTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
