//
//  SubjectViewController.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 11/17/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import UIKit

protocol SubjectViewControllerDelegate: class {
    func SubjectViewControllerDidCancel(_ controller: SubjectViewController)
    func SubjectViewControllerDidUpdated(_ controller: SubjectViewController, updatedNotes: String)
}


class SubjectViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var lessonTime: UILabel!
    @IBOutlet weak var lessonType: UIImageView!
    @IBOutlet weak var auditory: UILabel!
    @IBOutlet weak var weekNumber: UILabel!
    @IBOutlet weak var subgroup: UILabel!
    @IBOutlet weak var subgroupLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var notesField: UITextView!
    
    weak var subject: Subject?
    weak var delegate: SubjectViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        notesField.delegate = self
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        let firstPart = subject?.title ?? "?"
        let secondPart = subject?.subjectType ?? "?"
        let titleString = firstPart + " (" + secondPart + ")"
        self.navigationItem.title = titleString
        if subject!.teachers.count > 0 {
            self.nameLabel.text = subject?.teachers[0].fullName
            self.photo.image = subject?.teachers[0].photo
        }
        
        self.auditory.text = subject?.auditory
        if self.auditory.text == "" {
            self.auditory.text = "?"
        }
        self.lessonTime.text = subject?.time
        
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
            self.subgroupLabel.isHidden = false
        } else {
            self.subgroup.text = ""
            self.subgroupLabel.isHidden = true
        }
        notesField.text = subject?.notes
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.SubjectViewControllerDidCancel(self)
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        delegate?.SubjectViewControllerDidUpdated(self, updatedNotes: notesField.text)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

extension SubjectViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textview: UITextView) {
        moveViewField(textview: textview, moveDistance: -250, up: true)
    }
    
    func textViewDidEndEditing(_ textview: UITextView) {
        moveViewField(textview: textview, moveDistance: -250, up: false)
    }
    
    func moveViewField(textview: UITextView, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance: -moveDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
}
