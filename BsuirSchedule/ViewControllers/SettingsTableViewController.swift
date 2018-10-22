//
//  SettingsTableViewController.swift
//  BsuirSchedule
//
//  Created by Kiryl Holubeu on 10/18/18.
//  Copyright © 2018 Kiryl Holubeu. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var subgroupControl: UISegmentedControl!
    @IBOutlet weak var subgroupCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    subgroupCell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
    //    subgroupCell.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if indexPath.section == 2 {
                if cell.accessoryType == .checkmark{
                    cell.accessoryType = .none
                }
                else{
                    cell.accessoryType = .checkmark
                }
                
                ScheduleMain.selectedWeeks[indexPath.row].toggle()

            }
        }
        
    }

}
