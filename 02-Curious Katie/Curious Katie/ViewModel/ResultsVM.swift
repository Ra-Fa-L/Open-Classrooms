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
    let interests: [Interest]!
    
    var personToPerson = [Int : [Int : [Int]]]()
    var hitsToPerson = [Int : [Int : [Int]]]()
    var hitsCount = [Int : Int]()
    
    init(players: [Player], interests: [Interest]) {
        self.players = players
        self.interests = interests
        
        self.createAllResults()
    }
    
    func createAllResults() {
        for person in players {
            
            print("\(person.name.uppercased())'s possible partners are:")
            print("**********************************************************")
            
            for secondPerson in players {
                if person.id != secondPerson.id {
                    if personToPerson[person.id] == nil {
                        personToPerson[person.id] = [Int : [Int]]()
                    }
                    var numberOfDiffereces = 0
                    
                    var differencesArray: [Int] = []
                    
                    for interest in interests {
                        let firstPlayerHas = person.interests.contains(interest)
                        let secondPlayerHas = secondPerson.interests.contains(interest)
                        
                        if (firstPlayerHas || secondPlayerHas) && (secondPlayerHas != firstPlayerHas) {
                            differencesArray.append(interest.id)
                            numberOfDiffereces += 1
                        }
                    }
                    
                    if numberOfDiffereces > 0 {
                        if hitsToPerson[numberOfDiffereces] == nil {
                            hitsToPerson[numberOfDiffereces] = [Int : [Int]]()
                            hitsCount[numberOfDiffereces] = 0
                        }
                        personToPerson[person.id]![secondPerson.id] = differencesArray
                        
                        let hitAlreadyExists = hitsToPerson[numberOfDiffereces]![secondPerson.id]
                        
                        if hitAlreadyExists == nil || !hitAlreadyExists!.contains(person.id) {
                            if hitsToPerson[numberOfDiffereces]![person.id] == nil {
                                hitsToPerson[numberOfDiffereces]![person.id] = []
                            }
                            hitsToPerson[numberOfDiffereces]![person.id]?.append(secondPerson.id)
                            hitsCount[numberOfDiffereces] = hitsCount[numberOfDiffereces]! + 1
                        }
                    }
                    
                    if numberOfDiffereces > 0 {
                        print("... \(secondPerson.name) based on \(numberOfDiffereces) different interests")
                        
                        for id in differencesArray {
                            print("...... \(interests[id].name)")
                        }
                    }
                }
            }
            
            print("**********************************************************")
        }
        // FIXME: CONSOLE PRINTING - REMOVE ME
//        print("HitsToPerson: \(hitsToPerson)")
//        print("************")
//        print("PersonToPerson: \(personToPerson)")
//        print("************")
//        print("HitsCount: \(hitsCount)")
//        print("************")
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
        let hits = hitsToPerson.sorted
        { (first, second) -> Bool in
            return first.key > second.key
        }
        
        let hitsArray = hits[section].value.sorted
        { (first, second) -> Bool in
            return first.key > second.key
        }
        var i = 0
        var secondPersonId = 0
        var firstPersonId = 0
        
        for hits in hitsArray {
            hits.value.forEach { (id) in
                if i == row {
                    firstPersonId = hits.key
                    secondPersonId = id
                } else {
                    i += 1
                }
            }
            
            if i == row {
                break
            }
        }
        
        let unsharedHits = personToPerson[firstPersonId]?.filter({ (arg0) -> Bool in
            let (key, _) = arg0
            return key == secondPersonId
        })
        
        return (unsharedHits?.first!.value)!
    }
    
    func getPersonPairBased(on section: Int, and row: Int) -> (String, String) {
        
        let sorted = hitsToPerson.sorted { (first, second) -> Bool in
            return first.key > second.key
        }
        let hitsArray = sorted[section].value.sorted { (first, second) -> Bool in
            return first.key > second.key
        }
        
        var i = 0
        var secondPersonId = 0
        var firstPersonId = 0
        
        for hits in hitsArray {
            hits.value.forEach { (id) in
                if i == row {
                    firstPersonId = hits.key
                    secondPersonId = id
                } else {
                    i += 1
                }
            }
            
            if i == row {
                break
            }
        }
        
        let first = players![firstPersonId].name
        let second = players![secondPersonId].name
        return (first, second)
    }
}
