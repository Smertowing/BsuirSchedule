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
    var schedule: [Weekday] = []
    
    init(title: String, schedule: [Weekday]) {
        self.title = title
        self.schedule = schedule
    }
    
    private enum Key: String {
        case title = "title"
        case schedule = "schedule"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: Key.title.rawValue)
        aCoder.encode(schedule, forKey: Key.schedule.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: Key.title.rawValue) as! String
        let schedule = aDecoder.decodeObject(forKey: Key.schedule.rawValue) as! [Weekday]
        self.init(title: title, schedule: schedule)
    }
    
}
