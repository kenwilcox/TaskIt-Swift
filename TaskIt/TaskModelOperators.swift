//
//  TaskModelOperators.swift
//  TaskIt
//
//  Created by Kenneth Wilcox on 1/30/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import Foundation

func >(left:TaskModel, right: TaskModel) -> Bool {
  return left.date.timeIntervalSince1970 > right.date.timeIntervalSince1970
}

func <(left:TaskModel, right: TaskModel) -> Bool {
  return left.date.timeIntervalSince1970 < right.date.timeIntervalSince1970
}