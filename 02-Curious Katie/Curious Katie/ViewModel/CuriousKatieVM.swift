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
    
    func addPerson(name: String, age: Int, city: String, nationality: String) {
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
        // FIXME: CONSOLE PRINTING - REMOVE ME
        print("playerToButton: \(playerToButton)")
        print("************")
    }
    
    func getPlayerWithId(id: Int) -> Int {
        return playersShuffled[id]
    }
    
    func getActivePlayer() -> Int
    {
        return getPlayerWithId(id: chosenPlayerId)
    }
    
    func chooseNextInterestPlayer() -> Int? {
        chosenPlayerId += 1
        
        var dontHaveAnyMoreInterest = true
        
        repeat {
            if chosenPlayerId == playersCount {
                chosenPlayerId = 0
            }
            if chosenPlayerId == 0 {
                if chosenAllInterest {
                    return nil
                }
            }
            if canPlayerChoose() {
                dontHaveAnyMoreInterest = false
            } else {
                chosenPlayerId += 1
            }
        } while (dontHaveAnyMoreInterest)
        return getActivePlayer()
    }
    
    func canPlayerChoose() -> Bool {
        return players[getActivePlayer()].stillChoosing
    }
    
    // InterstSelectionView:
    
    func getNeededPickerData() -> [Bool]
    {
        let player = players[getActivePlayer()]
        
        return player.interests
    }
    
    func getAllInterests() -> [String]
    {
        return interests.interests
    }
    
    func generateInterestExtras(id: Int) -> String {
        return interests.generateRandom(id: id)
    }
    
    func generateLevel() -> Int {
        return Int.random(in: 0 ..< 5)
    }
    
    func generateInterest() -> Int {
        let newInterests = players[getActivePlayer()].interests
        var notYestChosen: [Int] = []
        
        for i in 0 ..< newInterests.count {
            if !newInterests[i] {
                notYestChosen.append(i)
            }
        }
        return notYestChosen.randomElement()!
    }
    
    func addInterest(rowId: Int, extraText: String, level: Int) -> Int {
        players[getActivePlayer()].interests[rowId] = true
        players[getActivePlayer()].interestsExtras[rowId] = extraText
        players[getActivePlayer()].interestsLevels[rowId] = level
        players[getActivePlayer()].interestsInOrder.append(rowId)
        
        return players[getActivePlayer()].interestsInOrder.count
    }
    
    func noMoreInterest() {
        players[getActivePlayer()].stillChoosing = false
        
        checkIfAllDone()
    }
    
    func checkIfAllDone() {
        chosenAllInterest = true
        
        players.forEach { (player) in
            if player.stillChoosing {
                chosenAllInterest = false
                return
            }
        }
    }
    
    
    
    
    
    
    func getPlayerInterest(with player: Int) -> [Bool]
    {
        return players[player].interests
    }
    
    func createResultsVM() -> ResultsViewModel
    {
        return ResultsViewModel(players: players, interests: interests.interests)
    }
}
