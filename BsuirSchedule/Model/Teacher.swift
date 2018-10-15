//
//  Teacher.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/14/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import UIKit

class Teacher: NSObject, NSCoding, NSSecureCoding {
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    var photo: UIImage = #imageLiteral(resourceName: "user")
    var id: Int
    var fullName: String
    
    init(id: Int, fullName: String, photo: UIImage = #imageLiteral(resourceName: "user")) {
        self.photo = photo
        self.id = id
        self.fullName = fullName
    }
    
    private enum Key: String {
        case photo = "photo"
        case id = "id"
        case fullName = "fio"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(photo, forKey: Key.photo.rawValue)
        aCoder.encode(id, forKey: Key.id.rawValue)
        aCoder.encode(fullName, forKey: Key.fullName.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let photo = aDecoder.decodeObject(forKey: Key.photo.rawValue) as! UIImage
        let id = aDecoder.decodeInteger(forKey: Key.id.rawValue)
        let fio = aDecoder.decodeObject(forKey: Key.fullName.rawValue) as! String
        self.init(id: id, fullName: fio, photo: photo)
    }
    
}
