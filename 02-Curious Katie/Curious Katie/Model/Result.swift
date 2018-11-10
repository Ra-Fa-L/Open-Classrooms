//
//  Result.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import Foundation

struct Result
{
    let participants: [Player]!
    let interests: [String]!
    
    var interestToPerson = [Int : [Int]]()
    var personToPerson = [Int : [Int : [Int]]]()
    var matchesToPerson = [Int : [Int : Int]]()
    
    init(participants: [Player], interests: [String])
    {
        self.participants = participants
        self.interests = interests
        
        self.createAllResults()
        self.createNextResults()
    }
    
    mutating func createAllResults()
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
    
    mutating func createNextResults()
    {
        for person in participants
        {
            for secondPerson in participants
            {
                if person.id != secondPerson.id
                {
                    if personToPerson[person.id] == nil
                    {
                        personToPerson[person.id] = [Int : [Int]]()
                    }
                    
                    var numberOfDiffereces = 0
                    var differencesArray = [Int]()
                    
                    for i in 0 ..< interests.count
                    {
                        if person.interests[i] || secondPerson.interests[i]
                        {
                            if person.interests[i] != secondPerson.interests[i]
                            {
                                differencesArray.append(i)
                                numberOfDiffereces += 1
                            }
                        }
                    }
                    
                    if numberOfDiffereces > 0
                    {
                        if matchesToPerson[numberOfDiffereces] == nil
                        {
                            matchesToPerson[numberOfDiffereces] = [:]
                        }
                        
                        personToPerson[person.id]![secondPerson.id] = differencesArray
                        
                        if matchesToPerson[numberOfDiffereces]![secondPerson.id] != person.id
                        {
                            matchesToPerson[numberOfDiffereces]![person.id] = secondPerson.id
                        }
                    }
                }
            }
        }
        
        print("MatchesToPerson: \(matchesToPerson)")
        print("**********")
        print("PersonToPerson: \(personToPerson)")
    }
}
