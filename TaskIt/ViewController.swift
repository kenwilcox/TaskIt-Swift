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
  
  var taskArray:[[String:String]] = []
  //var taskArray:[Dictionary<String,String>] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let task1:Dictionary<String, String> = ["task": "Study Swift", "subtask": "iOS Docs, github, etc.", "date": "01/30/2015"]
    let task2:Dictionary<String, String> = ["task": "Eat Dinner", "subtask": "Burgers", "date": "01/30/2015"]
    let task3:Dictionary<String, String> = ["task": "Gym", "subtask": "Leg day", "date": "01/31/2015"]
    
    taskArray = [task1, task2, task3]
    // Get rid of the bogus empty rows
    tableView.tableFooterView = UIView()
    tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return taskArray.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let taskDict:Dictionary = taskArray[indexPath.row]
    var cell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskTableViewCell
    cell.taskLabel.text = taskDict["task"]
    cell.descriptionLabel.text = taskDict["subtask"]
    cell.dateLabel.text = taskDict["date"]
    return cell
  }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
  }
}
