//
//  ScheduleTableViewCell.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/15/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var lessonTime: UILabel!
    @IBOutlet weak var lessonType: UIImageView!
    @IBOutlet weak var auditory: UILabel!
    @IBOutlet weak var weekNumber: UILabel!
    @IBOutlet weak var subgroup: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    func update() {
        self.title.text = subject?.title
        self.auditory.text = subject?.auditory
        self.lessonTime.text = subject?.time
        if subject!.teachers.count > 0 {
            self.photo.image = subject?.teachers[0].photo
        } else {
            self.photo.isHidden = true
        }
        
        var weeks = ""
        for weekNumber in (subject?.weekNumber)! {
            weeks += String(weekNumber) + " "
        }
        self.weekNumber.text = weeks
        switch subject?.subjectType {
        case "ЛК": lessonType.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case "ПЗ": lessonType.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        case "ЛР": lessonType.backgroundColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
        default: lessonType.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
        if !(subject?.subgroup == 0) {
            if let subgroup = subject?.subgroup {
                self.subgroup.text = String(subgroup)
            }
        } else {
            self.subgroup.text = ""
        }
        
    }
    
    var subject: Subject? {
        didSet{
            self.update()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
