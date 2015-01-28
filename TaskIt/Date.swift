//
//  Date.swift
//  TaskIt
//
//  Created by Kenneth Wilcox on 1/27/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import Foundation

class Date {
  class func from(#year: Int, month: Int, day: Int) -> NSDate {
    
    var components = NSDateComponents()
    components.year = year
    components.month = month
    components.day = day
    
    var gregorianCalendar = NSCalendar(identifier: NSGregorianCalendar)
    var date = gregorianCalendar?.dateFromComponents(components)
    
    return date!
  }
}