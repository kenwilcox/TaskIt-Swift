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
  
  func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
    return 25
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return "To do"
    } else {
      return "Completed"
    }
  }
  
  func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
    var thisTask = self.baseArray[indexPath.section][indexPath.row]
    
    if indexPath.section == 0 {
      thisTask.completed = true
      self.baseArray[1].append(thisTask)
    } else {
      thisTask.completed = false
      self.baseArray[0].append(thisTask)
    }
    self.baseArray[indexPath.section].removeAtIndex(indexPath.row)
    
    baseArray[0] = sorted(baseArray[0], <)
    tableView.reloadData()
  }
  
  func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
    var title: String
    var color: UIColor
    if indexPath.section == 0 {
      title = "Done"
      color = UIColor.greenColor()
    } else {
      title = "Not Done"
      color = UIColor.blackColor()
    }
    
    var deleteButton = UITableViewRowAction(style: .Default, title: title, handler: { (action, indexPath) in
      self.tableView.dataSource?.tableView?(
        self.tableView,
        commitEditingStyle: .Delete,
        forRowAtIndexPath: indexPath
      )
      
      return
    })
    
    deleteButton.backgroundColor = color
    
    return [deleteButton]
  }
}
