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
    func SettingsTableViewControllerDidUpdated(_ controller: SettingsTableViewController)
}

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var subgroupControl: UISegmentedControl!
    @IBOutlet weak var subgroupCell: UITableViewCell!
    @IBOutlet weak var groupCell: UITextField!
    @IBOutlet weak var updateBarItem: UIBarButtonItem!
    @IBOutlet weak var cancekBarItem: UIBarButtonItem!
    
    var groups: [String]?
    var week: Int?
    weak var delegate: SettingsTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupCell.text = ScheduleMain.selectedGroup
        groups = OnlineData.availableGroups
        groups?.sort()
        week = OnlineData.currentWeek
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.SettingsTableViewControllerDidCancel(self)
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        let activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityView.center = self.view.center
        activityView.hidesWhenStopped = true
        self.view.addSubview(activityView)
        activityView.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        delegate?.SettingsTableViewControllerDidUpdated(self)
        UIApplication.shared.endIgnoringInteractionEvents()
        activityView.stopAnimating()
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

extension SettingsTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
