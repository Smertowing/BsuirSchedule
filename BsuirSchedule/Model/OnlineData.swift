//
//  OnlineData.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 11/11/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

class OnlineData: NSObject, NSCoding, NSSecureCoding {
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    static var currentWeek: Int?
    static var availableGroups: [String]?
    
    static func downloadData() {
        self.availableGroups = Parser.getGroups()
        self.currentWeek = Parser.getCurrentWeek()
    }
    
    func encode(with aCoder: NSCoder) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
    }
    
}
