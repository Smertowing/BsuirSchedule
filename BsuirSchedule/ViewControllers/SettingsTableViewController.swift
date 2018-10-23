//
//  SettingsTableViewController.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/18/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var subgroupControl: UISegmentedControl!
    @IBOutlet weak var subgroupCell: UITableViewCell!
    @IBOutlet weak var groupPicker: UIPickerView!
    
    var groups: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupPicker.isHidden = true
    }
    
    @IBAction func didTapGroup(_ sender: UITapGestureRecognizer) {
        groupPicker.isHidden = false
        groups = Parser.getGroups()
        groups?.sort()
        groupPicker.delegate = self
        groupPicker.dataSource = self
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if indexPath.section == 2 {
                if cell.accessoryType == .checkmark{
                    cell.accessoryType = .none
                }
                else{
                    cell.accessoryType = .checkmark
                }
                
                ScheduleMain.selectedWeeks[indexPath.row].toggle()
            }
        }
    }
    
}

extension SettingsTableViewController: UIPickerViewDelegate {
    
}

extension SettingsTableViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return groups?[row]
    }
    
}
