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
    func SubjectViewControllerDidUpdated(_ controller: SubjectViewController)
}


class SubjectViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    weak var subject: Subject?
    weak var delegate: SubjectViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = subject?.title
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.SubjectViewControllerDidCancel(self)
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        delegate?.SubjectViewControllerDidUpdated(self)
    }

}

