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
    @IBOutlet var titleLabel: UILabel!
    
    // [SectionId, RowId]
    var selectedCell: [Int]  = []
    var generated: Bool = false
    
    var resultModel: ResultsVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTableView.delegate = self
        customTableView.dataSource = self
        
        customTableView.tableFooterView = UIView(frame: .zero)
        
        refreshTables()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUI()
    }
    
    func setUI() {
        view.setDarkUIColors()
        customTableView.setUIColors()
        titleLabel.textColor = customColorTheme.lightGray
    }
    
    func giveNumberOfRows() -> Int {
        return resultModel.personToPerson.count
    }
    
    func giveHeaderText(for section: Int) -> String {
        return resultModel.players[section].name
    }
    
    func giveNumberOfRows(for section: Int) -> Int {
        return resultModel.personToPerson[section]!.count
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
    
    // CustomCell that higlights chosen interests
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCell(withIdentifier: "NameTableCell", for: indexPath) as? NamesTableViewCell
        let (person, count, unsharedInterests) = resultModel.getPersonBased(on: indexPath.section, and: indexPath.row)
        
        newCell?.playerLabel.text = person
        newCell?.interestCount.text = String(count)
        
        newCell?.highlighChosen(resultModel.interests, unsharedInterests)
        
        return newCell!
    }
    
    // If selected extend the height of the cell to show the interest stackView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if selectedCell.count == 2 {
            if selectedCell[0] == indexPath.section && selectedCell[1] == indexPath.row {
                return 100.0
            }
        }
        return  60.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selection = [indexPath.section, indexPath.row]
        
        if selectedCell == selection {
            selectedCell.removeAll()
        } else {
            selectedCell = selection
        }
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    func refreshTables() {
        customTableView.reloadData()
    }
    
    @IBAction func newGameTapped(_ sender: UIButton) {
        if generated {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
