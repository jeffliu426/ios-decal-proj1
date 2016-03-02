//
//  DailyStatsViewController.swift
//  To-Do-List
//
//  Created by Jeffrey Liu on 3/1/16.
//  Copyright © 2016 Jeffrey Liu. All rights reserved.
//

import UIKit

class DailyStatsViewController: UIViewController {

    @IBOutlet weak var circularLabel: UILabel!
    let deleted = true

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tasks = Task.getData()
        let deletedTasksBefore24Hours = Task.getDeletedDataBefore24Hours()
        var numberOfCompletedTasks = 0
        for task in tasks {
            if task.isCompleted! {
                numberOfCompletedTasks++
            }
        }
        // A deleted task counts as a completed task
        numberOfCompletedTasks += deletedTasksBefore24Hours.count
        
        circularLabel.text = "\(numberOfCompletedTasks)"
        circularLabel.layer.cornerRadius = 200
        circularLabel.clipsToBounds = true
        circularLabel.backgroundColor = UIColor.greenColor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
