//
//  GroupScheduleJSON.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/14/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

struct Answer: Decodable {
    var employee: Employee?
    var studentGroup: StudentGroup?
    var schedules: [Schedule]?
    var examSchedules: [Schedule]?
    var todayDate: String?
    var todaySchedules: [ScheduleModel]?
    var tomorrowDate: String?
    var tomorrowSchedules: [ScheduleModel]?
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

struct Schedule: Decodable{
    var weekDay: String?
    var schedule: [ScheduleModel]?
}

struct ScheduleModel: Decodable {
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

struct Employee: Decodable {
    var firstName: String?
    var lastName: String?
    var middleName: String?
    var rank: String?
    var photoLink: String?
    var calendarId: String?
    var academicDepartment: [String]?
    var id: Int?
    var fio: String?
}

struct LastUpdate: Decodable {
    var lastUpdateDate: Date
}




