//
//  SmartOrganiseFolders.swift
//  SmartOrganiseFolders
//
//  Created by Mannie Tagarira on 10/06/2015.
//  Copyright (c) 2015 Mannie Tagarira. All rights reserved.
//

import Automator
import TAGToolbox

class SmartOrganiseFolders: AMBundleAction {
    
    override func runWithInput(input: AnyObject!, error: NSErrorPointer) -> AnyObject! {
        let inputFilePaths = Set<String>(input as! Array<String>)
        var outputFilePaths = Set<String>()
        
        let fileManager = NSFileManager.defaultManager()
        
        for path in inputFilePaths {
            var isDirectory = ObjCBool(false)
            if !fileManager.fileExistsAtPath(path, isDirectory: &isDirectory) || !isDirectory {
                continue
            }
            
            let fileExts = fileManager.contentsOfDirectoryAtPath(path, error: nil)?.map { $0.pathExtension }
            for fileExt in fileExts! {
                let organisedFiles = fileManager.organiseDirectoryAtPath(path, withExtension: fileExt)
                outputFilePaths.unionInPlace(organisedFiles)
            }
            
            outputFilePaths.insert(path)
        }
        
        deliverUserNotification(Array<String>(outputFilePaths))

        return outputFilePaths
    }
}