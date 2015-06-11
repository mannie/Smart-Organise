//
//  TAGOrganiseByDate.swift
//  TAGOrganiseByDate
//
//  Created by etagarira on 10/06/2015.
//
//

import Automator
import TAGToolbox

class TAGOrganiseByDate: AMBundleAction {

    override func runWithInput(input: AnyObject!, error: NSErrorPointer) -> AnyObject! {        
        let inputFilePaths = Set<String>(input as! Array<String>)
        var outputFilePaths = Set<String>()
        
        let dateString = String(date: NSDate(), format: "yyyy-MM-dd")
        
        let fileManager = NSFileManager.defaultManager()
        
        for sourcePath in inputFilePaths {
            if !fileManager.fileExistsAtPath(sourcePath) {
                continue
            }
            
            let parentDirectory = sourcePath.stringByDeletingLastPathComponent
            var destinationPath = parentDirectory.stringByAppendingPathComponent(dateString)

            fileManager.createDirectoryAtPath(destinationPath, withIntermediateDirectories: true, attributes: nil, error: nil)
            
            destinationPath = destinationPath.stringByAppendingPathComponent(sourcePath.lastPathComponent)
            destinationPath = fileManager.collisionSafePath(destinationPath)
            
            if fileManager.moveItemAtPath(sourcePath, toPath: destinationPath, error: nil) {
                outputFilePaths.insert(destinationPath)
            }
        }
        
        return outputFilePaths
    }
    
}
