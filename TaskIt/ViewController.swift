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
  
  var taskArray:[TaskModel] = []
  //var taskArray:[Dictionary<String,String>] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let task1 = TaskModel(task: "Study Swift", subTask: "iOS Docs, github, etc.", date: "01/30/2015")
    let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date: "01/30/2015")
    
    taskArray = [task1, task2, TaskModel(task: "Gym", subTask: "Leg day", date: "01/31/2015")]
    
    // Get rid of the bogus empty rows
    tableView.tableFooterView = UIView()
    tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showTaskDetail" {
      let detailVC = segue.destinationViewController as TaskDetailViewController
      let indexPath = self.tableView.indexPathForSelectedRow()
      let thisTask = taskArray[indexPath!.row]
      //let indexPath = sender as NSIndexPath
      //let thisTask = taskArray[indexPath.row]
      detailVC.detailTaskModel = thisTask
    }
  }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return taskArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let thisTask:TaskModel = taskArray[indexPath.row]
    var cell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskTableViewCell
    
    cell.taskLabel.text = thisTask.task
    cell.descriptionLabel.text = thisTask.subTask
    cell.dateLabel.text = thisTask.date

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
