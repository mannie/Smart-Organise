//
//  AMBundleActionExtensions.swift
//  TAGToolbox
//
//  Created by etagarira on 20/06/2015.
//
//

import Automator

public extension AMBundleAction {
    
    func deliverUserNotification(filePaths: Array<String>) {
        let fileExts = filePaths.map { $0.pathExtension }
        let uniqueFileExts = Set(fileExts).subtract(Set(arrayLiteral: ""))
        
        let joinedFileExts = (Array(uniqueFileExts) as NSArray).componentsJoinedByString(", ")
        
        let notification = NSUserNotification()
        notification.title = name
        notification.informativeText = "\(filePaths.count) item" + (filePaths.count == 1 ? "" : "s") + " | \(joinedFileExts)"
        
        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
    }
    
}
