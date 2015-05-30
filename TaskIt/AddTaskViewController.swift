//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Kenneth Wilcox on 1/29/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import CoreData

protocol AddTaskViewControllerDelegate {
  func addTask(message: String)
  func addTaskCanceled(message: String)
}

class AddTaskViewController: UIViewController {
  
  @IBOutlet weak var taskTextField: UITextField!
  @IBOutlet weak var subtaskTextField: UITextField!
  @IBOutlet weak var dueDatePicker: UIDatePicker!
  
  var delegate: AddTaskViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func cancelButtonTapped(sender: UIButton) {
    self.dismissViewControllerAnimated(true, completion: nil)
    delegate?.addTaskCanceled("Task was not added!")
  }
  
  @IBAction func addTaskButtonTapped(sender: UIButton) {
    let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    let managedObjectContext = ModelManager.instance.managedObjectContext
    let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
    let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
    
    let defaults = NSUserDefaults.standardUserDefaults()
    if defaults.boolForKey(kShouldCapitalizeTaskKey) == true {
      task.task = taskTextField.text.capitalizedString
    } else {
      task.task = taskTextField.text
    }
    task.subtask = subtaskTextField.text
    task.date = dueDatePicker.date
    task.completed = defaults.boolForKey(kShouldCompleteNewTodoKey)
    
    ModelManager.instance.saveContext()
    
    // Dump what has been saved
    var request = NSFetchRequest(entityName: "TaskModel")
    var error:NSError? = nil
    
    var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
    
    for res in results {
      println(res)
    }
    
    self.dismissViewControllerAnimated(true, completion: nil)
    delegate?.addTask("Task Added")
  }
}
