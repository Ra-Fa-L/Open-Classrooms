//
//  ResultsViewModel.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import Foundation

class ResultsViewModel
{
    let participants: [Player]!
    let interests: [String]!
    
    var interestToPerson = [Int : [Int]]()
    var personToPerson = [Int : [Int : [Int]]]()
    var hitsToPerson = [Int : [Int : Int]]()
    
    init(participants: [Player], interests: [String])
    {
        self.participants = participants
        self.interests = interests
        
        self.createAllResults()
        self.createNextResults()
    }
    
    func createAllResults()
    {
        for person in participants
        {
            for (index, interest) in person.interests.enumerated()
            {
                if !interest
                {
                    if interestToPerson[index] == nil
                    {
                        interestToPerson[index] = []
                    }
                    
                    interestToPerson[index]?.append(person.id)
                }
            }
        }
    }
    
    func createNextResults() {
        for person in participants {
            for secondPerson in participants {
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
        print("MatchesToPerson: \(hitsToPerson)")
        print("**********")
        print("PersonToPerson: \(personToPerson)")
    }
    
    func getPersonBased(on section: Int, and row: Int) -> (String, Int) {
        
        let personMatches = personToPerson[section]?.sorted(by: { (first, second) -> Bool in
            return first.value.count > second.value.count
        })
        
        let personIndex = personMatches![row].key
        
        let person = participants[personIndex].name
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
//
//        let personMatches = personToPerson[match.key]?.sorted(by: { (first, second) -> Bool in
//            return first.value.count > second.value.count
//        })
//
//        let interests = personMatches![match.value].value
        return (unsharedHits?.first!.value)!
    }
    
    func getPersonsBased(on section: Int, and row: Int) -> (String, String) {
        
        let matches = hitsToPerson.sorted
        { (first, second) -> Bool in
            return first.key > second.key
        }
        
        let matchesArray = matches[section].value.sorted
        { (first, second) -> Bool in
            return first.key > second.key
        }
        
        let match = matchesArray[row]
        
        let first = participants![match.key].name
        let second = participants![match.value].name
        
        return (first, second)
    }
}
