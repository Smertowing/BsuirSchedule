//
//  Schedule.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/15/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

class ScheduleMain {
    
    var lastUpdate: Date? = Date(timeIntervalSinceReferenceDate: 0)
    var allGroupsAndWeek: GroupsAndWeek? = GroupsAndWeek.init(availableGroups: [])
    var studSchedules: [StudSchedule] = []
    var selectedGroup: String? = "751006"
    var selectedSubgroup: Int? = 0
    var dURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    var selectedWeeks: [Bool] = [true, true, true, true]
    
    enum Keys: String {
        case schedules = "schedules.brakh"
        case selectedGroup = "selectedGroup.brakh"
        case selectedSubgroup = "selectedSubgroup.brakh"
        case lastUpdate = "lastUpdate.brakh"
        case groups = "groups.brakh"
        case weeks = "weeks.brakh"
    }
    
    init() {
        if self.loadData() {
            if let tempLastUpate = Parser.getLastUpdate(forGroup: self.selectedGroup!) {
                if  tempLastUpate > self.lastUpdate! {
                    if let studSchedules = Parser.getSchedule(forGroup: selectedGroup!) {
                        self.studSchedules.append(studSchedules)
                        self.lastUpdate = tempLastUpate
                    }
                    self.allGroupsAndWeek?.availableGroups = Parser.getGroups() ?? []
                }
                
            }
        } else {
            if let studSchedules = Parser.getSchedule(forGroup: self.selectedGroup!) {
                self.studSchedules.append(studSchedules)
            }
            self.lastUpdate = Parser.getLastUpdate(forGroup: self.selectedGroup!)
            self.allGroupsAndWeek?.availableGroups = Parser.getGroups() ?? []
        }
    }
    
    func saveData() {
        do {
            try saveSchedules()
            try saveSettings()
            try saveGroups()
        } catch {
            print(errno)
        }
    }
    
    func loadData() -> Bool {
        let dataURL: URL = dURL
        guard let codedGroup = try? Data(contentsOf: dataURL.appendingPathComponent("selected").appendingPathComponent(Keys.selectedGroup.rawValue)) else { return false }
        selectedGroup = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedGroup) as? String
        
        guard let codedSubgroup = try? Data(contentsOf: dataURL.appendingPathComponent("selected").appendingPathComponent(Keys.selectedSubgroup.rawValue)) else { return false }
        selectedSubgroup = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedSubgroup) as? Int
        
        guard let codedLastUpdate = try? Data(contentsOf: dataURL.appendingPathComponent("selected").appendingPathComponent(Keys.lastUpdate.rawValue)) else { return false }
        lastUpdate = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedLastUpdate) as? Date
        
        guard let codedWeeks = try? Data(contentsOf: dataURL.appendingPathComponent("selected").appendingPathComponent(Keys.weeks.rawValue)) else { return false }
        selectedWeeks = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedWeeks) as! [Bool]
        
        guard let codedData = try? Data(contentsOf: dataURL.appendingPathComponent(selectedGroup!).appendingPathComponent(Keys.schedules.rawValue)) else { return false }
        studSchedules = try! (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedData) as? [StudSchedule])!
        
        guard let codedAllGroups = try? Data(contentsOf: dataURL.appendingPathComponent("allGroups").appendingPathComponent(Keys.groups.rawValue)) else { return false }
        allGroupsAndWeek = try! (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedAllGroups) as? GroupsAndWeek)!
        
        return true
    }
    
    private func saveSchedules() throws {
        let dataURL = dURL.appendingPathComponent(selectedGroup!)
        try? FileManager.default.createDirectory(at: dataURL, withIntermediateDirectories: true, attributes: nil)
        
        let codedData = try! NSKeyedArchiver.archivedData(withRootObject: studSchedules, requiringSecureCoding: true)
        try codedData.write(to: dataURL.appendingPathComponent(Keys.schedules.rawValue))
    }
    
    private func saveSettings() throws {
        let dataURL = dURL.appendingPathComponent("selected")
        
        try? FileManager.default.createDirectory(at: dataURL, withIntermediateDirectories: true, attributes: nil)
        
        let codedGroup = try! NSKeyedArchiver.archivedData(withRootObject: selectedGroup!, requiringSecureCoding: true)
        try codedGroup.write(to: dataURL.appendingPathComponent(Keys.selectedGroup.rawValue))
        
        let codedSubGroup = try! NSKeyedArchiver.archivedData(withRootObject: selectedSubgroup!, requiringSecureCoding: true)
        try codedSubGroup.write(to: dataURL.appendingPathComponent(Keys.selectedSubgroup.rawValue))
        
        let codedLastUpdate = try! NSKeyedArchiver.archivedData(withRootObject: lastUpdate!, requiringSecureCoding: true)
        try codedLastUpdate.write(to: dataURL.appendingPathComponent(Keys.lastUpdate.rawValue))
        
        let codedWeeks = try! NSKeyedArchiver.archivedData(withRootObject: selectedWeeks, requiringSecureCoding: true)
        try codedWeeks.write(to: dataURL.appendingPathComponent(Keys.weeks.rawValue))
    }
    
    private func saveGroups() throws {
        let dataURL = dURL.appendingPathComponent("allGroups")
        try? FileManager.default.createDirectory(at: dataURL, withIntermediateDirectories: true, attributes: nil)
        
        let codedAllGroups = try! NSKeyedArchiver.archivedData(withRootObject: allGroupsAndWeek!, requiringSecureCoding: true)
        try codedAllGroups.write(to: dataURL.appendingPathComponent(Keys.groups.rawValue))
    }
    
}
