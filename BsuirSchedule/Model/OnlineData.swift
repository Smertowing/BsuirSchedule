//
//  OnlineData.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 11/11/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

class OnlineData {
    
    static var currentWeek: Int?
    static var availableGroups: [String]?
    
    static func downloadData() {
        self.availableGroups = Parser.getGroups()
        self.currentWeek = Parser.getCurrentWeek()
    }
    
    private init() {}
    
}
