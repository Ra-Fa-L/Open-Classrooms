//
//  InterestsSharingViewController.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class InterestsSharingViewController: UIViewController {

    @IBOutlet var stackViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet var stackViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet var containerStackView: UIStackView!
    
    @IBOutlet var buttonsStackView: UIStackView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var shuffleButton: UIButton!
    
    @IBOutlet var buttonsView: UIView!
    
    @IBOutlet var interestSelectionView: InterestSelectionView!
    @IBOutlet var interestDisplayView: UIView!
    
    @IBOutlet var activeHandImageView: UIImageView!
    
    @IBOutlet var playerNameButtonCollection: [PlayerNameButton]!
    
    var viewModel: CuriousKatieVM!
    
    var buttonCoordinates: [CGFloat] = []
    var firstCircuitDone: Bool = false
    
    var sharingDone: Bool = false
    
    var displayView: InterestDisplayView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortNameButtons()
        setUpNameButtons()
        
        interestSelectionView.viewModel = viewModel
        interestSelectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.setUIColors()
        startButton.setUpButton()
        shuffleButton.setUpButton()
    }
    
    func sortNameButtons()
    {
        playerNameButtonCollection.sort
            { (first, second) -> Bool in
                return first.tag < second.tag
        }
    }

    func setUpNameButtons()
    {
        let playerNames = viewModel.getAllPlayerNames()
        let playerCount = playerNames.count

        playerNameButtonCollection.forEach { playerButton in
            if playerButton.tag >= playerNames.count {
                playerButton.alpha = 0
            }
        }
        
        for (index, button) in playerNameButtonCollection.enumerated() {
            if index >= playerCount {
                button.alpha = 0
                continue
            }
            let newName = " " + playerNames[index] + " "
            
            buttonCoordinates.append(button.frame.origin.y)
            button.setTitle(newName, for: .normal)
        }

        // FIXME: CONSOLE PRINTING - REMOVE ME
//        print("************")
//        for button in playerNameButtonCollection
//        {
//            print("\(button.tag) -\(button.title(for: .normal)!)")
//        }
//        print("************")
    }
    
    func shuffleButtons(initially: Bool = false) {
        if initially {
            startButton.isEnabled = true
            shuffleButton.isEnabled = true
        }
        viewModel.shuffleParticipants()
        
        let playerCount = viewModel.playersCount
        
        var array: [UIView?] = Array(repeating: nil, count: playerCount)
        
        for i in 0 ..< playerCount {
            let x = buttonsStackView.subviews[viewModel.playersShuffled[i]]
            array[i] = x
        }
        
        for i in 0 ..< playerCount {
            let newNum = (playerCount - i) - 1
            buttonsStackView.insertArrangedSubview(array[newNum]!, at: 0)
        }
        
        UIView.animate(withDuration: 0.6) {
            self.buttonsView.layoutIfNeeded()
        }
    }
    
    func startSharing() {
        interestSelectionView.initialSetUp()
    }
    
    func moveTheHand(id: Int) {
        let position = self.buttonCoordinates[self.viewModel.playerToButton[id]]
        
        UIView.animate(withDuration: 0.4) {
            self.activeHandImageView.frame.origin.y = position + 10
        }
    }
    
    func moveTheUIToTheLeft() {
        let lengthToMove = buttonsView.frame.origin.x
        let moveTo = buttonsView.frame.width
        
        UIView.animate(withDuration: 0.9, animations: {
                self.displayView?.animate(moveTo: moveTo)
                self.activeHandImageView.alpha = 0
                self.interestSelectionView.frame.origin.x -= lengthToMove
                self.buttonsView.frame.origin.x -= lengthToMove
        }) { [weak self] _ in
            
            self?.activeHandImageView.removeFromSuperview()
            self?.interestSelectionView.removeFromSuperview()
            self?.displayView?.removeFromSuperview()
            
            self?.containerStackView.addArrangedSubview((self?.displayView)!)
            
            self?.titleLabel.text = "Review Chosen Interests"
            self?.sharingDone = true
            
            self?.changeToNewUI()
        }
    }
    
    func changeToNewUI() {
        startButton.setTitle("CONTINUE", for: .normal)
        startButton.isEnabled = true
        
        stackViewLeadingConstraint.constant = 0
        stackViewTrailingConstraint.constant = 0
        
        buttonsStackView.spacing = 1.0
        
        UIView.animate(withDuration: 0.8) {
            
            self.startButton.setUpGenerateAllButton()
            
            self.buttonsView.layoutIfNeeded()
        
            self.view.setDarkUIColors()
            self.buttonsView.setDarkUIColors()
            
            self.enableAllButtons()
            
            self.displayView?.showContainerView()
        }
    }
    
    func enableAllButtons() {
        for i in 0 ..< viewModel.playersCount {
            playerNameButtonCollection[i].activate()
        }
    }
    
    func createDisplayView() {
        let x = UIScreen.main.bounds.width
        let y = containerStackView.frame.origin.y
        let width = interestSelectionView.frame.width
        let heigth = interestSelectionView.frame.height
        displayView = InterestDisplayView(frame: CGRect(x: x, y: y, width: width, height: heigth))
        
        displayView?.viewModel = viewModel
        
        view.addSubview(displayView!)
    }
    
    func showNextPlayer() {
        let nextPlayersId = viewModel.chooseNextInterestPlayer()
        
        if !firstCircuitDone && viewModel.chosenPlayerId == 0 {
            interestSelectionView.noMoreButton.isHidden = false
            firstCircuitDone = true
        }
        if nextPlayersId != nil {
            moveTheHand(id: nextPlayersId!)
            interestSelectionView.changePlayerAnimation()
        } else {
            
            print("You can now review the selected Interests")
            print("========================")
            
            createDisplayView()
            moveTheUIToTheLeft()
        }
    }
    
    @IBAction func nameButtonTapped(_ sender: UIButton) {
        if sharingDone {
            for i in 0 ..< viewModel.playersCount {
                (playerNameButtonCollection[i] as UIButton).activateButton(goBack: true)
            }
            
            displayView!.playerInterests = viewModel.getNeededPickerData(playerId: sender.tag)
            displayView!.showPlayersInterests()
            sender.activateButton(goBack: false)
        }
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        if sharingDone {
            // PRINT:
            print("========================")
            print("HERE YOU CAN SEE THE PAIRING RESULTS!")
            print("========================")
            print("========================")
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "ResultsVC") as? ResultsViewController
            
            nextVC?.resultModel = viewModel.createResultsVM()
            
            self.present(nextVC!, animated: true, completion: nil)
        } else {
            startButton.isEnabled = false
            
            descriptionLabel.hide()
            shuffleButton.hide()
            activeHandImageView.show()
            
            startSharing()
            
            // PRINT:
            print("------------------------")
            print("Now we can start choosing interests!")
            print("------------------------")
        }
    }
    
    @IBAction func shuffleButtonTapped(_ sender: UIButton) {
        shuffleButtons()
    }
    
}

extension InterestsSharingViewController: InterestsSharingDelegate {
    func confirmChoice() {
        showNextPlayer()
    }
    
    func fadeButton() {
        playerNameButtonCollection[viewModel.getActivePlayer()].alpha = 0.2
    }
}
