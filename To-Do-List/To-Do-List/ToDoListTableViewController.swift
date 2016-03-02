//
//  ToDoListTableViewController.swift
//  To-Do-List
//
//  Created by Jeffrey Liu on 2/19/16.
//  Copyright © 2016 Jeffrey Liu. All rights reserved.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    
    var tasks = Task.getData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self;
        self.tableView.dataSource = self;

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tasks = Task.getData()
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tasks = Task.getData()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath)
                as! TaskCell
            
            tasks = Task.getData()
            
            let task = tasks[indexPath.row] as Task
            cell.task = task
            
            // Checkmark logic
            if cell.task.isCompleted == false {
                cell.accessoryType = .None
            }
            else if cell.task.isCompleted == true {
                cell.accessoryType = .Checkmark
            }
            
            return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! TaskCell
        tasks = Task.getData()
        
        if cell.accessoryType == .Checkmark {
            cell.accessoryType = .None
            tasks[indexPath.row].isCompleted = false
            tasks[indexPath.row].isDeletedBefore24Hours = false
            tasks[indexPath.row].isDeletedAfter24Hours = false
            Task.saveData(tasks)
        }
        else {
            cell.accessoryType = .Checkmark
            tasks[indexPath.row].isCompleted = true
            tasks[indexPath.row].isDeletedBefore24Hours = false
            tasks[indexPath.row].isDeletedAfter24Hours = false
            tasks[indexPath.row].timeCompleted = NSDate().timeIntervalSince1970
            Task.saveData(tasks)
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        tasks = Task.getData()
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var deletedTask = tasks.removeAtIndex(indexPath.row)
            deletedTask.isDeletedBefore24Hours = true
            deletedTask.isCompleted = true
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            Task.saveData(tasks)
            Task.saveDeletedData([deletedTask])
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancelToPlayersViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveTaskDetail(segue:UIStoryboardSegue) {
        if let taskDetailsTableViewController = segue.sourceViewController as? TaskDetailsTableViewController {
            
            //add the new task to the tasks array
            tasks = Task.getData()
            if let task = taskDetailsTableViewController.task {
                tasks.append(task)
               
                Task.saveData(tasks)
                
                //update the tableView
                let indexPath = NSIndexPath(forRow: tasks.count-1, inSection: 0)
                tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
    


}
