//
//  GameViewController.swift
//  Shamaz
//
//  Created by Rafal Padberg on 07.10.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

enum gameMode
{
    case none
    case playerChoice
    case sharingChoice
}

class GameViewController: UIViewController
{
    @IBOutlet var pastButton: UIButton!
    @IBOutlet var futureButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    let pastQuotesSingular = [
        "What have you eaten yesterday for a breakfast?",
        "Did you leave your town yesterday?",
        "How long were you watching movies yesterday?",
        "Did you workout yesterday?",
        "What is the funiest thing that happened to you yesterday?",
        "Did you sleep well yesterday?",
        ]
    
    let pastQuotesPlural = [
        "What ist the best meal you have eaten in you last ",
        "Did you leave your town in the last ",
        "How many movies did you watch in the last ",
        "Did you workout in last ",
        "What is the funiest thing that happened to you in last ",
        "How long did you sleep in your last ",
        ]
    
    let pastQuotesPlural2 = [
        "What did you eat ",
        "Where were you besides home ",
        "What did you watch on the TV ",
        "Did you meet some friends or family ",
        "Can you recall something funny from ",
        "Did you go to work ",
        ]
    
    let futureQuotesSingular = [
        "What will you eat tomorrow for a dinner?",
        "Will you go somewhere tomorrow?",
        "Have something planned for tommorow?",
        "Tommorow is a great day to exercise don't you think?",
        "Do you intend to do something crazy tomorrow?",
        "When will you wake up tommorow?",
        ]
    
    let futureQuotesPlural = [
        "What restaurant are going to visit in the next ",
        "Will you leave your town in the next ",
        "What movies are are looking forward to see in the next ",
        "Will you work out in the next ",
        "What is the craziest thing you will be doing in your next ",
        "Will you see any of your family members in the next ",
        "Do you have some special plans for the next ",
        "Will you drive you car in  ",
        "Will you attend any concert or something simmilar within the next ",
        "Does anyone from you family or friends have a birthday in the next ",
        "Will you have a vacation in the next ",
        "What will you buy in ",
        ]
    
    var playerNames: [String] = []
    var remainingPlayers: [String] = []
    var lastPlayerId: Int = 0
    var activePlayerName: String = ""
    
    var firstPlayer: Bool = false
    var lastPlayer: Bool = false
    
    var newGame = true
    
    var gameStatus: gameMode = .none
    
    var descriptionText: String = "" {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    var continueText: String = "" {
        didSet {
            nextButton.setTitle(continueText, for: .normal)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = ColorTheme.backgroundColor
        
        pastButton.setOrangeButtons()
        futureButton.setOrangeButtons()
        
        nextButton.setGreenButtons()
        
        restartGame()
    }
    
    func chooseNewPlayer()
    {
        let playersCount = remainingPlayers.count
        
        if playersCount == 1 {
            lastPlayerId = playerNames.index(where: { $0 == remainingPlayers[0] } )!
            lastPlayer = true
        }
        
        var randomId = getRandomPlayersId(count: playersCount)
        
        if firstPlayer {
            while (playerNames[lastPlayerId] == remainingPlayers[randomId]) {
                randomId = getRandomPlayersId(count: playersCount)
            }
            
            firstPlayer = false
        }
        
        changeGameStatus(to: .sharingChoice)
        
        descriptionText = "The Next Player is \(remainingPlayers[randomId].uppercased()). Choose a story either in the past or in the furture. Choose wisely!"
        
        activePlayerName = remainingPlayers.remove(at: randomId)
    }
    
    func getRandomPlayersId(count: Int) -> Int
    {
        let id = Int.random(in: 0 ..< count)
        return id
    }
    
    func restartGame()
    {
        changeGameStatus(to: .playerChoice)
        
        enableButton(past: false, future: false, next: true)
        descriptionText = "Tap START to begin the Game. A random player will be chosen randomly."
        continueText = "START"
        
        
        firstPlayer = newGame ? false : true
        newGame = false
        lastPlayer = false
        
        remainingPlayers = playerNames
    }
    
    func enableButton(past: Bool, future: Bool, next: Bool)
    {
        pastButton.isEnabled = past
        futureButton.isEnabled = future
        nextButton.isEnabled = next
    }
    
    func changeGameStatus(to status: gameMode)
    {
        gameStatus = status
        if status == .sharingChoice {
            enableButton(past: true, future: true, next: false)
            continueText = "Choose a story"
            
            pastButton.alpha = 1
            futureButton.alpha = 1
            
            nextButton.alpha = 0.3
        } else {
            enableButton(past: false, future: false, next: true)
            continueText = "Next Player"
            
            nextButton.alpha = 1.0
        }
    }
    
    func createMessage(inThePast: Bool) -> String
    {
        let number = Int.random(in: 1 ... 13)
        
        print(number)
        
        var message = ""
        if inThePast {
            if number == 1 {
                
                let secondNumber = Int.random(in: 0 ..< 6)
                message = pastQuotesSingular[secondNumber]
            } else {
                if number > 7 {
                    message = pastQuotesPlural2[number - 8] + "\(number) days ago?"
                } else {
                    message = pastQuotesPlural[number - 2] + "\(number) days?"
                }
            }
        } else {
            if number == 1 {
                
                let secondNumber = Int.random(in: 0 ..< 6)
                message = futureQuotesSingular[secondNumber]
            } else {
                message = futureQuotesPlural[number - 2] + "\(number) days?"
            }
        }
        return message
    }
    
    @IBAction func storyButtonTapped(_ sender: UIButton)
    {
        let past = sender.tag == 0 ? true : false
        descriptionText = createMessage(inThePast: past)
        changeGameStatus(to: .playerChoice)
        
        if sender.tag == 1 {
            pastButton.alpha = 0.3
        } else {
            futureButton.alpha = 0.3
        }
        
        if lastPlayer {
            continueText = "RESTART GAME"
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton)
    {
        if gameStatus == .playerChoice {
            if lastPlayer {
                restartGame()
            } else {
                chooseNewPlayer()
            }
        }
    }
}
