//
//  Schedule.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/14/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

class StudSchedule: NSObject, NSCoding, NSSecureCoding {
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    var title: String
    var subgroup: Int
    var schedule: [Weekday] = []
    
    init(title: String, schedule: [Weekday], subgroup: Int) {
        self.title = title
        self.schedule = schedule
        self.subgroup = subgroup
    }
    
    private enum Key: String {
        case title = "title"
        case subgroup = "subgroup"
        case schedule = "schedule"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: Key.title.rawValue)
        aCoder.encode(subgroup.hashValue, forKey: Key.subgroup.rawValue)
        aCoder.encode(schedule, forKey: Key.schedule.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: Key.title.rawValue) as! String
        let subgroup = aDecoder.decodeInteger(forKey: Key.subgroup.rawValue) 
        let schedule = aDecoder.decodeObject(forKey: Key.schedule.rawValue) as! [Weekday]
        self.init(title: title, schedule: schedule, subgroup: subgroup)
    }
    
}
