//
//  Subject.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/14/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

class Subject: NSObject, NSCoding {
    
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
    
    private struct Key {
        static let title = "title"
        static let auditory = "auditory"
        static let time = "time"
        static let teachers = "teachers"
        static let weekNumber = "weekNumber"
        static let subgroup = "subgroup"
        static let subjectType = "subjectType"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: Key.title)
        aCoder.encode(auditory, forKey: Key.auditory)
        aCoder.encode(time, forKey: Key.time)
        aCoder.encode(teachers, forKey: Key.teachers)
        aCoder.encode(weekNumber, forKey: Key.weekNumber)
        aCoder.encode(subgroup, forKey: Key.subgroup)
        aCoder.encode(subjectType, forKey: Key.subjectType)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: Key.title) as! String
        let auditory = aDecoder.decodeObject(forKey: Key.auditory) as! String
        let time = aDecoder.decodeObject(forKey: Key.time) as! String
        let teachers = aDecoder.decodeObject(forKey: Key.teachers) as! [Teacher]
        let weekNumber = aDecoder.decodeObject(forKey: Key.weekNumber) as! [Int]
        let subgroup = aDecoder.decodeInteger(forKey: Key.subgroup)
        let subjectType = aDecoder.decodeObject(forKey: Key.subjectType) as! String
        self.init(title: title, auditory: auditory, time: time, teachers: teachers, weekNumber: weekNumber, subgroup: subgroup, subjectType: subjectType)
    }
    
}
