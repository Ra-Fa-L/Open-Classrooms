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
    
    // Array that holds relative pixel distances, that will be used to animate the hand
    var buttonCoordinates: [CGFloat] = []
    // After first circuit the skip button can be shown
    var firstCircuitDone: Bool = false
    
    var sharingDone: Bool = false
    
    // Will be instantiated when sharing is done
    var displayView: InterestDisplayView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortNameButtons()
        setUpNameButtons()
        
        interestSelectionView.viewModel = viewModel
        interestSelectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if sharingDone {
            // After clicking NewGame a chain of self.dismiss should fire including this one
            self.dismiss(animated: false, completion: nil)
        } else {
            DispatchQueue.main.async {
                self.view.setUIColors()
                self.startButton.setUpButton()
                self.shuffleButton.setUpButton()
            }
        }
    }
    
    // This view should cover the whole screen. For newGame self.dismiss chain
    override func viewDidDisappear(_ animated: Bool) {
        let coverView = UIView(frame: view.frame)
        coverView.setUIColors()
        self.view.addSubview(coverView)
    }
    
    // Just not to rely on the UIBuilder's order
    func sortNameButtons()
    {
        playerNameButtonCollection.sort
            { (first, second) -> Bool in
                return first.tag < second.tag
        }
    }

    // Hide all buttons not in use and assign names to others
    // Button.tag == player.id
    // Assign coordinates distances of all buttons to the buttonCoordinates
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
    }
    
    // Takes out all the used buttons from the StackView, reaarange them, and insert them back in new order
    // Because not used Buttons can be at the end, the inserting is not done to the end.
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
    
    // First appearance of interestSelectionView
    func startSharing() {
        interestSelectionView.initialSetUp()
    }
    
    func moveTheHand(id: Int) {
        let position = buttonCoordinates[viewModel.playerToButton[id]]
        
        UIView.animate(withDuration: 0.4) {
            self.activeHandImageView.frame.origin.y = position + 10
        }
    }
    
    // Move UI to the left and changeToNewUI on completion
    // Remove interestSelectionView and activeHand on completion
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
    
    // Change Background-, Button-Colors. Make PlayerButtons enabled again
    func changeToNewUI() {
        startButton.setTitle("CONTINUE", for: .normal)
        startButton.isEnabled = true
        
        stackViewLeadingConstraint.constant = 0
        stackViewTrailingConstraint.constant = 0
        
        buttonsStackView.spacing = 1.0
        
        UIView.animate(withDuration: 0.6) {
            
            self.startButton.setUpLightColoredButton()
            
            self.buttonsView.layoutIfNeeded()
        
            self.view.setDarkUIColors()
            self.buttonsView.setDarkUIColors()
            
            self.enableAllButtons()
            
            self.displayView?.showContainerView()
            
            self.nameButtonTapped(self.playerNameButtonCollection[self.viewModel.getActivePlayer()])
        }
    }
    
    func enableAllButtons() {
        for i in 0 ..< viewModel.playersCount {
            playerNameButtonCollection[i].activate()
        }
    }
    
    // Instantiate displayView
    func createDisplayView() {
        let x = UIScreen.main.bounds.width
        let y = containerStackView.frame.origin.y
        let width = interestSelectionView.frame.width
        let heigth = interestSelectionView.frame.height
        displayView = InterestDisplayView(frame: CGRect(x: x, y: y, width: width, height: heigth))
        
        displayView?.viewModel = viewModel
        
        view.addSubview(displayView!)
    }
    
    // If none of the player can choose interests fire the Animation to show DisplayView
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
            createDisplayView()
            moveTheUIToTheLeft()
        }
    }
    
    // playerButton will only function if sharing is done
    // The chosen player's interest will be reviewed
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

    // Start the game and after sharing is done continues to resultsVC
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if sharingDone {
            // PRINT:
            print("========================")
            print("PAIRING RESULTS!")
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
        }
    }
    
    @IBAction func shuffleButtonTapped(_ sender: UIButton) {
        shuffleButtons()
    }
    
}

// It makes running methods of this VC possible to the InterestSelectionView through the delegate
extension InterestsSharingViewController: InterestsSharingDelegate {
    func confirmChoice() {
        showNextPlayer()
    }
    
    // If a player doesn't have any more interests or has all fade his button out
    func fadeButton() {
        playerNameButtonCollection[viewModel.getActivePlayer()].alpha = 0.2
    }
}
