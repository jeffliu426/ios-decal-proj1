//
//  TaskCell.swift
//  To-Do-List
//
//  Created by Jeffrey Liu on 2/24/16.
//  Copyright © 2016 Jeffrey Liu. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    var taskCompleted: Bool!
    var timeCompleted: NSTimeInterval!

    
    var task: Task! {
        didSet {
            
            nameLabel.text = task.name
            taskCompleted = task.isCompleted
            timeCompleted = task.timeCompleted

        }
    }
    
}
