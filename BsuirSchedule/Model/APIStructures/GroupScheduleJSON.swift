//
//  GroupScheduleJSON.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/14/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

let groupScheduleHTTP = "https://journal.bsuir.by/api/v1/studentGroup/schedule"

struct GroupScheduleAnswer: Decodable {
    var employee: Employee?
    var studentGroup: StudentGroup?
    var schedules: [GroupSchedule]?
    var examSchedules: [GroupSchedule]?
    var todayDate: String?
    var todaySchedules: [GroupScheduleModel]?
    var tomorrowDate: String?
    var tomorrowSchedules: [GroupScheduleModel]?
    var currentWeekNumber: Int?
}

struct StudentGroup: Decodable {
    var name: String?
    var facultyId: Int?
    var specialityDepartmentEducationFormId: Int?
    var course: Int?
    var id: Int?
    var calendarId: String?
}

struct GroupSchedule: Decodable{
    var weekDay: String?
    var schedule: [GroupScheduleModel]?
}

struct GroupScheduleModel: Decodable {
    var weekNumber: [Int]?
    var studentGroup: [String]?
    var numSubgroup: Int?
    var auditory: [String]?
    var lessonTime: String?
    var startLessonTime: String?
    var endLessonTime: String?
    var subject: String?
    var note: String?
    var lessonType: String?
    var employee: [Employee]?
    var zaoch: Bool?
}
