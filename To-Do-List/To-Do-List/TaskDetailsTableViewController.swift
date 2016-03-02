//
//  TaskDetailsTableViewController.swift
//  To-Do-List
//
//  Created by Jeffrey Liu on 2/19/16.
//  Copyright © 2016 Jeffrey Liu. All rights reserved.
//

import UIKit

class TaskDetailsTableViewController: UITableViewController {
    
    
    @IBOutlet var taskNameTextField: UITextField!
    
    
    @IBOutlet weak var detailLabel: UILabel!
    var task:Task?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            taskNameTextField.becomeFirstResponder()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveTaskDetail" {
            task = Task(name: taskNameTextField.text!, isCompleted: false, timeCompleted: NSDate().timeIntervalSince1970, isDeletedBefore24Hours: false, isDeletedAfter24Hours: false)
        }
    }

    // MARK: - Table view data source

}