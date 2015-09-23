//
//  OrganiseByDate.swift
//  Organise By Date
//
//  Created by Mannie Tagarira on 10/06/2015.
//  Copyright (c) 2015 Mannie Tagarira. All rights reserved.
//

import Automator
import TAGToolbox

class OrganiseByDate: AMBundleAction {
    
    override func runWithInput(input: AnyObject?) throws -> AnyObject {
        let inputFilePaths = Set<String>(input as! Array<String>)
        var outputFilePaths = Set<String>()
        
        let date = NSDate()
        
        let fileManager = NSFileManager.defaultManager()
        
        for sourcePath in inputFilePaths {
            if let organisedItem = fileManager.organiseItemAtPath(sourcePath, withDate: date) {
                outputFilePaths.insert(organisedItem)
            }
        }
        
        deliverUserNotification(Array<String>(outputFilePaths))

        return outputFilePaths
    }
    
}
