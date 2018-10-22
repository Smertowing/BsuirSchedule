//
//  DateAndWeekJSON.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/22/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import Foundation

let lastUpdateHTTP = "https://journal.bsuir.by/api/v1/studentGroup/lastUpdateDate"
let currentWeekHTTP = "http://journal.bsuir.by/api/v1/week"

struct LastUpdate: Decodable {
    var lastUpdateDate: String?
}

