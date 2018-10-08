//
//  Game.swift
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

class Game
{
    var questions: Questions!
    var allPlayers: [String]!
    // Player names that will be reduced by every chosen player
    var remainingPlayers: [String]!
    
    // Id of the last remaining Player
    var lastPlayerId: Int = 0
    
    // Boolean indication wheter the player is first or last
    var firstPlayer: Bool = false
    var lastPlayer: Bool = false
    
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
    
    // Make all players to available to choose again, change basic labels and buttons texts to default
    // Change game status to choosing a player
    func restartGame(veryFirstTime: Bool) -> (String, String)
    {
        let descriptionText = "Tap START to begin the Game. A random player will be chosen randomly."
        let continueText = "START"
        
        // Not reapeting the last player from previous game can not be possible in very first game
        firstPlayer = veryFirstTime ? false : true
        
        // There can be no last player on restart because we start with at least 2 players
        lastPlayer = false
        
        remainingPlayers = allPlayers
        
        return (descriptionText, continueText)
    }
    
    /*
     Return a message with either past or future question
     
     If inThePast == true -> fetch from past-Array | if false -> fetch from future
     
     If random number is 1 -> Singular question
     
     If random number is 2-13 (case Future):
     Fetch a message from Plural but subtract 2 for the id
     num = 2-13 -> id = 0-11 | id = num - 2
     
     2 different endings (case Past):
     num 2-7 -> id = 0-5 from pastPlural | id = num - 2
     num 8-13 -> id = 0-5 from pastPlural2 | id = num - 8
     */
    func returnQuestion(fromThePast: Bool) -> String
    {
        let number = Int.random(in: 1 ... 13)
        
        var message = ""
        if fromThePast
        {
            if number == 1
            {
                let secondNumber = Int.random(in: 0 ..< 6)
                message = self.questions.pastSingular[secondNumber]
            }
            else
            {
                if number > 7
                {
                    message = self.questions.pastPlural2[number - 8] + "\(number) days ago?"
                }
                else
                {
                    message = self.questions.pastPlural[number - 2] + "\(number) days?"
                }
            }
        }
        else
        {
            if number == 1
            {
                let secondNumber = Int.random(in: 0 ..< 6)
                message = self.questions.futureSingular[secondNumber]
            }
            else
            {
                message = self.questions.futurePlural[number - 2] + "\(number) days?"
            }
        }
        return message
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
