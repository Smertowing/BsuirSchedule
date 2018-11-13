//
//  ScheduleTableViewController.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/14/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController {

    var schedule: StudSchedule?
    
    func loadSettings() {
        if ScheduleMain.loadData() {
            if let tempLastUpate = Parser.getLastUpdate(forGroup: ScheduleMain.selectedGroup!) {
                if  tempLastUpate > ScheduleMain.lastUpdate! {
                    if let studSchedules = Parser.getSchedule(forGroup: ScheduleMain.selectedGroup!, subgroup: ScheduleMain.selectedSubgroup!) {
                        ScheduleMain.studSchedules.append(studSchedules)
                        ScheduleMain.lastUpdate = tempLastUpate
                    }
                }
                ScheduleMain.allGroupsAndWeek?.availableGroups = Parser.getGroups() ?? []
            }
        } else {
            if let studSchedules = Parser.getSchedule(forGroup: ScheduleMain.selectedGroup!, subgroup: ScheduleMain.selectedSubgroup!) {
                ScheduleMain.studSchedules.append(studSchedules)
            }
            ScheduleMain.allGroupsAndWeek?.availableGroups = Parser.getGroups() ?? []
        }
        
        var schedule = ScheduleMain.studSchedules.filter{$0.title == ScheduleMain.selectedGroup}
        if schedule.count > 0 { self.schedule = schedule[0] }
        self.tableView.reloadData()
        self.title = ScheduleMain.selectedGroup
        ScheduleMain.saveData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSettings()
        ScheduleMain.allGroupsAndWeek?.currentWeek = Parser.getCurrentWeek()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsTableViewController = segue.destination as? SettingsTableViewController {
            settingsTableViewController.delegate = self
        }
    }

}

extension ScheduleTableViewController: SettingsTableViewControllerDelegate {
    
    func SettingsTableViewControllerDidCancel(_ controller: SettingsTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func SettingsTableViewControllerDidUpdated(_ controller: SettingsTableViewController) {
        var schedule = ScheduleMain.studSchedules.filter{($0.title == ScheduleMain.selectedGroup) && ($0.subgroup == ScheduleMain.selectedSubgroup)}
        if schedule.count == 0 {
            if let studSchedules = Parser.getSchedule(forGroup: ScheduleMain.selectedGroup!, subgroup: ScheduleMain.selectedSubgroup!) {
                ScheduleMain.studSchedules.append(studSchedules)
                schedule = ScheduleMain.studSchedules.filter{($0.title == ScheduleMain.selectedGroup) && ($0.subgroup == ScheduleMain.selectedSubgroup)}
                if schedule.count > 0 { self.schedule = schedule[0] }
                ScheduleMain.saveData()
            }
        } else {
            if schedule.count > 0 { self.schedule = schedule[0] }
            ScheduleMain.saveData()
        }
        for schedule in self.schedule?.schedule ?? [] {
            schedule.subjects = schedule.subjects.filter{
                for i in $0.weekNumber {
                    if ScheduleMain.selectedWeeks[i-1] {
                        return true
                    }
                }
                return false
            }
        }
        self.tableView.reloadData()
        self.title = ScheduleMain.selectedGroup
        navigationController?.popViewController(animated: true)
    }
    
}
