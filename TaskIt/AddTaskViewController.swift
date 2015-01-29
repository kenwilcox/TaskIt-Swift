//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Kenneth Wilcox on 1/29/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func cancelButtonTapped(sender: UIButton) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
}
