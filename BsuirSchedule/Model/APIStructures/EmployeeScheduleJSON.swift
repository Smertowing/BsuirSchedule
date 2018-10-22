//
//  EmployeeScheduleJSON.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/22/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

let employeeScheduleHTTP = "https://journal.bsuir.by/api/v1/portal/employeeSchedule"

struct EmployeeScheduleAnswer: Decodable {
    var employee: Employee?
    var studentGroup: StudentGroup?
    var schedules: [EmployeeSchedule]?
    var examSchedules: [EmployeeSchedule]?
    var todayDate: String?
    var todaySchedules: [EmployeeScheduleModel]?
    var tomorrowDate: String?
    var tomorrowSchedules: [EmployeeScheduleModel]?
    var currentWeekNumber: Int?
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

struct EmployeeSchedule: Decodable{
    var weekDay: String?
    var schedule: [EmployeeScheduleModel]?
}

struct EmployeeScheduleModel: Decodable {
    var weekNumber: [Int]?
    var studentGroup: [String]?
    var studentGroupInformation: [String]?
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
