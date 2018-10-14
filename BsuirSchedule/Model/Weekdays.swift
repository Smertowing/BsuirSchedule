//
//  Weekdays.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/14/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

class Weekday: NSObject, NSCoding {
    
    var title: String
    var titleIndex: Int
    var subjects: [Subject]
    
    init(title: String, subjects: [Subject]) {
        switch title {
        case "Понедельник": titleIndex = 0
        case "Вторник": titleIndex = 1
        case "Среда": titleIndex = 2
        case "Четверг": titleIndex = 3
        case "Пятница": titleIndex = 4
        case "Суббота": titleIndex = 5
        default: titleIndex = -1
        }
        self.title = title
        self.subjects = subjects
    }
    
    private struct Key {
        static let title = "title"
        static let subjects = "subjects"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: Key.title)
        aCoder.encode(subjects, forKey: Key.subjects)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: Key.title) as! String
        let subjects = aDecoder.decodeObject(forKey: Key.subjects) as! [Subject]
        self.init(title: title, subjects: subjects)
    }
    
}
