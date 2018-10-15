//
//  Parser.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/15/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import UIKit

class Parser {
    
    func getGroups() -> [String]? {
        var groupNames: [String] = []
        let scheduleURL: URL = URL(string: "https://students.bsuir.by/api/v1/groups")!
        
        if let data = try? Data(contentsOf: scheduleURL){
            do {
                let groups = try JSONDecoder().decode([StudentGroup].self, from: data)
                for schedule in groups {
                    if let name = schedule.name {
                        groupNames.append(name)
                    }
                }
                return groupNames
            } catch (let err) {
                print("\(errno): \(err)")
                return nil
            }
        } else {
            return nil
        }
        
    }
    
    func getPhoto(path: String) -> UIImage? {
        let photoURL: URL = URL(string: path)!
        if let data = try? Data(contentsOf: photoURL){
            let photo = UIImage(data: data)
            return photo
        } else {
            return nil
        }
    }
    
    func getSchedule(forGroup numGroup: String, subgroup: StudSchedule.Subgroup) -> StudSchedule? {
        guard let scheduleURL: URL = URL(string: "https://students.bsuir.by/api/v1/studentGroup/schedule?studentGroup=\(numGroup)") else {
            return nil
        }
        if let data = try? Data(contentsOf: scheduleURL) {
            do {
                var tempShedules: [Weekday] = []
                let answer = try JSONDecoder().decode(Answer.self, from: data)
                guard let schedules = answer.schedules else { return nil }
                for schedule in schedules {
                    var tempSubjects: [Subject] = []
                    for subject in schedule.schedule! {
                        let title = subject.subject ?? ""
                        let auditory = subject.auditory?.first ?? ""
                        var time = subject.startLessonTime ?? ""
                        time += ""
                        time += subject.endLessonTime ?? ""
                        let weekNumber = subject.weekNumber!.filter { return $0 != 0 }
                        let subgroup = subject.numSubgroup ?? 0
                        var teachers: [Teacher] = []
                        for teacher in subject.employee! {
                            var fullName = teacher.lastName ?? ""
                            fullName += " "
                            fullName += teacher.firstName ?? ""
                            fullName += " "
                            fullName += teacher.middleName ?? ""
                            var photo = #imageLiteral(resourceName: "user")
                            photo = self.getPhoto(path: teacher.photoLink!) ?? #imageLiteral(resourceName: "user")
                            teachers.append(Teacher(id: teacher.id!, fullName: fullName, photo: photo))
                        }
                        let subjectType = subject.lessonType ?? "Неизвестно"
                        tempSubjects.append(Subject(title: title, auditory: auditory, time: time, teachers: teachers, weekNumber: weekNumber, subgroup: subgroup, subjectType: subjectType))
                    }
                    tempShedules.append(Weekday(title: schedule.weekDay!, subjects: tempSubjects))
                }
                return StudSchedule(title: numGroup, schedule: tempShedules, subgroup: subgroup)
            } catch {
                return nil
            }
        }
        return nil
    }
    
}
