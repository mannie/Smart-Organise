//
//  NSFileManagerExtensions.swift
//  TAGToolbox
//
//  Created by etagarira on 10/06/2015.
//
//

import Foundation

public extension NSFileManager {
    
    private func exportablePathFromPath(path: String, relativeTo relativePath: String) -> String {
        return relativePath == "." ? path : (relativePath as NSString).stringByAppendingPathComponent(path)
    }
    
    private func createDirectoryAtPath(path: String) {
        do {
            try createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
        } catch _ {
            assert(fileExistsAtPath(path))
        }
    }
    
    func organiseItemAtPath(path: String, withDate date: NSDate) -> String? {
        var outputFilePath: String? = nil

        if !fileExistsAtPath(path) {
            return outputFilePath
        }
        
        let parentDirectory = path.stringByDeletingLastPathComponent
        let dateString = String(date: date, format: "yyyy-MM-dd")
        
        var destinationPath = parentDirectory.stringByAppendingPathComponent(dateString)
        
        createDirectoryAtPath(destinationPath)
        
        if path != "." {
            destinationPath = destinationPath.stringByAppendingPathComponent(path.lastPathComponent)
        }
        destinationPath = collisionSafePath(destinationPath)
        
        try! moveItemAtPath(path, toPath: destinationPath)
        outputFilePath = destinationPath
        
        return outputFilePath
    }

    func organiseDirectoryAtPath(path: String, withExtension fileExt: String) -> Set<String> {
        var outputFilePaths = Set<String>()
        
        var isDirectory = ObjCBool(false)
        if !fileExistsAtPath(path, isDirectory: &isDirectory) || !isDirectory {
            return outputFilePaths
        }
        
        let lastCurrentDirectoryPath = currentDirectoryPath
        changeCurrentDirectoryPath(path)
        
        for sourcePath in subpathsAtPath(".", withExtension: fileExt) {
            if fileExt.isEmpty {
                outputFilePaths.insert(exportablePathFromPath(sourcePath, relativeTo: path))
                continue
            }
            
            // TODO: allow for some override control
            let exclusions = Set(arrayLiteral: "download", "part")
            if exclusions.contains(fileExt) {
                outputFilePaths.insert(exportablePathFromPath(sourcePath, relativeTo: path))
                continue
            }

            let destinationPath = collisionSafePath((fileExt as NSString).stringByAppendingPathComponent(sourcePath))

            createDirectoryAtPath(fileExt)
            
            try! moveItemAtPath(sourcePath, toPath: destinationPath)
            outputFilePaths.insert(exportablePathFromPath(destinationPath, relativeTo: path))
        }
        
        changeCurrentDirectoryPath(lastCurrentDirectoryPath)
        
        return outputFilePaths
    }

    internal func collisionSafePath(path: String) -> String {
        if path.isEmpty {
            return path
        }
        
        let parentDir = path.stringByDeletingLastPathComponent
        
        let filename = path.lastPathComponent.stringByDeletingPathExtension
        let fileExt = path.pathExtension
        
        let filenameComponents = filename.componentsSeparatedByString(" ")
        
        var trailingNumber = filenameComponents.count <= 1 ? nil : filenameComponents.last?.toInt()
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
    
    internal func subpathsAtPath(path: String, withExtension fileExt: String, depth: Int=0) -> Set<String> {
        assert(!path.isEmpty, "Path cannot be empty")

        if !fileExistsAtPath(path) {
            return Set()
        }
        
        let maxCountOfPathComponents = depth + 1

        let filteredSubpaths = subpathsAtPath(path)?.filter {
            let subpath = $0 as NSString
            return subpath.pathComponents.count <= maxCountOfPathComponents && subpath.pathExtension == fileExt
        }
    
        return Set<String>(filteredSubpaths as! Array<String>)
    }
    
}

// MARK: - Testing -

extension NSFileManager {
    
    func pathForFixtures(name: String) -> String {
        let suffix = ("Fixtures" as NSString).stringByAppendingPathComponent((name as NSString).pathExtension)

        let bundle = NSBundle.allBundles().filter { $0.principalClass == NSClassFromString(name) }.first!

        let lastCurrentDirectoryPath = currentDirectoryPath
        changeCurrentDirectoryPath(bundle.resourcePath!)
        let subpaths = subpathsAtPath(currentDirectoryPath)! as Array<String>
        changeCurrentDirectoryPath(lastCurrentDirectoryPath)
        
        let path = subpaths.filter { $0.hasSuffix(suffix) }.first!
        return (bundle.resourcePath! as NSString).stringByAppendingPathComponent(path)
    }
    
    class func swizzle(selector: Selector, withSelector replacementSelector: Selector) {
        let targetClass: AnyClass = object_getClass(NSFileManager())
        
        let originalMethod = class_getInstanceMethod(targetClass, selector)
        let replacementMethod = class_getInstanceMethod(targetClass, replacementSelector)

        assert(originalMethod != nil && replacementMethod != nil)
        method_exchangeImplementations(originalMethod, replacementMethod)
    }
    
}

