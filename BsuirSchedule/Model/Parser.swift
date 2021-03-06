//
//  Parser.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/15/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import UIKit

class Parser {

    static func getGroups() -> [String]? {
        var groupNames: [String] = []
        let scheduleURL: URL = URL(string: allGroupsHTTP)!
        
        if let data = try? Data(contentsOf: scheduleURL){
            do {
                let groups = try JSONDecoder().decode([StudentGroup].self, from: data)
                for schedule in groups {
                    if let name = schedule.name {
                        groupNames.append(name)
                    }
                }
                return groupNames
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func getLastUpdate(forGroup numGroup: String) -> Date? {
        let updateURL: URL = URL(string: lastUpdateHTTP+"?studentGroup=\(numGroup)")!
        
        if let data = try? Data(contentsOf: updateURL){
            do {
                let updateStr = try JSONDecoder().decode(LastUpdate.self, from: data)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                return dateFormatter.date(from: updateStr.lastUpdateDate!)
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func getPhoto(path: String) -> UIImage? {
        let photoURL: URL = URL(string: path)!
        if let data = try? Data(contentsOf: photoURL) {
            let photo = UIImage(data: data)
            return photo
        } else {
            return nil
        }
    }
    
    static func getCurrentWeek() -> Int? {
        let weekURL: URL = URL(string: currentWeekHTTP)!
        if var data = try? Data(contentsOf: weekURL){
            let weekNumber = Int(data.remove(at: 0) % 48) - 1
            return weekNumber
        } else {
            return nil
        }
    }
    
    static func getSchedule(forGroup numGroup: String) -> StudSchedule? {
        guard let scheduleURL: URL = URL(string: groupScheduleHTTP+"?studentGroup=\(numGroup)") else {
            return nil
        }
        if let data = try? Data(contentsOf: scheduleURL) {
            do {
                var tempShedules: [Weekday] = []
                let answer = try JSONDecoder().decode(GroupScheduleAnswer.self, from: data)
                guard let schedules = answer.schedules else { return nil }
                for schedule in schedules {
                    var tempSubjects: [Subject] = []
                    for subject in schedule.schedule! {
                        let title = subject.subject ?? ""
                        let auditory = subject.auditory?.first ?? ""
                        var time = subject.startLessonTime ?? ""
                        time += " "
                        time += subject.endLessonTime ?? ""
                        let weekNumber = subject.weekNumber!.filter { return $0 != 0 }
                        let tempsubgroup = subject.numSubgroup ?? 0
                        var teachers: [Teacher] = []
                        for teacher in subject.employee! {
                            var fullName = teacher.lastName ?? ""
                            fullName += " "
                            fullName += teacher.firstName ?? ""
                            fullName += " "
                            fullName += teacher.middleName ?? ""
                            var photo = #imageLiteral(resourceName: "user")
                            if let photoLink = teacher.photoLink {
                                photo = self.getPhoto(path: photoLink) ?? #imageLiteral(resourceName: "user")
                            }
                            teachers.append(Teacher(id: teacher.id!, fullName: fullName, photo: photo))
                        }
                        let subjectType = subject.lessonType ?? "Неизвестно"
                        tempSubjects.append(Subject(title: title, auditory: auditory, time: time, teachers: teachers, weekNumber: weekNumber, subgroup: tempsubgroup, subjectType: subjectType, notes: ""))
                    }
                    tempShedules.append(Weekday(title: schedule.weekDay!, subjects: tempSubjects))
                }
                return StudSchedule(title: numGroup, schedule: tempShedules)
            } catch {
                return nil
            }
        }
        return nil
    }
    
}
