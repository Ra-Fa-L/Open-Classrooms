//
//  Interest.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import Foundation

class Interest: Equatable {
    
    static func == (lhs: Interest, rhs: Interest) -> Bool {
        return lhs.id == rhs.id
    }
    
    static var identifier: Int = 0
    
    var id: Int
    var name: String
    
    init(name: String) {
        self.id = Interest.identifier
        Interest.identifier += 1
        
        self.name = name
    }
}
