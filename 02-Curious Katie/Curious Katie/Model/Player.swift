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
    
    var id: Int
    
    var interests: [Interest] = []
    var interestExtras: [Int : String] = [:]
    var interestLevels: [Int : Int] = [:]
    
    var name: String
    var age: Int
    var city: String
    var nationatlity: String
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
