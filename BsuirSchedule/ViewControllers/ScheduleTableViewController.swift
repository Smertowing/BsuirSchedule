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
            }
        } else {
            if let studSchedules = Parser.getSchedule(forGroup: ScheduleMain.selectedGroup!, subgroup: ScheduleMain.selectedSubgroup!) {
                ScheduleMain.studSchedules.append(studSchedules)
            }
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if ScheduleMain.selectedGroup != self.schedule?.title {
            var schedule = ScheduleMain.studSchedules.filter{$0.title == ScheduleMain.selectedGroup}
            if schedule.count == 0 {
                if let studSchedules = Parser.getSchedule(forGroup: ScheduleMain.selectedGroup!, subgroup: ScheduleMain.selectedSubgroup!) {
                    ScheduleMain.studSchedules.append(studSchedules)
                    schedule = ScheduleMain.studSchedules.filter{$0.title == ScheduleMain.selectedGroup}
                    if schedule.count > 0 { self.schedule = schedule[0] }
                    self.tableView.reloadData()
                    ScheduleMain.saveData()
                }
            }
            self.title = ScheduleMain.selectedGroup
        }
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

}
