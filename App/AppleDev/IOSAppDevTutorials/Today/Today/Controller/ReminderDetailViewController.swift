//
//  ReminderDetailViewControllerTableViewController.swift
//  Today
//
//  Created by Deforeturn on 2/4/22.
//

import UIKit

class ReminderDetailViewController: UITableViewController {
    typealias ReminderChangeAction = (Reminder) -> Void
    private var reminderChangeAction: ReminderChangeAction?

    
    private var tempReminder: Reminder?
    private var reminder:Reminder?
    private var dataSource: UITableViewDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setEditing(false, animated: false)
        navigationItem.setRightBarButton(editButtonItem, animated: false)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReminderDetailEditDataSource.dateLabelCellIdentifier)
    }
    
    func configure(with reminder: Reminder, changeAction: @escaping ReminderChangeAction) {
        self.reminder = reminder
        self.reminderChangeAction = changeAction
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        guard let reminder = reminder else {
            fatalError("No reminder found for detail view")
        }
        if editing {
            dataSource = ReminderDetailEditDataSource(reminder: reminder) { reminder in
                self.tempReminder = reminder
                self.editButtonItem.isEnabled = true
            }
            navigationItem.title = NSLocalizedString("Edit Reminder", comment: "edit reminder nav title")
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTrigger))
        } else {
            if let tempReminder = tempReminder {
                self.reminder = tempReminder
                self.tempReminder = nil
                reminderChangeAction?(tempReminder)
                dataSource = ReminderDetailViewDataSource(reminder: tempReminder)
            } else{
                dataSource = ReminderDetailViewDataSource(reminder: reminder)
            }
            navigationItem.title = NSLocalizedString("View Reminder", comment: "view reminder nav title")
            navigationItem.leftBarButtonItem = nil
            editButtonItem.isEnabled = true
        }
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    @objc
    func cancelButtonTrigger() {
        setEditing(false, animated: true)
    }
}
extension ReminderDetailViewController{

}
