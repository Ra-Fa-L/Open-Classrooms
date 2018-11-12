//
//  ResultsViewController.swift
//  Curious Katie
//
//  Created by Rafal Padberg on 08.11.18.
//  Copyright © 2018 Rafal Padberg. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var customTableView: UITableView!
    @IBOutlet var displaySegmenteControl: UISegmentedControl!
    
    var selectedCell: [Int]  = []
    var segment = 0
    
    var resultModel: ResultsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTableView.delegate = self
        customTableView.dataSource = self
        
        customTableView.tableFooterView = UIView(frame: .zero)
        
        refreshTables()
        
        setUI()
    }
    
    func setUI() {
        view.setSecondaryUIColors()
        customTableView.setUIColors()
    }
    
    func changeHeight(for segment: Int) {
        let height = segment == 1 ? 36.0 : 60.0
        
        customTableView.rowHeight = CGFloat(height)
    }
    
    func giveNumberOfRows() -> Int {
        return segment == 0 ? resultModel.personToPerson.count : resultModel.hitsToPerson.count
    }
    
    func giveHeaderText(for section: Int) -> String {
        if segment == 0 {
            return resultModel.players[section].name
        }
        let matches = resultModel.hitsToPerson.sorted { (first, second) -> Bool in
            return first.key > second.key
        }
        return "\(matches[section].key) Interests Matching between:"
    }
    
    func giveNumberOfRows(for section: Int) -> Int {
        if segment == 0 {
            return resultModel.personToPerson[section]!.count
        }
        let matches = resultModel.hitsToPerson.sorted { (first, second) -> Bool in
            return first.key > second.key
        }
        return matches[section].value.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return giveNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return giveHeaderText(for: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return giveNumberOfRows(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segment == 0 {
            let newCell = tableView.dequeueReusableCell(withIdentifier: "NameTableCell", for: indexPath) as? NamesTableViewCell
            let (person, count) = resultModel.getPersonBased(on: indexPath.section, and: indexPath.row)
            
            newCell?.playerLabel.text = person
            newCell?.interestCount.text = String(count)
            
            return newCell!
        }
        
        let newCell = tableView.dequeueReusableCell(withIdentifier: "HitTableCell", for: indexPath) as? SuitableHitsTableViewCell
        
        let (firstName, secondName) = resultModel.getPersonsBased(on: indexPath.section, and: indexPath.row)
        
        newCell?.firstNameLabel.text = firstName
        newCell?.secondNameLabel.text = secondName
        
        let unshared = resultModel.getUnsharedInterests(on: indexPath.section, and: indexPath.row)
        
        newCell?.makeVisible(resultModel.interests, unshared)
        
        return newCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segment == 1 {
            if selectedCell.count == 2 {
                if selectedCell[0] == indexPath.section && selectedCell[1] == indexPath.row {
                    return 80.0
                }
            }
            return  36.0
        }
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = [indexPath.section, indexPath.row]
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    func refreshTables() {
        changeHeight(for: segment)
        
        customTableView.allowsSelection = segment == 1
        customTableView.reloadData()
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        segment = sender.selectedSegmentIndex
        refreshTables()
    }
}
