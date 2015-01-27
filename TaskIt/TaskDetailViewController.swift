//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Kenneth Wilcox on 1/27/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
  
  var detailTaskModel: TaskModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    println(detailTaskModel.task)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
