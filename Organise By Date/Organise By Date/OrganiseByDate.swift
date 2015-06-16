//
//  OrganiseByDate.swift
//  Organise By Date
//
//  Created by etagarira on 10/06/2015.
//
//

import Automator
import TAGToolbox

class OrganiseByDate: AMBundleAction {
    
    override func runWithInput(input: AnyObject!, error: NSErrorPointer) -> AnyObject! {
        let inputFilePaths = Set<String>(input as! Array<String>)
        var outputFilePaths = Set<String>()
        
        let date = NSDate()
        
        let fileManager = NSFileManager.defaultManager()
        
        for sourcePath in inputFilePaths {
            if let organisedItem = fileManager.organiseItemAtPath(sourcePath, withDate: date) {
                outputFilePaths.insert(organisedItem)
            }
        }
        
        return outputFilePaths
    }
    
}
