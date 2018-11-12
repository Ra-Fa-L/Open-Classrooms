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
    let players: [Player]!
    let interests: [String]!
    
    var interestToPerson = [Int : [Int]]()
    var personToPerson = [Int : [Int : [Int]]]()
    var hitsToPerson = [Int : [Int : Int]]()
    
    init(players: [Player], interests: [String]) {
        self.players = players
        self.interests = interests
        
        self.createAllResults()
    }
    
    func createIntrestToPersonResults() {
        for person in players {
            for (index, interest) in person.interests.enumerated() {
                if !interest {
                    if interestToPerson[index] == nil {
                        interestToPerson[index] = []
                    }
                    interestToPerson[index]?.append(person.id)
                }
            }
        }
    }
    
    func createAllResults() {
        for person in players {
            for secondPerson in players {
                if person.id != secondPerson.id {
                    if personToPerson[person.id] == nil {
                        personToPerson[person.id] = [Int : [Int]]()
                    }
                    var numberOfDiffereces = 0
                    var differencesArray = [Int]()
                    
                    for i in 0 ..< interests.count {
                        if person.interests[i] || secondPerson.interests[i] {
                            if person.interests[i] != secondPerson.interests[i] {
                                differencesArray.append(i)
                                numberOfDiffereces += 1
                            }
                        }
                    }
                    
                    if numberOfDiffereces > 0 {
                        if hitsToPerson[numberOfDiffereces] == nil {
                            hitsToPerson[numberOfDiffereces] = [:]
                        }
                        personToPerson[person.id]![secondPerson.id] = differencesArray
                        
                        if hitsToPerson[numberOfDiffereces]![secondPerson.id] != person.id {
                            hitsToPerson[numberOfDiffereces]![person.id] = secondPerson.id
                        }
                    }
                }
            }
        }
        // FIXME: CONSOLE PRINTING - REMOVE ME
        print("HitsToPerson: \(hitsToPerson)")
        print("************")
        print("PersonToPerson: \(personToPerson)")
        print("************")
    }
    
    func getPersonBased(on section: Int, and row: Int) -> (String, Int) {
        
        let personMatches = personToPerson[section]?.sorted(by: { (first, second) -> Bool in
            return first.value.count > second.value.count
        })
        
        let personIndex = personMatches![row].key
        
        let person = players[personIndex].name
        let count = personMatches![row].value.count
        
        return (person, count)
    }
    
    func getUnsharedInterests(on section: Int, and row: Int) -> [Int] {
        let matches = hitsToPerson.sorted
        { (first, second) -> Bool in
            return first.key > second.key
        }
        
        let matchesArray = matches[section].value.sorted
        { (first, second) -> Bool in
            return first.key > second.key
        }
        
        let match = matchesArray[row]
        
        let firstPersonId = match.key
        let secondPersonId = match.value
        
        let unsharedHits = personToPerson[firstPersonId]?.filter({ (arg0) -> Bool in
            let (key, _) = arg0
            return key == secondPersonId
        })
        
        return (unsharedHits?.first!.value)!
    }
    
    func getPersonsBased(on section: Int, and row: Int) -> (String, String) {
        
        let sorted = hitsToPerson.sorted { (first, second) -> Bool in
            return first.key > second.key
        }
        let hitsArray = sorted[section].value.sorted { (first, second) -> Bool in
            return first.key > second.key
        }
        let hit = hitsArray[row]
        
        let first = players![hit.key].name
        let second = players![hit.value].name
        
        return (first, second)
    }
}
