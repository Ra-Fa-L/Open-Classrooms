//
//  Game.swift
//  Shamaz
//
//  Created by Rafal Padberg on 08.10.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class Game
{
    var questions: Questions!
    var allPlayers: [String]!
    // Player names that will be reduced by every chosen player
    var remainingPlayers: [String]!
    
    init(with players: [String])
    {
        self.questions = Questions()
        self.allPlayers = players
        self.remainingPlayers = players
    }
    
    func getPlayersCount() -> Int
    {
        return remainingPlayers.count
    }
    
    func findLastPlayerId() -> Int
    {
        return allPlayers.index(where: { $0 == self.remainingPlayers[0] } )!
    }
    
    func getRandomPlayersId() -> Int
    {
        return Int.random(in: 0 ..< self.remainingPlayers.count)
    }
    
    func checkPlayers(newPlayerId: Int, lastPlayerId: Int) -> Bool
    {
        return self.allPlayers[lastPlayerId] == self.remainingPlayers[newPlayerId]
    }
    
    func removeChosenPlayer(with playerId: Int) -> String
    {
        return self.remainingPlayers.remove(at: playerId)
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
        if fromThePast {
            if number == 1 {
                
                let secondNumber = Int.random(in: 0 ..< 6)
                message = self.questions.pastSingular[secondNumber]
            } else {
                if number > 7 {
                    message = self.questions.pastPlural2[number - 8] + "\(number) days ago?"
                } else {
                    message = self.questions.pastPlural[number - 2] + "\(number) days?"
                }
            }
        } else {
            if number == 1 {
                
                let secondNumber = Int.random(in: 0 ..< 6)
                message = self.questions.futureSingular[secondNumber]
            } else {
                message = self.questions.futurePlural[number - 2] + "\(number) days?"
            }
        }
        return message
    }
}
