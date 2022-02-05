//
//  ViewController.swift
//  Today
//
//  Created by Deforeturn on 2/4/22.
//

import UIKit

class ReminderListViewController: UITableViewController {

    private var reminderListDataSource: ReminderListDataSource?
    static let showDetailSegueIdentifier = "ShowReminderDetailSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reminderListDataSource = ReminderListDataSource()
        tableView.dataSource = reminderListDataSource
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.showDetailSegueIdentifier,
            let destination = segue.destination as? ReminderDetailViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            let rowIndex = indexPath.row
            guard let reminder = reminderListDataSource?.reminder(at: rowIndex) else {
                fatalError("Couldn't find data source for reminder list.")
            }
            destination.configure(with: reminder) { reminder in
                self.reminderListDataSource?.update(reminder, at: rowIndex)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

extension ReminderListViewController {
    
}

