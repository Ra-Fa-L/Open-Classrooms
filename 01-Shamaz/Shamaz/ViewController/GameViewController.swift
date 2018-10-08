//
//  GameViewController.swift
//  Shamaz
//
//  Created by Rafal Padberg on 07.10.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

// Instead of using true or false for gameStatus, using enum makes it more understandable
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
    
    // All players
    var playerNames: [String] = []
    
    // Id of the last remaining Player
    var lastPlayerId: Int = 0
    
    // Boolean indication wheter the player is first or last
    var firstPlayer: Bool = false
    var lastPlayer: Bool = false
    
    // Only true for the first launch
    var newGame = true
    
    // Will be either .playerChoice or .sharingChoice
    var gameStatus: gameMode = .none
    
    // Object with all Questions
    var game: Game!
    
    // Variable to hold descriptionLabel text -> Label.text will be reassigned with each change of this variable
    var descriptionText: String = "" {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    // Change of the Text of the nextButton will be assigned to this variable -> title will be changed with it
    var continueText: String = "" {
        didSet {
            nextButton.setTitle(continueText, for: .normal)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        applyUIColors()
        
        restartGame()
    }
    
    func chooseNewPlayer()
    {
        // If last player -> look for the player in playerNames-array and assign its i to variable
        if game.getPlayersCount() == 1 {
            lastPlayerId = game.findLastPlayerId()
            lastPlayer = true
        }
        
        var randomId = getRandomPlayersId()
        
        // If the games has been relaunched we generate a new id so long until the id will be different from lastPlayerId
        if firstPlayer {
            while (game.checkPlayers(newPlayerId: randomId, lastPlayerId: lastPlayerId)) {
                randomId = getRandomPlayersId()
            }
            
            firstPlayer = false
        }
        
        // Now change Buttons availabilty
        changeGameStatus(to: .sharingChoice)
        
        // Remove chosen player from remainingPlayers array
        let activePlayerName = game.removeChosenPlayer(with: randomId)
        
        descriptionText = "The Next Player is \(activePlayerName.uppercased()). Choose a story either in the past or in the furture. Choose wisely!"
    }
    
    // Generate and return a random id from 0 to COUNT (not included)
    func getRandomPlayersId() -> Int
    {
        return game.getRandomPlayersId()
    }
    
    // Make all players to available to choose again, change basic labels and buttons texts to default
    // Change game status to choosing a player
    func restartGame()
    {
        changeGameStatus(to: .playerChoice)
        
        enableButton(past: false, future: false, next: true)
        
        descriptionText = "Tap START to begin the Game. A random player will be chosen randomly."
        continueText = "START"
        
        // Not reapeting the last player from previous game can not be possible in very first game
        firstPlayer = newGame ? false : true
        newGame = false
        // There can be no last player on restart because we start with at least 2 players
        lastPlayer = false
        
        game = Game(with: playerNames)
    }
    
    // Make each individual button either enabled or not
    func enableButton(past: Bool, future: Bool, next: Bool)
    {
        pastButton.isEnabled = past
        futureButton.isEnabled = future
        nextButton.isEnabled = next
    }
    
    // Changes enabled Buttons acoording to gameStatus
    // Changes alpha of the Buttons and continueText as well
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
    
    func applyUIColors()
    {
        view.backgroundColor = ColorTheme.backgroundColor
        
        pastButton.setOrangeButtons()
        futureButton.setOrangeButtons()
        
        nextButton.setGreenButtons()
    }
    
    // Create message depending on chosen button and change alpha of the not chosen button
    // If lastPlayer change the nextButton's text to Restart Game
    @IBAction func storyButtonTapped(_ sender: UIButton)
    {
        var past = false
        
        if sender.tag == 1 {
            pastButton.alpha = 0.3
        } else {
            futureButton.alpha = 0.3
            past = true
        }
        
        descriptionText = game.returnQuestion(fromThePast: past)
        changeGameStatus(to: .playerChoice)
        
        if lastPlayer {
            continueText = "RESTART GAME"
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton)
    {
        // Not needed because the button cannot be tapped when in different game state
        // It is here for the sake of logical overview
        if gameStatus == .playerChoice {
            // If lastPlayer make the next nextButton tap restart the game
            if lastPlayer {
                restartGame()
            } else {
                // Otherwise choose a random new player
                chooseNewPlayer()
            }
        }
    }
}
