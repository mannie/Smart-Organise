//
//  OrganiseSimilarFiles.swift
//  Organise Similar Files
//
//  Created by etagarira on 10/06/2015.
//
//

import Automator
import TAGToolbox

class OrganiseSimilarFiles: AMBundleAction {
    
    override func runWithInput(input: AnyObject!, error: NSErrorPointer) -> AnyObject! {
        let inputFilePaths = Set<String>(input as! Array<String>)
        var outputFilePaths = Set<String>()
        
        let fileManager = NSFileManager.defaultManager()
        for sourcePath in inputFilePaths {
            if !fileManager.fileExistsAtPath(sourcePath) {
                continue
            }
            
            let fileExt = sourcePath.pathExtension
            if fileExt.isEmpty {
                outputFilePaths.insert(sourcePath)
                continue
            }
            
            let parentDirectory = sourcePath.stringByDeletingLastPathComponent
            let organisedFiles = fileManager.organiseDirectoryAtPath(parentDirectory, withExtension: fileExt)
            outputFilePaths.unionInPlace(organisedFiles)
        }
        
        return outputFilePaths
    }
    
}
