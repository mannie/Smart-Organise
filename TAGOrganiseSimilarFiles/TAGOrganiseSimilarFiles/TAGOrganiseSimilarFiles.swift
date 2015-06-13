//
//  TAGOrganiseSimilarFiles.swift
//  TAGOrganiseSimilarFiles
//
//  Created by etagarira on 10/06/2015.
//
//

import Automator
import TAGToolbox

class TAGOrganiseSimilarFiles: AMBundleAction {

    override func runWithInput(input: AnyObject!, error: NSErrorPointer) -> AnyObject! {
        let inputFilePaths = Set<String>(input as! Array<String>)
        var outputFilePaths = Set<String>()

        for sourcePath in inputFilePaths {
            let fileExt = sourcePath.pathExtension
            if fileExt.isEmpty {
                outputFilePaths.insert(sourcePath)
                continue
            }
            
            let parentDirectory = sourcePath.stringByDeletingLastPathComponent
            let organisedFiles = NSFileManager.defaultManager().organiseFilesAtPath(parentDirectory, withExtension: fileExt)
            outputFilePaths.unionInPlace(organisedFiles)
        }
        
        return outputFilePaths
    }
    
}
