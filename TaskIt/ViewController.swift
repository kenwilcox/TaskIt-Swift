//
//  ViewController.swift
//  TaskIt
//
//  Created by Kenneth Wilcox on 1/26/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
  var fetchedResultsController = NSFetchedResultsController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    fetchedResultsController = getFetchedResultsController()
    fetchedResultsController.delegate = self
    fetchedResultsController.performFetch(nil)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
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
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath!) as TaskModel
        
        detailVC.detailTaskModel = thisTask
      }
    } else if segue.identifier == "showTaskAdd" {
      if segue.destinationViewController is AddTaskViewController {
        let addTaskVC = segue.destinationViewController as AddTaskViewController
      }
    }
  }
  
  @IBAction func addButtonTapped(sender: UIBarButtonItem) {
    performSegueWithIdentifier("showTaskAdd", sender: self)
  }
  
  // Helper
  func taskFetchRequest () -> NSFetchRequest {
    let fetchRequest = NSFetchRequest(entityName: "TaskModel")
    let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
    let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
    fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
    
    return fetchRequest
  }
  
  func getFetchedResultsController() -> NSFetchedResultsController {
    fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
    return fetchedResultsController
  }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return fetchedResultsController.sections!.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fetchedResultsController.sections![section].numberOfObjects
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
    var cell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskTableViewCell
    
    cell.taskLabel.text = thisTask.task
    cell.descriptionLabel.text = thisTask.subtask
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
    
    var thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
    
    if indexPath.section == 0 {
      thisTask.completed = true
    } else {
      thisTask.completed = false
    }
    (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
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

// MARK: - NSFetchedResultsControllerDelegate
extension ViewController: NSFetchedResultsControllerDelegate {
  func controllerDidChangeContent(controller: NSFetchedResultsController) {
    tableView.reloadData()
  }
}

