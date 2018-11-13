//
//  GroupsAndWeek.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 11/11/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

class GroupsAndWeek: NSObject, NSCoding, NSSecureCoding {
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    var currentWeek: Int?
    /*
    var weekForDate: (Int,Double)? {
        didSet {
            currentWeek = (NSTimeIntervalSince1970 - weekForDate!.1)
        }
    }
    */
    var availableGroups: [String]?
    
    init(availableGroups: [String]) {
        self.availableGroups = availableGroups
    //    self.weekForDate = weekForDate
    }
    
    private enum Key: String {
        case availableGroups = "availableGroups"
    //    case weekForDate = "weekForDate"
    }
    
    func encode(with aCoder: NSCoder) {
    //    aCoder.encode(weekForDate,forKey: Key.weekForDate.rawValue)
        aCoder.encode(availableGroups,forKey: Key.availableGroups.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
    //    let weekForDate = aDecoder.decodeObject(forKey: Key.weekForDate.rawValue) as! (Int,Double)
        let availableGroups = aDecoder.decodeObject(forKey: Key.availableGroups.rawValue) as! [String]
        self.init(availableGroups: availableGroups)
    }
    
}
