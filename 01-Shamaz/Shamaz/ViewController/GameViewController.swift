//
//  GameViewController.swift
//  Shamaz
//
//  Created by Rafal Padberg on 07.10.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class GameViewController: UIViewController
{
    @IBOutlet var pastButton: UIButton!
    @IBOutlet var futureButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var descriptionLabel: UILabel!
    
    // Object with all Questions
    var game: Game!
    
    // Will be either .playerChoice or .sharingChoice
    var gameStatus: gameMode = .none
    
    // Variable to hold descriptionLabel text -> Label.text will be reassigned with each change of this variable
    var descriptionText: String = ""
    {
        didSet
        {
            descriptionLabel.text = descriptionText
        }
    }
    
    // Change of the Text of the nextButton will be assigned to this variable -> title will be changed with it
    var continueText: String = ""
    {
        didSet
        {
            nextButton.setTitle(continueText, for: .normal)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        applyUIColors()
        
        restartGame(veryFirstTime: true)
    }
    
    // Make all players to available to choose again, change basic labels and buttons texts to default
    // Change game status to choosing a player
    func restartGame(veryFirstTime: Bool = false)
    {
        (descriptionText, continueText) = game.restartGame(veryFirstTime: veryFirstTime)
        
        changeGameStatus(to: .playerChoice)
    }
    
    func chooseNewPlayer()
    {
        (descriptionText) = game.chooseNewPlayer()
        
        changeGameStatus(to: .sharingChoice)
    }
    
    func lastPlayerPlaying() -> Bool
    {
        return game.lastPlayer
    }
    
    // Make each individual button either enabled or not
    func enableButton(past: Bool, future: Bool, next: Bool)
    {
        pastButton.display(enabled: past)
        futureButton.display(enabled: future)
        nextButton.display(enabled: next)
    }
    
    // Changes enabled Buttons acoording to gameStatus
    // Changes alpha of the Buttons and continueText as well
    func changeGameStatus(to status: gameMode)
    {
        gameStatus = status
        if status == .sharingChoice
        {
            enableButton(past: true, future: true, next: false)
        }
        else
        {
            enableButton(past: false, future: false, next: true)
        }
        continueText = game.changeStatusText(for: status)
    }
    
    func applyUIColors()
    {
        view.backgroundColor = ColorTheme.backgroundColor
        
        pastButton.setOrange()
        futureButton.setOrange()
        
        nextButton.setGreen()
    }
    
    // Create message depending on chosen button and change alpha of the not chosen button
    // If lastPlayer change the nextButton's text to Restart Game
    @IBAction func storyButtonTapped(_ sender: UIButton)
    {
        var past = false
        
        if sender.tag == 0
        {
            past = true
        }
        
        descriptionText = game.returnQuestion(fromThePast: past)
        changeGameStatus(to: .playerChoice)
        
        sender.highlight()
        
        if lastPlayerPlaying()
        {
            continueText = "RESTART GAME"
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton)
    {
        // Not needed because the button cannot be tapped when in different game state
        // It is here for the sake of logical overview
        print(sender.tag)
        if gameStatus == .playerChoice
        {
            print("1")
            // If lastPlayer make the next nextButton tap restart the game
            if lastPlayerPlaying()
            {
                print("LAST")
                restartGame()
            }
            else
            {
                // Otherwise choose a random new player
                chooseNewPlayer()
            }
        }
    }
}
