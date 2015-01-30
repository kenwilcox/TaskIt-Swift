//
//  TaskModel.swift
//  TaskIt
//
//  Created by Kenneth Wilcox on 1/27/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import Foundation

struct TaskModel {
  var task: String
  var subTask: String
  var date: NSDate
}

func >(left:TaskModel, right: TaskModel) -> Bool {
  return left.date.timeIntervalSince1970 > right.date.timeIntervalSince1970
}

func <(left:TaskModel, right: TaskModel) -> Bool {
  return left.date.timeIntervalSince1970 < right.date.timeIntervalSince1970
}