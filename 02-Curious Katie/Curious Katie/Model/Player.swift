//
//  Player.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import Foundation

struct Player {
    
    static var identifier: Int = 0
    
    // Reason for having the id is: CuriousKatieVM's chosenPlayerId
    var id: Int
    
    // An array of chosen intersts with corresponding description and level
    var interests: [Interest] = []
    // [InterestId : Description]
    var interestExtras: [Int : String] = [:]
    // [InterestId : Level]
    var interestLevels: [Int : Int] = [:]
    
    var name: String
    var age: Int
    var city: String
    var nationatlity: String
    
    // Logic for the ViewModel to know if player can choose more interests
    var stillChoosing: Bool = true
    
    init(name: String, age: Int, city: String, nationality: String) {
        self.id = Player.identifier
        Player.identifier += 1
        
        self.name = name
        self.age = age
        self.city = city
        self.nationatlity = nationality
    }
}
