//
//  ViewController.swift
//  TaskIt
//
//  Created by Kenneth Wilcox on 1/26/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var baseArray: [[TaskModel]] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let date1 = NSDate.from(year: 2015, month: 1, day: 30)
    let date2 = NSDate.from(year: 2015, month: 1, day: 27)
    let date3 = NSDate.from(year: 2015, month: 1, day: 31)
    
    let task1 = TaskModel(task: "Study Swift", subTask: "iOS Docs, github, etc.", date: date1, completed: false)
    let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date: date2, completed: false)
    
    let taskArray = [task1, task2, TaskModel(task: "Gym", subTask: "Leg day", date: date3, completed: false)]
    let completedArray = [TaskModel(task: "Code", subTask: "Task Project", date: date2, completed: true)]
    baseArray = [taskArray, completedArray]
    
    // Get rid of the bogus empty rows
    tableView.tableFooterView = UIView()
    //tableView.reloadData()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    
//    taskArray.sort {
//      $0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970
//    }
    baseArray[0] = sorted(baseArray[0], <)
    
    tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showTaskDetail" {
      if segue.destinationViewController is TaskDetailViewController {
        let detailVC = segue.destinationViewController as TaskDetailViewController
        let indexPath = self.tableView.indexPathForSelectedRow()
        let thisTask = baseArray[indexPath!.section][indexPath!.row]
        //let indexPath = sender as NSIndexPath
        //let thisTask = taskArray[indexPath.row]
        detailVC.detailTaskModel = thisTask
        detailVC.mainVC = self
      }
    } else if segue.identifier == "showTaskAdd" {
      if segue.destinationViewController is AddTaskViewController {
        let addTaskVC = segue.destinationViewController as AddTaskViewController
        addTaskVC.mainVC = self
      }
    }
  }
  
  @IBAction func addButtonTapped(sender: UIBarButtonItem) {
    performSegueWithIdentifier("showTaskAdd", sender: self)
  }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return baseArray.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return baseArray[section].count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let thisTask:TaskModel = baseArray[indexPath.section][indexPath.row]
    var cell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskTableViewCell
    
    cell.taskLabel.text = thisTask.task
    cell.descriptionLabel.text = thisTask.subTask
    //cell.dateLabel.text = Date.toString(date: thisTask.date)
    cell.dateLabel.text = thisTask.date.toString()

    return cell
  }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    println(indexPath.row)
    performSegueWithIdentifier("showTaskDetail", sender: self)
  }
}
