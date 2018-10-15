//
//  PlayersViewModel.swift
//  Shamaz
//
//  Created by Rafal Padberg on 15.10.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import Foundation

class PlayersViewModel
{
    private(set) var playerNames: [String] = []
    
    func getPlayersCount() -> Int
    {
        return playerNames.count
    }
    
    func removePlayer(at index: Int)
    {
        playerNames.remove(at: index)
    }
    
    // Check if there are at least 2 players
    func isGameAllowed() -> Bool
    {
        return playerNames.count > 1 ? true : false
    }
    
    func addNewPlayer(with name: String) -> Bool
    {
        // Check if name has more than 1 letter
        if name.count > 1 && !checkForRepeating(name: name)
        {
            playerNames.append(name.lowercased())
            return true
        }
        return false
    }
    
    // If playerName is at least 3 letters long you can add it to the ViewModel
    func isAllowedAdding(player: String) -> Bool
    {
        return player.count > 2 ? true : false
    }
    
    // Don't allow user to input 2 names that are the same || john & joHn should not be allowed
    private func checkForRepeating(name: String) -> Bool
    {
        return playerNames.contains(name.lowercased())
    }
}
