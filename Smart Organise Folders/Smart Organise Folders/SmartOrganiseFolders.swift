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
    
    override func runWithInput(input: AnyObject?) throws -> AnyObject {
        let inputFilePaths = Set<String>(input as! Array<String>)
        var outputFilePaths = Set<String>()
        
        let fileManager = NSFileManager.defaultManager()
        
        for path in inputFilePaths {
            var isDirectory = ObjCBool(false)
            if !fileManager.fileExistsAtPath(path, isDirectory: &isDirectory) || !isDirectory {
                continue
            }
            
            let fileExts: Array<String>? = (try! fileManager.contentsOfDirectoryAtPath(path))?.map { $0.pathExtension }
            let uniqueFileExts = Set(fileExts!).subtract(Set(arrayLiteral: ""))
            for fileExt in uniqueFileExts {
                let organisedFiles = fileManager.organiseDirectoryAtPath(path, withExtension: fileExt)
                outputFilePaths.unionInPlace(organisedFiles)
            }
        }
        
        deliverUserNotification(Array<String>(outputFilePaths))

        return outputFilePaths
    }
}
