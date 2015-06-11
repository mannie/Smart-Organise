//
//  StringExtensions.swift
//  TAGToolbox
//
//  Created by etagarira on 10/06/2015.
//
//

import Foundation

public extension String {
    
    init(date: NSDate, format: String) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        self = dateFormatter.stringFromDate(date)
    }
    
}
