//
//  SettingsTableViewController.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/18/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol SettingsTableViewControllerDelegate: class {
    func SettingsTableViewControllerDidCancel(_ controller: SettingsTableViewController)
    func SettingsTableViewControllerDidUpdated(_ controller: SettingsTableViewController, newGroup: String, newSubgroup: Int, newWeeks: [Bool] )
}

class SettingsTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var settingsTable: UITableView!
    @IBOutlet weak var subgroupControl: UISegmentedControl!
    @IBOutlet weak var subgroupCell: UITableViewCell!
    @IBOutlet weak var groupCell: UITextField!
    @IBOutlet weak var updateBarItem: UIBarButtonItem!
    @IBOutlet weak var cancekBarItem: UIBarButtonItem!

    var group: String = ""
    var subgroup: Int = 0
    var weeks: [Bool] = []
    
    weak var userSchedule: ScheduleMain!
    weak var delegate: SettingsTableViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        groupCell.delegate = self
        groupCell.text = userSchedule.selectedGroup ?? "Group"
        subgroupControl.selectedSegmentIndex = userSchedule.selectedSubgroup ?? 0
        
        group = userSchedule.selectedGroup ?? "Enter group"
        subgroup = userSchedule.selectedSubgroup ?? 0
        weeks = userSchedule.selectedWeeks
        
        for i in 0..<4 {
            let indexPath = IndexPath(row: i, section: 2)
            if let cell = settingsTable.cellForRow(at: indexPath) {
                if weeks[i] { cell.accessoryType = .checkmark}
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.SettingsTableViewControllerDidCancel(self)
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        delegate?.SettingsTableViewControllerDidUpdated(self, newGroup: groupCell.text!, newSubgroup: subgroupControl.selectedSegmentIndex, newWeeks: weeks)
    }
    
    @IBAction func groupDidEdited(_ sender: UITextField) {
        
    }
    
    @IBAction func subgroupValueChanged(_ sender: UISegmentedControl) {
        subgroup = sender.selectedSegmentIndex
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
                            if i == userSchedule.allGroupsAndWeek?.currentWeek {
                                tableView.cellForRow(at: indexPathTemp)?.accessoryType = .checkmark
                                weeks[i] = true
                            } else {
                                tableView.cellForRow(at: indexPathTemp)?.accessoryType = .none
                                weeks[i] = false
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
                    weeks[indexPath.row].toggle()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if indexPath.row < 4 {
                if weeks[indexPath.row] {
                    cell.accessoryType = .checkmark
                }
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

extension SettingsTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if userSchedule.allGroupsAndWeek?.availableGroups != nil {
            if (userSchedule.allGroupsAndWeek?.availableGroups!.contains(textField.text!)) ?? false {
                group = textField.text!
                updateBarItem.isEnabled = true
            } else {
                updateBarItem.isEnabled = false
            }
        } else {
            updateBarItem.isEnabled = false
        }
        groupCell.resignFirstResponder()
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = groupCell.text,
            let stringRange = Range(range, in: oldText) else {
                return false
        }
        
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            updateBarItem.isEnabled = false
        } else {
            updateBarItem.isEnabled = true
        }
        return true
    }
    
    
    
}
