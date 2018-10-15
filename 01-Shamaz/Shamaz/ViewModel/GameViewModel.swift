//
//  GameViewModel.swift
//  Shamaz
//
//  Created by Rafal Padberg on 08.10.18.
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

class GameViewModel
{
    private var questions: Questions!
    private var allPlayers: [String]!
    
    // Remaining player names that will be reduced by every chosen player
    private var remainingPlayers: [String]!
    
    // Id of the last remaining Player
    private var lastPlayerId: Int = 0
    
    // Boolean indication wheter the player is first or last
    private var firstPlayer: Bool = false
    private(set) var lastPlayer: Bool = false
    
    init(with players: [String])
    {
        self.questions = Questions()
        self.allPlayers = players
        self.remainingPlayers = players
    }
    
    func chooseNewPlayer() -> (String)
    {
        // If only one player name left -> look for the player in playerNames-array and assign its id to a variable
        if getPlayersCount() == 1
        {
            lastPlayerId = findLastPlayerId()
            lastPlayer = true
        }
        
        var randomId = getRandomPlayersId()
        
        // If the games has been relaunched we generate a new id so long until the id will be different from lastPlayerId
        if firstPlayer
        {
            while (checkPlayers(newPlayerId: randomId, lastPlayerId: lastPlayerId))
            {
                randomId = getRandomPlayersId()
            }
            
            firstPlayer = false
        }
        
        // Remove chosen player from remainingPlayers array
        let activePlayerName = removeChosenPlayer(with: randomId)
        
        let descriptionText = "The Next Player is \(activePlayerName.uppercased()). Choose a story either in the past or in the furture. Choose wisely!"
        
        return (descriptionText)
    }
    
    // Make all players available to choose again, change basic labels and buttons texts to default
    func restartGame(veryFirstTime: Bool)
    {
        // Repeating the last player from previous game can not be possible in the very first game
        firstPlayer = veryFirstTime ? false : true
        
        // There can be no last player on restart because we start with at least 2 players
        lastPlayer = false
        remainingPlayers = allPlayers
    }
    
    // Return a message with either past or future question
    func returnQuestion(fromThePast: Bool) -> String
    {
        return questions.createMessage(fromThePast: fromThePast)
    }
    
    func changeStatusText(for status: gameMode) -> String
    {
        return status == .sharingChoice ? "Choose a story" : "Next Player"
    }
    
    private func getPlayersCount() -> Int
    {
        return remainingPlayers.count
    }
    
    private func findLastPlayerId() -> Int
    {
        return allPlayers.index(where: { $0 == self.remainingPlayers[0] } )!
    }
    
    private func getRandomPlayersId() -> Int
    {
        return Int.random(in: 0 ..< self.remainingPlayers.count)
    }
    
    private func checkPlayers(newPlayerId: Int, lastPlayerId: Int) -> Bool
    {
        return self.allPlayers[lastPlayerId] == self.remainingPlayers[newPlayerId]
    }
    
    private func removeChosenPlayer(with playerId: Int) -> String
    {
        return self.remainingPlayers.remove(at: playerId)
    }
}
