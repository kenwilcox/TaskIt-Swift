//
//  SettingsViewController.swift
//  TaskIt
//
//  Created by Kenneth Wilcox on 2/16/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
  
  @IBOutlet weak var capitalizeTableView: UITableView!
  @IBOutlet weak var completeNewTodoTableView: UITableView!
  @IBOutlet weak var versionLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.capitalizeTableView.delegate = self
    self.capitalizeTableView.dataSource = self
    self.capitalizeTableView.scrollEnabled = false
    
    self.completeNewTodoTableView.delegate = self
    self.completeNewTodoTableView.dataSource = self
    self.completeNewTodoTableView.scrollEnabled = false
    
    self.title = "Settings"
    
    let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String
    let build = NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as? String
    switch (version, build) {
    case let (.Some(version), .Some(build)):
      self.versionLabel.text = "\(version).\(build)"
    default:
      self.versionLabel.text = "??"
    }
    
    var doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: Selector("doneBarButtonItemPressed:"))
    self.navigationItem.leftBarButtonItem = doneButton
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func doneBarButtonItemPressed(barButtonItem: UIBarButtonItem) {
    self.navigationController?.popViewControllerAnimated(true)
  }
}

// MARK: UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 0
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    var cell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskTableViewCell
    return cell
  }
}

// MARK: UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
  
}