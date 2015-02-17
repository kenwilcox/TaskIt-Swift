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
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
    
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
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 30
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if tableView == self.capitalizeTableView {
      return "Capitalize new Task?"
    }
    else {
      return "Complete new Task?"
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let defaults = NSUserDefaults.standardUserDefaults()
    if tableView == self.capitalizeTableView {
      var capitalizeCell = tableView.dequeueReusableCellWithIdentifier("capitalizeCell") as UITableViewCell
      if indexPath.row == 0 {
        capitalizeCell.textLabel?.text = "No, do not capitalize"
        if defaults.boolForKey(kShouldCapitalizeTaskKey) == false {
          capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
          capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
        }
      } else {
        capitalizeCell.textLabel?.text = "Yes, Capitalize!"
        if defaults.boolForKey(kShouldCapitalizeTaskKey) == true {
          capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
          capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
        }
      }
      return capitalizeCell
    } else {
      var completeNewTodoCell = tableView.dequeueReusableCellWithIdentifier("completeNewTodoCell") as UITableViewCell
      if indexPath.row == 0 {
        completeNewTodoCell.textLabel?.text = "Do not complete Task"
        if defaults.boolForKey(kShouldCompleteNewTodoKey) == false {
          completeNewTodoCell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else {
          completeNewTodoCell.accessoryType = UITableViewCellAccessoryType.None
        }
      }
      else {
        completeNewTodoCell.textLabel?.text = "Complete Task"
        if defaults.boolForKey(kShouldCompleteNewTodoKey) == true{
          completeNewTodoCell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else {
          completeNewTodoCell.accessoryType = UITableViewCellAccessoryType.None
        }
      }
      return completeNewTodoCell
    }
  }
}

// MARK: UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let defaults = NSUserDefaults.standardUserDefaults()
    if tableView == self.capitalizeTableView {
      if indexPath.row == 0 {
        defaults.setBool(false, forKey: kShouldCapitalizeTaskKey)
      } else {
        defaults.setBool(true, forKey: kShouldCapitalizeTaskKey)
      }
    } else {
      if indexPath.row == 0 {
        defaults.setBool(false, forKey: kShouldCompleteNewTodoKey)
      } else {
        defaults.setBool(true, forKey: kShouldCompleteNewTodoKey)
      }
    }
    defaults.synchronize()
    tableView.reloadData()
  }
}