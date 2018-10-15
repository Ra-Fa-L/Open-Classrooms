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
    
    // Array to hold inputNames
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
    
    // Instatiate a Game-Object with playerNames and assign it to a variable in the next ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "startGameSegue"
        {
            let nextVC = segue.destination as? GameViewController
            
            nextVC?.game = Game(with: playerNames)
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
        
        // Every cell's colors needs to be changed individually, because it's on top of table background
        cell.backgroundColor = ColorTheme.backgroundColor
        cell.textLabel?.textColor = ColorTheme.mainTextColor
        
        return cell
    }
    
    // Delete cell and remove the name from playersName-Array
    // After that check startButton status
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            playerNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
            
            checkStartButton()
        }
    }
    
    // Hide Keyboard on Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
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
    
    // Check if there are at least 2 players -> change startButtons status
    func checkStartButton()
    {
        let gameAllowed = playerNames.count > 1 ? true : false
        
        startingGame(allowed: gameAllowed)
    }
    
    // Enable or disenable startButton
    func startingGame(allowed: Bool)
    {
        startGameButton.isEnabled = allowed
        startGameButton.alpha = allowed ? 1.0 : 0.4
    }
    
    // Don't allow user to input 2 names that are the same || john & joHn should not be allowed
    func checkForRepeating(name: String) -> Bool
    {
        let nameRepeated = playerNames.contains(name.lowercased())
        return nameRepeated
    }
    
    // Apply predefined colors for UI-Items
    func applyUIColors()
    {
        navigationController?.navigationBar.barTintColor = ColorTheme.navigationColor
        navigationController?.navigationBar.tintColor = ColorTheme.mainTextColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : ColorTheme.secondaryTextColor]
        
        // Custom method added per Extensions
        startGameButton.setGreen()
        addPlayerButton.setGreen()
        
        view.backgroundColor = ColorTheme.backgroundColor
    }
    
    // Create a red border and red text color to indicate a duplicated name
    // After 0.8 second revert changes
    func highlightTextFieldWithRed()
    {
        playerTextField.highlight(error: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8)
        {
            self.playerTextField.highlight(error: false)
        }
    }
    
    @IBAction func addPlayerTapped(_ sender: UIButton)
    {
        let name = playerTextField.text!
        
        // Check if name has more than 1 letter
        if name.count > 1
        {
            // and if the input name is not repeated
            if  !checkForRepeating(name: name)
            {
                playerNames.append(name.lowercased())
                clearInputField()
                reloadTable()
            }
            else
            {
                highlightTextFieldWithRed()
            }
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

