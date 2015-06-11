//
//  NSFileManagerExtensions.swift
//  TAGToolbox
//
//  Created by etagarira on 10/06/2015.
//
//

import Foundation

public extension NSFileManager {
    
    func collisionSafePath(path: String) -> String {
        if path.isEmpty {
            return path
        }
        
        let parentDir = path.stringByDeletingLastPathComponent
        
        let filename = path.lastPathComponent.stringByDeletingPathExtension
        let fileExt = path.pathExtension
        
        var trailingNumber = filename.componentsSeparatedByString(" ").last?.toInt()
        let endsWithNumber = trailingNumber != nil
        
        var uniquenessModifier = endsWithNumber ? trailingNumber! + 1 : 1
        var uniquePath = path
        var uniqueName = path.lastPathComponent
        
        while fileExistsAtPath(uniquePath) {
            if endsWithNumber {
                uniqueName = uniqueName.stringByDeletingPathExtension
                uniqueName = uniqueName.stringByReplacingOccurrencesOfString(" \(trailingNumber!)", withString: " \(uniquenessModifier)", options: .BackwardsSearch, range: nil)
                trailingNumber = uniquenessModifier as Int?
            } else {
                uniqueName = "\(filename) \(uniquenessModifier)"
            }
            uniquenessModifier++
            
            if !fileExt.isEmpty {
                uniqueName = uniqueName.stringByAppendingPathExtension(fileExt)!
            }
            
            uniquePath = parentDir.stringByAppendingPathComponent(uniqueName)
        }
    
        return uniquePath
    }
    
}

extension NSFileManager {
    
    func pathForFixtures(name: String) -> String {
        let suffix = "Tests".stringByAppendingPathComponent("Fixtures").stringByAppendingPathComponent(name.pathExtension)
        let subpaths = subpathsAtPath(currentDirectoryPath) as! Array<String>
        return subpaths.filter { $0.hasSuffix(suffix) }.first!
    }
    
}

