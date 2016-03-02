//
//  Task.swift
//  To-Do-List
//
//  Created by Jeffrey Liu on 2/19/16.
//  Copyright © 2016 Jeffrey Liu. All rights reserved.
//

import Foundation

import UIKit

struct Task {
    var name: String?
    var isCompleted: Bool?
    var timeCompleted: NSTimeInterval?
    var isDeletedBefore24Hours: Bool?
    var isDeletedAfter24Hours: Bool?
    static var timeLimit = 12.0
    
    init(name: String?, isCompleted: Bool?, timeCompleted: NSTimeInterval?, isDeletedBefore24Hours: Bool?, isDeletedAfter24Hours: Bool?) {
        self.name = name
        self.isCompleted = isCompleted
        self.timeCompleted = timeCompleted
        self.isDeletedBefore24Hours = isDeletedBefore24Hours
        self.isDeletedAfter24Hours = isDeletedAfter24Hours
    }
    
    static func saveData(tasks : [Task]) {
        let dicts = Task.tasksToDicts(tasks)
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(dicts, forKey: "tasks")
    }
    
    static func saveDeletedData(tasks : [Task]) {
        let dicts = Task.tasksToDicts(tasks)
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(dicts, forKey: "deleted")
    }
    
    
    static func getData() -> [Task] {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let tempDicts = defaults.objectForKey("tasks") as? [[String : AnyObject]] {
            
            var tempTasks = Task.dictsToTasks(tempDicts)
            let now = NSDate().timeIntervalSince1970
            var tasks = [Task]()
            for var i = 0; i < tempTasks.count; i++ {
                let task = tempTasks[i]
                let taskIsComplete = task.isCompleted!
                if taskIsComplete {
                    if let timeCompleted = task.timeCompleted where (now - timeCompleted < Task.timeLimit)
                    {
                        tasks.append(task)
                    }
                }
                else {
                    tasks.append(task)
                }
                
            }
            return tasks
        } else {
            return []
        }
    }
    
    static func getDeletedDataBefore24Hours() -> [Task] {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let tempDicts = defaults.objectForKey("deleted") as? [[String : AnyObject]] {
            var tempTasks = Task.dictsToTasks(tempDicts)
            let now = NSDate().timeIntervalSince1970
            var deletedTasks = [Task]()
            for var i = 0; i < tempTasks.count; i++ {
                var task = tempTasks[i]
                let taskIsComplete = task.isCompleted!
                if taskIsComplete {
                    if let timeCompleted = task.timeCompleted where (now - timeCompleted > Task.timeLimit) {
                        // Delete it.
                        task.isDeletedBefore24Hours = false
                        task.isDeletedAfter24Hours = true
                    }
                    else {
                        deletedTasks.append(task)
                    }
                }
            }
            return deletedTasks
        } else {
            return []
        }
    }
    
    
    
    
    static func tasksToDicts(tasks : [Task]) -> [[String : AnyObject]] {
        var array = [[String : AnyObject]]()
        for task in tasks {
            var dict = [String : AnyObject]()
            dict["name"] = task.name
            dict["isCompleted"] = task.isCompleted
            dict["timeCompleted"] = task.timeCompleted
            dict["isDeletedBefore24Hours"] = task.isDeletedBefore24Hours
            dict["isDeletedAfter24Hours"] = task.isDeletedAfter24Hours
            array.append(dict)
        }
        return array
    }
    
    static func dictsToTasks(arrayOfDicts : [[String : AnyObject]]) -> [Task] {
        var array = [Task]()
        for dict in arrayOfDicts {
            let name = dict["name"] as? String
            let isCompleted = dict["isCompleted"] as? Bool
            let timeCompleted = dict["timeCompleted"] as? NSTimeInterval
            let isDeletedBefore24Hours = dict["isDeletedBefore24Hours"] as? Bool
            let isDeletedAfter24Hours = dict["isDeletedAfter24Hours"] as? Bool
            var task = Task(name: name, isCompleted: isCompleted, timeCompleted: timeCompleted, isDeletedBefore24Hours: isDeletedBefore24Hours, isDeletedAfter24Hours: isDeletedAfter24Hours)
            array.append(task)
        }
        return array
    }
}


