//
//  Schedule.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/15/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

class ScheduleMain {
    
    static var lastUpdate: Date? = Date(timeIntervalSinceReferenceDate: 0)
    static var studSchedules: [StudSchedule] = []
    static var selectedGroup: String? = "751006"
    static var selectedSubgroup: Int? = 2
    static var dURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    static var selectedWeeks: [Bool] = [true, true, true, true]
    
    enum Keys: String {
        case schedules = "schedules.brakh"
        case selectedGroup = "selectedGroup.brakh"
        case selectedSubgroup = "selectedSubgroup.brakh"
        case lastUpdate = "lastUpdate.brakh"
    }
    
    static func saveData() {
        do {
            try saveSchedules()
            try saveSettings()
        } catch {
            print(errno)
        }
    }
    
    
    static func loadData() -> Bool {
        let dataURL: URL = dURL
        guard let codedGroup = try? Data(contentsOf: dataURL.appendingPathComponent("selected").appendingPathComponent(Keys.selectedGroup.rawValue)) else { return false }
        selectedGroup = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedGroup) as? String
        
        guard let codedSubgroup = try? Data(contentsOf: dataURL.appendingPathComponent("selected").appendingPathComponent(Keys.selectedSubgroup.rawValue)) else { return false }
        selectedSubgroup = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedSubgroup) as? Int
        
        guard let codedLastUpdate = try? Data(contentsOf: dataURL.appendingPathComponent("selected").appendingPathComponent(Keys.lastUpdate.rawValue)) else { return false }
        lastUpdate = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedLastUpdate) as? Date
        
        guard let codedData = try? Data(contentsOf: dataURL.appendingPathComponent(selectedGroup!).appendingPathComponent(Keys.schedules.rawValue)) else { return false }
        studSchedules = try! (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedData) as? [StudSchedule])! 
        return true
    }
    
    private static func saveSchedules() throws {
        let dataURL = dURL.appendingPathComponent(selectedGroup!)
        try? FileManager.default.createDirectory(at: dataURL, withIntermediateDirectories: true, attributes: nil)
        
        let codedData = try! NSKeyedArchiver.archivedData(withRootObject: studSchedules, requiringSecureCoding: true)
        try codedData.write(to: dataURL.appendingPathComponent(Keys.schedules.rawValue))
    }
    
    private static func saveSettings() throws {
        let dataURL = dURL.appendingPathComponent("selected")
        
        try? FileManager.default.createDirectory(at: dataURL, withIntermediateDirectories: true, attributes: nil)
        
        let codedGroup = try! NSKeyedArchiver.archivedData(withRootObject: selectedGroup!, requiringSecureCoding: true)
        try codedGroup.write(to: dataURL.appendingPathComponent(Keys.selectedGroup.rawValue))
        
        let codedSubGroup = try! NSKeyedArchiver.archivedData(withRootObject: selectedSubgroup!, requiringSecureCoding: true)
        try codedSubGroup.write(to: dataURL.appendingPathComponent(Keys.selectedSubgroup.rawValue))
        
        let codedLastUpdate = try! NSKeyedArchiver.archivedData(withRootObject: lastUpdate!, requiringSecureCoding: true)
        try codedLastUpdate.write(to: dataURL.appendingPathComponent(Keys.lastUpdate.rawValue))
    }
    
    private init() {}
    
}
