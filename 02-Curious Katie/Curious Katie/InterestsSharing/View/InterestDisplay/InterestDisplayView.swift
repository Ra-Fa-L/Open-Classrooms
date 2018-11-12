//
//  InterestDisplayView.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 10.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class InterestDisplayView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var customView: UIView!
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var customCollectionView: UICollectionView!
    
    var viewModel: CuriousKatieViewModel!
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    let inset: CGFloat = 16.0
    let interItem: CGFloat = 10.0
    let lineSpacing: CGFloat = 10.0
    
    var playerInterests: [Bool] = Array(repeating: false, count: 10)
    
    override func awakeFromNib() {
        print("DAWAJ!!!!!!!!!!!!!!!!!!!")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        width = self.frame.size.width
        height = self.frame.size.height
        
        print("***INITIALIZED***")
        initalize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func initalize() {
        Bundle.main.loadNibNamed("InterestDisplayView", owner: self, options: nil)
        addSubview(customView)
        
        containerView.alpha = 0.0
        customView.frame = self.bounds
        customView.backgroundColor = CustomColors4.thirdColor
    }
    
    func animate(moveBy: CGFloat) {
        self.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10.0)
        self.frame.origin.x = 0 + moveBy
    }
    
    func showView() {
        containerView.alpha = 1.0
    }

    
    
    
    func newPlayer()
    {
        customCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return viewModel.interests.interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let nibFile = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        collectionView.register(nibFile, forCellWithReuseIdentifier: "CustomCollectionCell")
        
        let viewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionCell", for: indexPath) as? CustomCollectionViewCell
        
        let alpha = CGFloat(playerInterests[indexPath.row] ? 0.5 : 0.1)
        
        viewCell?.backgroundColor = UIColor(red: 0.4, green: 0.1, blue: 0.2, alpha: alpha)
        viewCell?.layer.cornerRadius = 6.0
        viewCell?.customImageView.image = UIImage(named: viewModel.interests.interests[indexPath.row].lowercased())
        
        return viewCell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let minWidth = (width - (2 * inset) - interItem) / 2
        let minHeight = (height - (2 * inset) - (4 * lineSpacing)) / 5
        let squareSideLength = minWidth < minHeight ? minWidth : minHeight
        
        return CGSize(width: squareSideLength, height: squareSideLength)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return interItem
    }
}
