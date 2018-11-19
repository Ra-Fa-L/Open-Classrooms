//
//  CuriousKatieVM.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import Foundation

class CuriousKatieVM {
    
    let generator: Generator = Generator()
    
    var playersCount: Int
    
    var interests: [Interest] = []
    
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
        self.initializeInterests()
        
        // PRINT:
        print("------------------------")
        print("Please introduce all \(self.playersCount) Players to the game!")
        print("------------------------")
    }
    
    func initializeInterests() {
        generator.interests.forEach { (interest) in
            interests.append(Interest(name: interest))
        }
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
        
        // PRINT:
        print("--> A New Player has been added: \(age) years old \"\(name)\" from \(city) of \(nationality) origin!")
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
        // PRINT:
        print("------------------------")
        print("The Players have been rearranged!")
        
        for (index, player) in playersShuffled.enumerated() {
            print("\(index + 1). \(players[player].name)")
        }
        
        // FIXME: CONSOLE PRINTING - REMOVE ME
//        print("playerToButton: \(playerToButton)")
//        print("************")
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
                    
                    // PRINT:
                    print("------------------------")
                    print("All Players have no more interests!")
                    print("------------------------")
                    
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
    
    func getNeededPickerData(playerId: Int? = nil) -> [Bool]
    {
        let player = players[playerId ?? getActivePlayer()]
        
        var interestsBoolArray: [Bool] = []
        
        interests.forEach { (interest) in
            let bool = player.interests.contains(interest)
            interestsBoolArray.append(bool)
        }
        
        return interestsBoolArray
    }
    
    func getAllInterests() -> [String]
    {
        var interestsArray: [String] = []
        interests.forEach { (interest) in
            interestsArray.append(interest.name)
        }
        return interestsArray
    }
    
    func generateInterestExtras(id: Int) -> String {
        return generator.getInterestExtra(id: id)
    }
    
    func generateLevel() -> Int {
        return Int.random(in: 0 ..< 5)
    }
    
    func generateInterest() -> Int {
        var notYestChosen: [Interest] = []
        
        for interest in interests {
            if !players[getActivePlayer()].interests.contains(interest) {
                notYestChosen.append(interest)
            }
        }
        return notYestChosen.randomElement()!.id
    }
    
    func addInterest(rowId: Int, extraText: String, level: Int) -> Int {
        players[getActivePlayer()].interests.append(interests[rowId])
        players[getActivePlayer()].interestExtras[rowId] = extraText
        players[getActivePlayer()].interestLevels[rowId] = level
        
        let extraString = extraText == "" ? "\"\"" : extraText
        
        // PRINT:
        print("\(players[getActivePlayer()].name) has chosen: \(interests[rowId].name) => \(extraString) => Intrest Level of \(level)")
        
        return players[getActivePlayer()].interests.count
    }
    
    func noMoreInterest() {
        players[getActivePlayer()].stillChoosing = false
        
        print("*** \(players[getActivePlayer()].name) has no more interests!")
        
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
    
    func createResultsVM() -> ResultsVM
    {
        return ResultsVM(players: players, interests: interests)
    }
    
    func simulate() {
        //Players
        for _ in 0 ..< playersCount {
            let player = generateAll()
            addPerson(name: player[0], age: Int(player[1])!, city: player[2], nationality: player[3])
        }
        
        shuffleParticipants()
        
        //Interests
        players.forEach { (player) in
            chosenPlayerId = player.id
            
            for _ in 0 ..< Int.random(in: 1 ..< interests.count) {
                let interestId = generateInterest()
                addInterest(rowId: interestId, extraText: generateInterestExtras(id: interestId), level: generateLevel())
            }
        }
        
        
        // PRINT:
        print("------------------------")
        print("All Players have no more interests!")
        print("========================")
        // PRINT:
        print("========================")
        print("HERE YOU CAN SEE THE PAIRING RESULTS!")
        print("========================")
        print("========================")
    }
}
