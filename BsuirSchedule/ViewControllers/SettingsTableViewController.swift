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
    @IBOutlet weak var groupCell: UITextField!
    
    var groups: [String]?
    var week: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groups = OnlineData.availableGroups
        groups?.sort()
        week = OnlineData.currentWeek
    }
    
    @IBAction func groupDidEdited(_ sender: UITextField) {
        if groups != nil {
            if groups!.contains(sender.text ?? "0") {
                ScheduleMain.selectedGroup = sender.text
            }
        } else {
            ScheduleMain.selectedGroup = sender.text
        }
    }
    
    @IBAction func subgroupValueChanged(_ sender: UISegmentedControl) {
        ScheduleMain.selectedSubgroup = sender.selectedSegmentIndex
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        OnlineData.downloadData()
        groups = OnlineData.availableGroups
        groups?.sort()
        week = OnlineData.currentWeek
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if indexPath.section == 2 {
                if indexPath.row == 4 {
                    if cell.accessoryType == .checkmark {
                        cell.accessoryType = .none
                    } else {
                        for i in 0..<4 {
                            var indexPathTemp = indexPath
                            indexPathTemp.row = i
                            if i == week {
                                tableView.cellForRow(at: indexPathTemp)?.accessoryType = .checkmark
                                ScheduleMain.selectedWeeks[i] = true
                            } else {
                                tableView.cellForRow(at: indexPathTemp)?.accessoryType = .none
                                ScheduleMain.selectedWeeks[i] = false
                            }
                        }
                        cell.accessoryType = .checkmark
                    }
                } else {
                    if cell.accessoryType == .checkmark {
                        cell.accessoryType = .none
                    } else {
                        cell.accessoryType = .checkmark
                    }
                    ScheduleMain.selectedWeeks[indexPath.row].toggle()
                }
            }
        }
    }
    
}
