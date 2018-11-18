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

class SettingsTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var settingsTable: UITableView!
    @IBOutlet weak var subgroupControl: UISegmentedControl!
    @IBOutlet weak var subgroupCell: UITableViewCell!
    @IBOutlet weak var groupCell: UITextField!
    @IBOutlet weak var updateBarItem: UIBarButtonItem!
    @IBOutlet weak var cancekBarItem: UIBarButtonItem!
    
    var groups: [String]?
    weak var userSchedule: ScheduleMain!
    weak var delegate: SettingsTableViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        groupCell.delegate = self
        groupCell.text = userSchedule.selectedGroup ?? "Group"
        groups?.sort()
        subgroupControl.selectedSegmentIndex = userSchedule.selectedSubgroup ?? 0
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
                userSchedule.selectedGroup = sender.text
            }
        } else {
            userSchedule.selectedGroup = sender.text
        }
    }
    
    @IBAction func subgroupValueChanged(_ sender: UISegmentedControl) {
        userSchedule.selectedSubgroup = sender.selectedSegmentIndex
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
                                userSchedule.selectedWeeks[i] = true
                            } else {
                                tableView.cellForRow(at: indexPathTemp)?.accessoryType = .none
                                userSchedule.selectedWeeks[i] = false
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
                    userSchedule.selectedWeeks[indexPath.row].toggle()
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
