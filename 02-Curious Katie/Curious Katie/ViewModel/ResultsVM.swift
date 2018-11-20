//
//  ResultsVM.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import Foundation

class ResultsVM
{
    // More detailed result printing
    let fullPrinting = false
    
    let players: [Player]!
    let interests: [Interest]!
    
    // An array that hold all the possible matching results
    // [Person.Id : [Person.id : [Interest.id]]
    var personToPerson: [Int : [Int : [Int]]] = [:]
    
    init(players: [Player], interests: [Interest]) {
        self.players = players
        self.interests = interests
        
        self.createResult()
    }
    
    // This functions compares each person with each person
    // On every comparison it loops through all the interest
    // A matching hit is when: one of the player has it(interest) and other one does not OR otherwise
    // On hit it appends a differencesArray that will have all the matching interest.id
    // For example:
    //
    // [0 : [2 : [1, 2], 4 : [4]]]
    // (Player 0) can create a pair with (player 2) and (Player 4)
    // with (Player 2) based on (Interest 1) and (Interest 2)
    // with (Player 4) based on (Interest 4)
    func createResult() {
        players.forEach { (player) in
            
            print("\(player.name.uppercased())'s possible partners are:")
            print("**********************************************************")
            
            for secondPlayer in players {
                if player.id != secondPlayer.id {
                    if personToPerson[player.id] == nil {
                        personToPerson[player.id] = [:]
                    }
                    
                    let matchingInterests = interests.filter({ (interest) -> Bool in
                        let firstPlayerHas = player.interests.contains(interest)
                        let secondPlayerHas = secondPlayer.interests.contains(interest)
                        
                        return firstPlayerHas != secondPlayerHas
                    })
                    let numberOfDiffereces = matchingInterests.count
                    let differencesArray = matchingInterests.map({ (interest) -> Int in
                        return interest.id
                    })
                    
                    if numberOfDiffereces > 0 {
                        personToPerson[player.id]![secondPlayer.id] = differencesArray
                        
                        print("... \(secondPlayer.name) based on \(numberOfDiffereces) different interests")
                        
                        if fullPrinting {
                            for id in differencesArray {
                                print("........ \(interests[id].name)")
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Returns a player name with corresponding matching interests and its count
    // Because the table shows each person on each section ==> section.id = person.id
    // rowId = pairingPlayer.id:
    // [player.id : [player.id : [interst.id]]] ==> [section.id : [rowId : [Interest.id]]]
    func getPersonBased(on section: Int, and row: Int) -> (String, Int, [Int]) {
        
        let personHits = personToPerson[section]?.sorted(by: { (first, second) -> Bool in
            return first.value.count > second.value.count
        })
        let personId = personHits![row].key
        
        let person = players[personId].name
        let unsharedInterests = personHits![row].value
        let count = unsharedInterests.count
        
        return (person, count, unsharedInterests)
    }
}
