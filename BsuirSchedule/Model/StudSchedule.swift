//
//  Schedule.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/14/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

class StudSchedule: NSObject, NSCoding {
    
    var title: String
    
    enum Subgroup: Int {
        case first
        case second
        case both
    }
    
    var subgroup: Subgroup
    var schedule = [Weekday]()
    
    init(title: String, schedule: [Weekday], subgroup: Subgroup) {
        self.title = title
        self.schedule = schedule
        self.subgroup = subgroup
    }
    
    private struct Key {
        static let title = "title"
        static let subgroup = "subgroup"
        static let schedule = "schedule"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: Key.title)
        aCoder.encode(subgroup.hashValue, forKey: Key.subgroup)
        aCoder.encode(schedule, forKey: Key.schedule)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: Key.title) as! String
        let subgroup = StudSchedule.Subgroup(rawValue: aDecoder.decodeInteger(forKey: Key.subgroup))!
        let schedule = aDecoder.decodeObject(forKey: Key.schedule) as! [Weekday]
        self.init(title: title, schedule: schedule, subgroup: subgroup)
    }
    
}
