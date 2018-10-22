//
//  ListsJSON.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/22/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

let allGroupsHTTP = "https://journal.bsuir.by/api/v1/groups"
let allEmployeeHTTP = "https://journal.bsuir.by/api/v1/employees"
let allFacultiesHTTP = "https://journal.bsuir.by/api/v1/faculties"
let allDepartmentsHTTP = "https://journal.bsuir.by/api/v1/department"
let allAuditoriesHTTP = "https://journal.bsuir.by/api/v1/auditory"

struct AllGroupsAnswer: Decodable {
    var allGroups: [StudentGroup]?
}

struct AllEmployeeAnswer: Decodable {
    var allEmployee: [Employee]?
}

struct AllFacultiesAnswer: Decodable {
    var allEmployee: [Faculty]?
}

struct AllDepartmentsAnswer: Decodable {
    var allEmployee: [Department]?
}

struct AllAuditoriesAnswer: Decodable {
    var allEmployee: [Auditory]?
}

struct Faculty: Decodable {
    var name: String?
    var abbrev: String?
    var id: Int?
}

struct Department: Decodable {
    var idDepartment: Int?
    var abbrev: String?
    var name: String?
    var nameAndAbbrev: String?
}

struct Auditory: Decodable {
    var id: Int?
    var name: String?
    var note: String?
    var capacity: String?
    var auditoryType: [String]?
    var buildingNumber: [Int]?
    var department: [Department]?
}

