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
    @IBOutlet private var pastButton: UIButton!
    @IBOutlet private var futureButton: UIButton!
    @IBOutlet private var nextButton: UIButton!
    @IBOutlet private var descriptionLabel: UILabel!
    
    // Game object with data and logic
    var game: Game!
    
    // Will be either .playerChoice or .sharingChoice
    private var gameStatus: gameMode = .none
    
    // Variable to hold descriptionLabel text -> Label.text will be reassigned with each change of this variable
    private var descriptionText: String = ""
    {
        didSet
        {
            descriptionLabel.text = descriptionText
        }
    }
    
    // Change of the Text of the nextButton will be assigned to this variable -> title will be changed with it
    private var continueText: String = ""
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
    
    // Make all players available to choose again, change basic labels and buttons texts to default
    // Change game status to choosing a player
    private func restartGame(veryFirstTime: Bool = false)
    {
        (descriptionText, continueText) = game.restartGame(veryFirstTime: veryFirstTime)
        
        changeGameStatus(to: .playerChoice)
    }
    
    private func chooseNewPlayer()
    {
        (descriptionText) = game.chooseNewPlayer()
        
        changeGameStatus(to: .sharingChoice)
    }
    
    private func lastPlayerPlaying() -> Bool
    {
        return game.lastPlayer
    }
    
    // Make each individual button either enabled or not
    private func enableButton(past: Bool, future: Bool, next: Bool)
    {
        pastButton.display(enabled: past)
        futureButton.display(enabled: future)
        nextButton.display(enabled: next)
    }
    
    // Changes enabled Buttons acoording to gameStatus
    // Changes alpha of the Buttons and continueText as well
    private func changeGameStatus(to status: gameMode)
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
    
    private func applyUIColors()
    {
        view.backgroundColor = ColorTheme.backgroundColor
        
        pastButton.setOrange()
        futureButton.setOrange()
        
        nextButton.setGreen()
    }
    
    // Create message depending on chosen button and highlight chosen button
    // If lastPlayer, change the nextButton's text to Restart Game
    @IBAction private func storyButtonTapped(_ sender: UIButton)
    {
        let past = sender.tag == 0 ? true : false
        
        descriptionText = game.returnQuestion(fromThePast: past)
        
        changeGameStatus(to: .playerChoice)
        
        sender.highlight()
        
        if lastPlayerPlaying()
        {
            continueText = "RESTART GAME"
        }
    }
    
    @IBAction private func nextButtonTapped(_ sender: UIButton)
    {
        // Not needed because the button cannot be tapped when in different game state
        // It is here for the logical overview
        if gameStatus == .playerChoice
        {
            // If lastPlayer make the next nextButton tap restart the game
            if lastPlayerPlaying()
            {
                restartGame()
            }
            // Otherwise choose a random new player
            else
            {
                chooseNewPlayer()
            }
        }
    }
}
