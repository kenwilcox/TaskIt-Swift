//
//  TaskModel.swift
//  TaskIt
//
//  Created by Kenneth Wilcox on 1/30/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {
  
  @NSManaged var completed: NSNumber
  @NSManaged var date: NSDate
  @NSManaged var subtask: String
  @NSManaged var task: String
  
}
