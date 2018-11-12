//
//  CustomPickerView.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 09.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class CustomPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var selectedRow = 0
    
    var interests: [String] = []
    var neededData: [Bool] = []
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return interests.count
    }
    
    func reloadPickerView() {
        self.reloadAllComponents()
        
        let index = getIndexOfFirstNotYetChoosen()
        self.selectRow(index, inComponent: 0, animated: true)
    }
    
    func getIndexOfFirstNotYetChoosen() -> Int {
        return neededData.firstIndex(of: false)!
    }
    
    override func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
        super.selectRow(row, inComponent: component, animated: animated)
        selectedRow = row
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let newView = SingleInterestView()
        let interestName = interests[row]
        
        newView.nameLabel.text = interestName
        newView.imageView.image = UIImage(named: interestName.lowercased())
        
        if neededData[row] {
            newView.customView.backgroundColor = UIColor.clear
            newView.customView.alpha = 0.28
            newView.checkButton.alpha = 1
        }
        return newView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if neededData[row] {
            selectRow(getIndexOfFirstNotYetChoosen(), inComponent: 0, animated: true)
        } else {
            selectedRow = row
            
            let view = pickerView.view(forRow: row, forComponent: component) as? SingleInterestView
            view?.checkButton.imageView?.tintColor = UIColor.red
        }
    }
}
