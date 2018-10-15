//
//  Schedule.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/15/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

class ScheduleMain {
    
    static let lessonTimes = ["08:00 - 09:35",
                              "09:45 - 11:20",
                              "11:40 - 13:15",
                              "13:25 - 15:00",
                              "15:20 - 16:55",
                              "17:05 - 18:40",
                              "18:45 - 20:20",
                              "20:25 - 22:00"]
    
    static let weekDays = ["Понедельник",
                           "Вторник",
                           "Среда",
                           "Четверг",
                           "Пятница",
                           "Суббота",]
    
    static var studSchedules: [StudSchedule] = []
    static var selectedGroup = "751006"
    static var selectedSubgroup = Subgroup(rawValue: 2)!
    
    private init() {}
}
