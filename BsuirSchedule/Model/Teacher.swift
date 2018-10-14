//
//  Teacher.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/14/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import UIKit

class Teacher: NSObject, NSCoding {
    
    var photo: UIImage = #imageLiteral(resourceName: "user")
    var id: Int
    var fullName: String
    
    init(id: Int, fullName: String, photo: UIImage = #imageLiteral(resourceName: "user")) {
        self.photo = photo
        self.id = id
        self.fullName = fullName
    }
    
    private struct Key {
        static let photo = "photo"
        static let id = "id"
        static let fullName = "fio"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(photo, forKey: Key.photo)
        aCoder.encode(id, forKey: Key.id)
        aCoder.encode(fullName, forKey: Key.fullName)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let photo = aDecoder.decodeObject(forKey: Key.photo) as! UIImage
        let id = aDecoder.decodeInteger(forKey: Key.id)
        let fio = aDecoder.decodeObject(forKey: Key.fullName) as! String
        self.init(id: id, fullName: fio, photo: photo)
    }
    
}
