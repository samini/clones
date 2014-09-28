// Playground - noun: a place where people can play

import UIKit


var str = "Hello, playground"

var date = NSDate()
var interval = NSTimeInterval(1403921632)

var date2 = NSDate(timeIntervalSince1970: interval)




NSDate().compare(date2).toRaw()
date2.compare(NSDate()).toRaw()