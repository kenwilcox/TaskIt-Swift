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
  
  class func toString(#date: NSDate) -> String {
    return NSDateFormatter.localizedStringFromDate(date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.NoStyle)
  }
}

extension NSDate {
  func toString() -> String {
    return NSDateFormatter.localizedStringFromDate(self, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.NoStyle)
  }
}

extension NSDate {
  func toString(let format:String) -> String? {
    var formatter:NSDateFormatter = NSDateFormatter()
    formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    formatter.timeZone = NSTimeZone()
    formatter.dateFormat = format
    return formatter.stringFromDate(self)
  }
}