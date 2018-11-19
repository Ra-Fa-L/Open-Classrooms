//
//  IntroductionViewController.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var activePlayerLabel: UILabel!
    @IBOutlet var generateLabel: UILabel!
    
    // textField.tag == Order of TextField in Collection
    @IBOutlet var textFieldCollection: [UITextField]!
    
    @IBOutlet var generateAllButton: UIButton!
    @IBOutlet var nextPlayerButton: UIButton!
    
    var viewModel: CuriousKatieVM!
    
    var activePlayerNumber: Int = 1
    var playersCount: Int = 12
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
        setUI()
    }
    
    func setUI() {
        view.setUIColors()
        
        titleLabel.setColors()
        activePlayerLabel.setColors()
        generateLabel.setColors()
        
        nextPlayerButton.setUpButton()
        generateAllButton.setUpButton()
    }
    
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
    
    func isEverythingFilledOut() -> Bool
    {
        for field in textFieldCollection {
            if field.text! == "" {
                return false
            }
        }
        return true
    }
    
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
    
    func changeTextField(withId: Int, text: String) {
        textFieldCollection[withId].restoreDefault()
        textFieldCollection[withId].text = text
    }
    
    func checkNextPlayerButton()
    {
        nextPlayerButton.isEnabled = isEverythingFilledOut() && addingPlayerAllowed
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func addPersonToViewModel()
    {
        var playerData = [String]()
        
        textFieldCollection.forEach { textField in
            playerData.append(textField.text!)
        }
        
        viewModel.addPerson(name: playerData[0], age: Int(playerData[1])!, city: playerData[2], nationality: playerData[3])
        
        animateNewPlayer(with: playerData)
    }
    
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            self.present(nextVC!, animated: true, completion: {
                nextVC?.shuffleButtons(initially: true)
            })
        }
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        sender.restoreDefault()
        
        checkNextPlayerButton()
    }
    
    // 1 = male name, 2 = female name -> TextField.tag = 0
    // 3 = age -> TextField.tag = 1
    // 4 = city -> TextField.tag = 2
    // 5 = nationality -> TextField.tag = 3
    // 0 = all
    @IBAction func generateButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let generateAll = viewModel.generateAll()
            for (index, text) in generateAll.enumerated() {
                changeTextField(withId: index, text: text)
            }
        case 1:
            changeTextField(withId: 0, text: viewModel.generateName(male: true))
        case 2:
            changeTextField(withId: 0, text: viewModel.generateName(male: false))
        case 3:
            changeTextField(withId: 1, text: viewModel.generateAge())
        case 4:
            changeTextField(withId: 2, text: viewModel.generateCity())
        case 5:
            changeTextField(withId: 3, text: viewModel.generateNationality())
        default:
            break
        }
        
        checkNextPlayerButton()
    }
    
    @IBAction func nextPlayerButtonTapped(_ sender: UIButton) {
        if isEverythingCorrecttlyFilledOut() {
            addPersonToViewModel()
            
            if let nextPersonNumber = viewModel.checkNextPersonNumber() {
                
                activePlayerNumber = nextPersonNumber
                updateUI()
                
                if nextPersonNumber == playersCount {
                    nextPlayerButton.setTitle("LAST PLAYER", for: .normal)
                }
            } else {
                addingPlayerAllowed = false
                generateAllButton.isEnabled = false
                
                goToNextView()
            }
        }
    }
    
    @IBAction func goBackTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
