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
    
    var demoChosen: Bool = false
    var playerCount: Int = 0 {
        willSet {
            demoPlayerCountLabel.text = "\(newValue) players"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPlayerCount()
        
        setUI()
    }
    
    // TODO: Refactor UIElements
    func setUI() {
        view.setUIColors()
        
        katieLabel.textColor = CustomColors4.secondColor
        demoSwitch.onTintColor = CustomColors4.thirdColor
        
        playButton.backgroundColor = CustomColors4.fifthColor
        simulateButton.backgroundColor = CustomColors4.fifthColor
        
        playButton.makeButton()
        simulateButton.makeButton()
        
        demoPlayerCountLabel.textColor = CustomColors4.sixthColor
        demoLabel.textColor = CustomColors4.sixthColor
    }
    
    func setPlayerCount() {
        playerCount = Int(demoSlider.value.rounded())
    }
    
    @IBAction func demoSwitchChanged(_ sender: UISwitch) {
        demoChosen = sender.isOn
        
        demoSlider.isHidden = !demoChosen
        demoPlayerCountLabel.isHidden = !demoChosen
    }
    
    @IBAction func demoSliderMoved(_ sender: UISlider) {
        setPlayerCount()
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let customPlayerCount = demoChosen ? playerCount : nil
        
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "IntroductionVC") as! IntroductionViewController
        nextVC.viewModel = CuriousKatieViewModel(with: customPlayerCount)
        nextVC.modalTransitionStyle = .crossDissolve
        
        present(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func simulateButtonTapped(_ sender: UIButton) {
        print("SORRY: Not yet implemented")
    }
    
}
