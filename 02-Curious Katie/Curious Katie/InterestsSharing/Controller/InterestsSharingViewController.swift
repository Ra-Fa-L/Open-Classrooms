//
//  InterestsSharingViewController.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class InterestsSharingViewController: UIViewController {

    @IBOutlet var containerStackView: UIStackView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var shuffleButton: UIButton!
    
    @IBOutlet var buttonsView: UIView!
    @IBOutlet var interestSelectionView: InterestSelectionView!
    @IBOutlet var interestDisplayView: UIView!
    
    @IBOutlet var activeHandImageView: UIImageView!
    
    @IBOutlet var playerNameButtonCollection: [PlayerNameButton]!
    
    
    
    var viewModel: CuriousKatieViewModel!
    
    var buttonCoordinates: [CGFloat] = []
    var firstCircuitDone: Bool = false
    
    var unsharedView: InterestDisplayView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sortNameButtons()
        setUpNameButtons()
        
        interestSelectionView.viewModel = viewModel
        interestSelectionView.delegate = self
        
        interestSelectionView.frame.size.width = UIScreen.main.bounds.width - buttonsView.frame.width
        
        // TODO: UI Colors
        view.setUIColors()
        
        startButton.backgroundColor = CustomColors4.fifthColor
        shuffleButton.backgroundColor = CustomColors4.fifthColor
        
        startButton.makeButton()
        shuffleButton.makeButton()
    }
    
    func sortNameButtons()
    {
        playerNameButtonCollection.sort
            { (first, second) -> Bool in
                return first.tag < second.tag
        }
        
        print(playerNameButtonCollection[11].tag)
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

        // FIXME: Remove
        print("************")
        for button in playerNameButtonCollection
        {
            print("\(button.title(for: .normal)!) - \(button.tag)")
        }
        print("************")
    }
    
    func shuffleButtons(initially: Bool = false) {
        if initially {
            startButton.isEnabled = true
            shuffleButton.isEnabled = true
        }
        
        viewModel.shuffleParticipants()
        
        for i in 0 ..< viewModel.playersCount
        {
            UIView.animate(withDuration: 0.6)
            {
                self.playerNameButtonCollection[i].frame.origin.y = self.buttonCoordinates[self.viewModel.playerToButton[i]]
            }
        }
    }
    
    func startSharing() {
        interestSelectionView.initalAnim()
    }
    
    func moveTheHand(id: Int)
    {
        let position = self.buttonCoordinates[self.viewModel.playerToButton[id]]
        
        UIView.animate(withDuration: 0.6)
        {
            self.activeHandImageView.frame.origin.y = position + 10
        }
    }
    
    func moveTheUIToTheLeft() {
        
        view.addSubview(unsharedView!)
        
        
//        interestDisplayView.isHidden = false
        
//        let width = interestSelectionView.frame.width
//        interestDisplayView.frame.size.width = width
        
        let newPosition = buttonsView.frame.origin.x
        
        UIView.animate(withDuration: 1.0, animations:
            {
                self.unsharedView?.animate(moveBy: 100.0)
                self.activeHandImageView.alpha = 0
                self.interestSelectionView.frame.origin.x -= newPosition
//                self.interestDisplayView.frame.origin.x -= newPosition
                self.buttonsView.frame.origin.x -= newPosition
        })
        { [weak self] _ in
            self?.activeHandImageView.removeFromSuperview()
            self?.interestSelectionView.removeFromSuperview()
            self?.unsharedView?.removeFromSuperview()
            
            self?.containerStackView.addArrangedSubview((self?.unsharedView)!)
            
//            self.thirdAnimation()
        }
    }
    
    func createDisplayView() {
        unsharedView = InterestDisplayView(frame: CGRect(x: UIScreen.main.bounds.width, y: containerStackView.frame.origin.y, width: interestSelectionView.frame.width, height: interestSelectionView.frame.height))
        
    }
    
    func showNextPlayer()
    {
        let nextPlayersId = viewModel.chooseNextInterestPlayer()
        
        if !firstCircuitDone && viewModel.chosenPlayerId == 0 {
            interestSelectionView.noMoreButton.isHidden = false
            firstCircuitDone = true
        }
        
        if nextPlayersId != nil {
            moveTheHand(id: nextPlayersId!)
            interestSelectionView.changePlayerAnimation(with: viewModel.players[nextPlayersId!])
        }
        else {
            createDisplayView()
            
            moveTheUIToTheLeft()
        }
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        startButton.isEnabled = false
        descriptionLabel.disappear()
        shuffleButton.disappear()
        
        activeHandImageView.reappear()
        
        startSharing()
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
