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
  var mainVC: ViewController!
  
  @IBOutlet weak var taskTextField: UITextField!
  @IBOutlet weak var subTaskTextField: UITextField!
  @IBOutlet weak var dueDatePicker: UIDatePicker!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.taskTextField.text = detailTaskModel.task
    self.subTaskTextField.text = detailTaskModel.subTask
    self.dueDatePicker.date = detailTaskModel.date
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
    self.navigationController?.popViewControllerAnimated(true)
  }

}
