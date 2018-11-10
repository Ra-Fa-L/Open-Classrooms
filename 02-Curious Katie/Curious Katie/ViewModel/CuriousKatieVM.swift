//
//  CuriousKatieVM.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import Foundation

class CuriousKatieViewModel {
    
    let generator: Generator = Generator()
    let interests: Interests = Interests()
    
    var playersCount: Int
    
    var players: [Player] = []
    // Button -> PlayerId
    var playersShuffled: [Int] = []
    // Player -> Button
    var playerToButton: [Int] = []
    
    let minNumberOfLetters: Int = 3
    let ageBoundary: [Int] = [16, 80]
    
    var chosenPlayerId: Int = 0
    var chosenAllInterest: Bool = false
    
    init(with customPlayersCount: Int?) {
        self.playersCount = customPlayersCount ?? Int.random(in: 2 ... 12)
    }
    
    // IntroductionVC:
    
    func generateName(male: Bool) -> String {
        var newName = generator.getName(male: male)
        
        while (!checkIfPossible(name: newName)) {
            newName = generator.getName(male: male)
        }
        
        return newName
    }
    
    func generateAge() -> String {
        return String(Int.random(in: ageBoundary[0] ... ageBoundary[1]))
    }
    
    func generateCity() -> String {
        return generator.getCity()
    }
    
    func generateNationality() -> String {
        return generator.getNationality()
    }
    
    func generateAll() -> [String] {
        let genName = generateName(male: (Int.random(in: 0 ... 1) == 0) ? false : true)
        let genAge = generateAge()
        let genCity = generateCity()
        let genNationality = generateNationality()
        
        return [genName, genAge, genCity, genNationality]
    }
    
    func checkIfPossible(name: String) -> Bool {
        let nameExists = players.contains { player -> Bool in
            player.name == name.capitalized
        }
        return !nameExists
    }
    
    func addPerson(name: String, age: Int, city: String, nationality: String)
    {
        players.append(Player(name: name, age: age, city: city, nationality: nationality))
    }
    
    func checkNextPersonNumber() -> Int? {
        if players.count < playersCount
        {
            return players.count + 1
        }
        return nil
    }
    
    // InterestsSharingVC:
    
    func getAllPlayerNames() -> [String] {
        var playerNames = [String]()
        
        for player in players {
            playerNames.append(player.name)
        }
        
        return playerNames
    }
    
    func shuffleParticipants() {
        playersShuffled.removeAll()
        playerToButton = Array(repeating: 0, count: self.playersCount)
        
        for (index, player) in players.shuffled().enumerated() {
            playersShuffled.append(player.id)
            playerToButton[player.id] = index
        }
        
        print("playerToButton: \(playerToButton)")
    }
    
    func getPlayerWithId(id: Int) -> Int
    {
        return playersShuffled[id]
    }
    
    func getActivePlayer() -> Int
    {
        return getPlayerWithId(id: chosenPlayerId)
    }
    
    func canPlayerChoose() -> Bool
    {
        return players[getPlayerWithId(id: chosenPlayerId)].stillChoosing
    }
    
    func chooseNextInterestPlayer() -> Int?
    {
        chosenPlayerId += 1
        
        var dontHaveAnyMoreInterest = true
        
        repeat
        {
            if chosenPlayerId == playersCount
            {
                chosenPlayerId = 0
            }
            
            if chosenPlayerId == 0
            {
                if chosenAllInterest
                {
                    return nil
                }
            }
            
            if canPlayerChoose()
            {
                dontHaveAnyMoreInterest = false
            }
            else
            {
                chosenPlayerId += 1
            }
        } while (dontHaveAnyMoreInterest)
        
        return getPlayerWithId(id: chosenPlayerId)
    }
    
    // InterstSelectionView:
    
    func getNeededData() -> [Bool]
    {
        let player = players[getPlayerWithId(id: chosenPlayerId)]
        
        return player.interests
    }
    
    func allInterests() -> [String]
    {
        return interests.interests
    }
    
    func addInterest(rowId: Int, extraText: String, level: Int) -> Int
    {
        players[getPlayerWithId(id: chosenPlayerId)].interests[rowId] = true
        players[getPlayerWithId(id: chosenPlayerId)].interestsExtras[rowId] = extraText
        players[getPlayerWithId(id: chosenPlayerId)].interestsLevels[rowId] = level
        
        players[getPlayerWithId(id: chosenPlayerId)].interestsInOrder.append(rowId)
        
        return players[getPlayerWithId(id: chosenPlayerId)].interestsInOrder.count
    }
    
    func noMoreInterest()
    {
        players[getPlayerWithId(id: chosenPlayerId)].stillChoosing = false
        
        checkIfAllDone()
    }
    
    func checkIfAllDone()
    {
        chosenAllInterest = true
        
        for person in players
        {
            if person.stillChoosing
            {
                chosenAllInterest = false
            }
        }
    }
    
    func generateInterestExtras(id: Int) -> String
    {
        return interests.generateRandom(id: id)
    }
    
    func generateLevel() -> Int
    {
        return Int.random(in: 0 ..< 5)
    }
    
    func generateInterest() -> Int
    {
        let newInterests = players[getActivePlayer()].interests
        var notYestChosen: [Int] = []
        
        for i in 0 ..< newInterests.count
        {
            if !newInterests[i]
            {
                notYestChosen.append(i)
            }
        }
        
        return notYestChosen.randomElement()!
    }
}
    
    // ----------------------------
    
    /*
    
    var resultModel: Result? = nil
    
 
    
    var firstCircuitDone: Bool = false
 
    
    func checkPersonNumber() -> Int
    {
        if participants.count < playersCount
        {
            return participants.count + 1
        }
        return 0
    }
    
 
    
    func getActivePlayer() -> Int
    {
        return getPlayerWithId(id: chosenPlayerId)
    }
    
    func chooseNextInterestPlayer() -> Int?
    {
        chosenPlayerId += 1
        
        var dontHaveAnyMoreInterest = true
        
        repeat
        {
            if chosenPlayerId == playersCount
            {
                chosenPlayerId = 0
            }
            
            if chosenPlayerId == 0
            {
                if chosenAllInterest
                {
                    return nil
                }
            }
            
            if canPlayerChoose()
            {
                dontHaveAnyMoreInterest = false
            }
            else
            {
                chosenPlayerId += 1
            }
        } while (dontHaveAnyMoreInterest)
        
        return getPlayerWithId(id: chosenPlayerId)
    }
 
 
 
 
 
 
 
    
    func getPlayerInterest(with player: Int) -> [Bool]
    {
        return participants[player].interests
    }
    
    func returnResults() -> Result
    {
        resultModel = Result(participants: participants, interests: interests.interests)
        
        return resultModel!
    }
}
 
 */
