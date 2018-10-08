//
//  PlayersViewController.swift
//  Shamaz
//
//  Created by Rafal Padberg on 07.10.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate
{
    @IBOutlet var playerTextField: UITextField!
    @IBOutlet var startGameButton: UIButton!
    @IBOutlet var playersTableView: UITableView!
    @IBOutlet var addPlayerButton: UIButton!
    
    // Array to hold input Names
    var playerNames: [String] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Assign TableView's and TextField's delegates
        playersTableView.delegate = self
        playersTableView.dataSource = self
        playerTextField.delegate = self
        
        applyUIColors()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Send player Names to the next ViewController and assign it to a variable
        if segue.identifier == "startGameSegue" {
            let nextVC = segue.destination as? GameViewController
            
            nextVC?.playerNames = playerNames
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return playerNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        cell.textLabel?.text = playerNames[indexPath.row]
        
        // Every cell's colors needs to changed individually
        cell.backgroundColor = ColorTheme.backgroundColor
        cell.textLabel?.textColor = ColorTheme.mainTextColor
        
        return cell
    }
    
    // Delete cell and remove the name from playersName-Array
    // After that check if starting a game is possible
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            playerNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            
            checkStartButton()
        }
    }
    
    // Hide Keyboard on Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func reloadTable()
    {
        playersTableView.reloadData()
    }
    
    func clearInputField()
    {
        playerTextField.text = ""
    }
    
    // Check if there are at least 2 players
    func checkStartButton()
    {
        var gameAllowed = false
        if playerNames.count > 1 {
            gameAllowed = true
        }
        startingGame(allowed: gameAllowed)
    }
    
    // Enable or disenable startButton
    func startingGame(allowed: Bool)
    {
        startGameButton.isEnabled = allowed
        startGameButton.alpha = allowed ? 1.0 : 0.4
    }
    
    // Don't allow user to input 2 same names
    func checkForRepeating(name: String) -> Bool
    {
        let nameRepeated = playerNames.contains(name)
        return nameRepeated
    }
    
    // Apply chosen Colors for UIItems
    func applyUIColors()
    {
        navigationController?.navigationBar.barTintColor = ColorTheme.navigationColor
        navigationController?.navigationBar.tintColor = ColorTheme.mainTextColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : ColorTheme.secondaryTextColor]
        
        // Custom method added per Extensions
        startGameButton.setGreenButtons()
        addPlayerButton.setGreenButtons()
        
        view.backgroundColor = ColorTheme.backgroundColor
    }
    
    @IBAction func addPlayerTapped(_ sender: UIButton)
    {
        let name = playerTextField.text!
        
        // Check if name has more than 1 letter and if is not repeated
        if name.count > 1, !checkForRepeating(name: name) {
            playerNames.append(name)
            clearInputField()
            reloadTable()
        }
        
        // Check if the game can be started
        checkStartButton()
    }
    
    // Navigate to the next VC -> start Game
    @IBAction func startGameTapped(_ sender: UIButton)
    {
        performSegue(withIdentifier: "startGameSegue", sender: nil)
    }
}

