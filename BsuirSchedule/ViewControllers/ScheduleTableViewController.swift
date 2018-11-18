//
//  ScheduleTableViewController.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/14/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController {

    var userSchedule: ScheduleMain!
    var schedule: StudSchedule?
    var selectedIndexPath: IndexPath?
    
    func loadSettings() {
        userSchedule = ScheduleMain()
        var schedule = userSchedule.studSchedules.filter{$0.title == userSchedule.selectedGroup}
        if schedule.count > 0 { self.schedule = schedule[0] }
        self.tableView.reloadData()
        self.title = userSchedule.selectedGroup
        userSchedule.saveData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSettings()
        userSchedule.allGroupsAndWeek?.currentWeek = Parser.getCurrentWeek()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return schedule?.schedule.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedule?.schedule[section].subjects.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return schedule?.schedule[section].title ?? ""
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell") as! ScheduleTableViewCell
        let subject = schedule?.schedule[indexPath.section].subjects[indexPath.row]
        cell.subject = subject
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let subjectViewController = storyboard.instantiateViewController(withIdentifier: "subjectVC") as! SubjectViewController
        selectedIndexPath = indexPath
        subjectViewController.subject = schedule?.schedule[selectedIndexPath!.section].subjects[selectedIndexPath!.row]
        subjectViewController.delegate = self
        self.show(subjectViewController, sender: self)
        tableView.cellForRow(at: indexPath)?.isSelected = false
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsTableViewController = segue.destination as? SettingsTableViewController {
            settingsTableViewController.delegate = self
            settingsTableViewController.userSchedule = userSchedule
        } 
    }

}

extension ScheduleTableViewController: SettingsTableViewControllerDelegate {
    
    func SettingsTableViewControllerDidCancel(_ controller: SettingsTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func SettingsTableViewControllerDidUpdated(_ controller: SettingsTableViewController) {
        
        var tempSchedule = ScheduleMain()
        var schedules = tempSchedule.studSchedules.filter{($0.title == tempSchedule.selectedGroup)}
        if schedules.count == 0 {
            if let studSchedules = Parser.getSchedule(forGroup: userSchedule.selectedGroup!) {
                userSchedule.studSchedules.append(studSchedules)
                userSchedule.saveData()
                tempSchedule = ScheduleMain()
                schedules = tempSchedule.studSchedules.filter{($0.title == tempSchedule.selectedGroup)}
                self.schedule = schedules[0]
            }
        } else {
            userSchedule.saveData()
            self.schedule = schedules[0]
        }
        
        for schedule in self.schedule?.schedule ?? [] {
            schedule.subjects = schedule.subjects.filter{
                if ($0.subgroup != 0) && ($0.subgroup != userSchedule.selectedSubgroup) {
                    if userSchedule.selectedSubgroup != 0 {
                        return false
                    }
                }
                for i in $0.weekNumber {
                    if userSchedule.selectedWeeks[i-1] {
                        return true
                    }
                }
                return false
            }
        }
        self.tableView.reloadData()
        self.title = userSchedule.selectedGroup
        navigationController?.popViewController(animated: true)
    }
    
}

extension ScheduleTableViewController: SubjectViewControllerDelegate {
    
    func SubjectViewControllerDidCancel(_ controller: SubjectViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func SubjectViewControllerDidUpdated(_ controller: SubjectViewController, updatedNotes: String) {
        navigationController?.popViewController(animated: true)
        schedule?.schedule[selectedIndexPath!.section].subjects[selectedIndexPath!.row].notes = updatedNotes
        selectedIndexPath = nil
    }
    
}
