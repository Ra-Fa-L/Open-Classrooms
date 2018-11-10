//
//  Player.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import Foundation

struct Player
{
    var id: Int
    
    var name: String
    var interests: [Bool] = Array(repeating: false, count: 10)
    var interestsExtras: [String] = Array(repeating: "", count: 10)
    var interestsLevels: [Int] = Array(repeating: 0, count: 10)
    var interestsInOrder: [Int] = []
    var age: Int
    var city: String
    var nationatlity: String
    var stillChoosing: Bool = true
    
    static var identifier: Int = 0
    
    init(name: String, age: Int, city: String, nationality: String)
    {
        self.id = Player.identifier
        Player.identifier += 1
        
        self.name = name
        self.age = age
        self.city = city
        self.nationatlity = nationality
    }
}
