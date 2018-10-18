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
    @IBOutlet private var playerTextField: UITextField!
    @IBOutlet private var startGameButton: UIButton!
    @IBOutlet private var playersTableView: UITableView!
    @IBOutlet private var addPlayerButton: UIButton!
    
    // Players View Model
    private let playersVM: PlayersViewModel = PlayersViewModel()
    
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
            nextVC?.game = GameViewModel(with: playersVM.playerNames)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return playersVM.getPlayersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        cell.textLabel?.text = playersVM.playerNames[indexPath.row]
        
        // Every cell's colors needs to be changed individually, because it's on top of table background
        cell.backgroundColor = ColorTheme.backgroundColor
        cell.textLabel?.textColor = ColorTheme.mainTextColor
        return cell
    }
    
    // Delete cell and remove the name from playersVM
    // After that check startButton status
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            playersVM.removePlayer(at: indexPath.row)
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
    
    private func reloadTable()
    {
        playersTableView.reloadData()
    }
    
    private func clearInputField()
    {
        playerTextField.text = ""
        addingPlayer(allowed: false)
    }
    
    private func checkStartButton()
    {
        startingGame(allowed: playersVM.isGameAllowed())
    }
    
    // Enable or disenable startButton
    private func startingGame(allowed: Bool)
    {
        startGameButton.display(enabled: allowed)
    }
    
    // Enable or disenable addingButton
    private func addingPlayer(allowed: Bool)
    {
        addPlayerButton.display(enabled: allowed)
    }
    
    // Apply predefined colors for UI-Items
    private func applyUIColors()
    {
        navigationController?.navigationBar.barTintColor = ColorTheme.navigationColor
        navigationController?.navigationBar.tintColor = ColorTheme.mainTextColor
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor : ColorTheme.secondaryTextColor
        ]
        // Custom method added per Extensions
        startGameButton.setGreen()
        addPlayerButton.setGreen()
        
        view.backgroundColor = ColorTheme.backgroundColor
    }
    
    // Create a red border and red text color to indicate a duplicated name
    // After 0.8 second revert changes
    private func highlightTextFieldWithRed()
    {
        playerTextField.highlight(error: true)
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8)
        {
            self.playerTextField.highlight(error: false)
        }
    }
    
    @IBAction private func addPlayerTapped(_ sender: UIButton)
    {
        let name = playerTextField.text!
        
        if playersVM.addNewPlayer(with: name)
        {
            clearInputField()
            reloadTable()
        }
        else
        {
            highlightTextFieldWithRed()
        }
        
        // Check if the game can be started
        checkStartButton()
    }
    
    // Navigate to the next VC -> start Game
    @IBAction private func startGameTapped(_ sender: UIButton)
    {
        performSegue(withIdentifier: "startGameSegue", sender: nil)
    }
    
    // Fires on every pressed letter -> Event: Editing Changed
    @IBAction func textFieldChanged(_ sender: UITextField)
    {
        addingPlayer(allowed: playersVM.isAllowedAdding(player: sender.text!))
    }
}

