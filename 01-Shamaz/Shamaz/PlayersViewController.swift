//
//  PlayersViewController.swift
//  Shamaz
//
//  Created by Rafal Padberg on 07.10.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

extension UIButton
{    
    func setGreenButtons() {
        self.setCustomCorners()
        self.setCustomColors()
    }
    
    func setOrangeButtons() {
        self.setCustomCorners2()
        self.setCustomColors2()
    }
    
    func setCustomColors() {
        self.backgroundColor = ColorTheme.navigationColor
        self.tintColor = ColorTheme.secondaryTextColor
    }
    
    func setCustomCorners() {
        self.layer.cornerRadius = self.frame.height / 3
    }
    
    func setCustomColors2() {
        self.backgroundColor = ColorTheme.buttonColor
        self.tintColor = ColorTheme.mainTextColor
    }
    
    func setCustomCorners2() {
        self.roundCorners(corners: [.bottomLeft, .bottomRight], radius: self.frame.height / 3)
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

class PlayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate
{
    @IBOutlet var playerTextField: UITextField!
    @IBOutlet var startGameButton: UIButton!
    @IBOutlet var playersTableView: UITableView!
    @IBOutlet var addPlayerButton: UIButton!
    
    var playerNames: [String] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Assign TableView's and TextField's delegates
        playersTableView.delegate = self
        playersTableView.dataSource = self
        playerTextField.delegate = self
        
        navigationController?.navigationBar.barTintColor = ColorTheme.navigationColor
        navigationController?.navigationBar.tintColor = ColorTheme.mainTextColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : ColorTheme.secondaryTextColor]
        
        startGameButton.setGreenButtons()
        addPlayerButton.setGreenButtons()
        
        view.backgroundColor = ColorTheme.backgroundColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
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
        
        cell.backgroundColor = ColorTheme.backgroundColor
        cell.textLabel?.textColor = ColorTheme.mainTextColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            playerNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            
            checkStartButton()
        }
    }
    
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
    
    func checkStartButton()
    {
        var gameAllowed = false
        if playerNames.count > 1 {
            gameAllowed = true
        }
        startingGame(allowed: gameAllowed)
    }
    
    func startingGame(allowed: Bool)
    {
        startGameButton.isEnabled = allowed
    }
    
    func checkForRepeating(name: String) -> Bool
    {
        let nameRepeated = playerNames.contains(name)
        return nameRepeated
    }
    
    @IBAction func addPlayerTapped(_ sender: UIButton)
    {
        if let name = playerTextField.text, name.count > 1, !checkForRepeating(name: name) {
            playerNames.append(name)
            clearInputField()
            reloadTable()
        }
        
        checkStartButton()
    }
    
    @IBAction func startGameTapped(_ sender: UIButton)
    {
        performSegue(withIdentifier: "startGameSegue", sender: nil)
    }
}

