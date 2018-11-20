//
//  SetUpViewController.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class SetUpViewController: UIViewController {
    
    @IBOutlet var demoSwitch: UISwitch!
    @IBOutlet var demoSlider: UISlider!
    @IBOutlet var demoPlayerCountLabel: UILabel!
    @IBOutlet var katieLabel: UILabel!
    @IBOutlet var demoLabel: UILabel!
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var simulateButton: UIButton!
    
    // If demo chosen there will only be 2-4 players depending on choice
    var demoChosen: Bool = false
    var playerCount: Int = 0 {
        willSet {
            demoPlayerCountLabel.text = "\(newValue) players"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPlayerCount()
        
        print("WELCOME to Curious Katie, please start a game!")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.setUI()
        }
    }
    
    // Make the UI look good (at least not bad :D)
    func setUI() {
        view.setUIColors()
        
        demoPlayerCountLabel.setColors()
        demoLabel.setColors()
        
        playButton.setUpButton()
        simulateButton.setUpButton()
        
        demoSwitch.onTintColor = customColorTheme.midGray
        katieLabel.textColor = customColorTheme.darkGray
    }
    
    func setPlayerCount() {
        playerCount = Int(demoSlider.value.rounded())
    }
    
    // If taped a user can set custom number of players from 2-4
    @IBAction func demoSwitchChanged(_ sender: UISwitch) {
        demoChosen = sender.isOn
        
        demoSlider.isHidden = !demoChosen
        demoPlayerCountLabel.isHidden = !demoChosen
    }
    
    @IBAction func demoSliderMoved(_ sender: UISlider) {
        setPlayerCount()
    }
    
    // Start a new game by creating a CuriousKatieViewModel and go to next VC
    @IBAction func playButtonTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let customPlayerCount = demoChosen ? playerCount : nil
        
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "IntroductionVC") as! IntroductionViewController
        nextVC.viewModel = CuriousKatieVM(with: customPlayerCount)
        nextVC.modalTransitionStyle = .crossDissolve
        
        present(nextVC, animated: true, completion: nil)
    }
    
    // Start a simulation by creating a ViewModel and running a simulate() method on it. Then show the results
    @IBAction func simulateButtonTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let customPlayerCount = demoChosen ? playerCount : nil
        
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "ResultsVC") as! ResultsViewController
        let viewModel = CuriousKatieVM(with: customPlayerCount)
        viewModel.simulate()
        nextVC.resultModel = viewModel.createResultsVM()
        nextVC.modalTransitionStyle = .crossDissolve
        
        present(nextVC, animated: true, completion: nil)
    }
}
