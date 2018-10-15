//
//  Subject.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/14/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

class Subject: NSObject, NSCoding, NSSecureCoding {
    
    static var supportsSecureCoding: Bool {
        return true
    }

    var title: String
    var auditory: String
    var time: String
    var timeIndex: Int
    var teachers: [Teacher]
    var weekNumber : [Int]
    var subgroup: Int
    var subjectType: String
    
    init(title: String, auditory: String, time: String, teachers: [Teacher], weekNumber: [Int], subgroup: Int, subjectType: String){
        self.title = title
        self.auditory = auditory
        self.time = time
        switch time {
        case "08:00 09:35": timeIndex = 0
        case "09:45 11:20": timeIndex = 1
        case "11:40 13:15": timeIndex = 2
        case "13:25 15:00": timeIndex = 3
        case "15:20 16:55": timeIndex = 4
        case "17:05 18:40": timeIndex = 5
        case "18:45 20:20": timeIndex = 6
        case "20:25 22:00": timeIndex = 7
        default: timeIndex = -1
        }
        self.teachers = teachers
        self.weekNumber = weekNumber
        self.subgroup = subgroup
        self.subjectType = subjectType
    }
    
    private enum Key: String {
        case title = "title"
        case auditory = "auditory"
        case time = "time"
        case teachers = "teachers"
        case weekNumber = "weekNumber"
        case subgroup = "subgroup"
        case subjectType = "subjectType"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: Key.title.rawValue)
        aCoder.encode(auditory, forKey: Key.auditory.rawValue)
        aCoder.encode(time, forKey: Key.time.rawValue)
        aCoder.encode(teachers, forKey: Key.teachers.rawValue)
        aCoder.encode(weekNumber, forKey: Key.weekNumber.rawValue)
        aCoder.encode(subgroup, forKey: Key.subgroup.rawValue)
        aCoder.encode(subjectType, forKey: Key.subjectType.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: Key.title.rawValue) as! String
        let auditory = aDecoder.decodeObject(forKey: Key.auditory.rawValue) as! String
        let time = aDecoder.decodeObject(forKey: Key.time.rawValue) as! String
        let teachers = aDecoder.decodeObject(forKey: Key.teachers.rawValue) as! [Teacher]
        let weekNumber = aDecoder.decodeObject(forKey: Key.weekNumber.rawValue) as! [Int]
        let subgroup = aDecoder.decodeInteger(forKey: Key.subgroup.rawValue)
        let subjectType = aDecoder.decodeObject(forKey: Key.subjectType.rawValue) as! String
        self.init(title: title, auditory: auditory, time: time, teachers: teachers, weekNumber: weekNumber, subgroup: subgroup, subjectType: subjectType)
    }
    
}
