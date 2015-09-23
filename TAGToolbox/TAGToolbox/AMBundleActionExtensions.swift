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
        if filePaths.count == 0 {
            return
        }
        
        let notification = NSUserNotification()
        notification.title = name
        
        let fileExts = filePaths.map { ($0 as NSString).pathExtension }
        let uniqueFileExts = Set(fileExts).subtract(Set(arrayLiteral: ""))
        
        var informativeText = "\(filePaths.count) item" + (filePaths.count == 1 ? "" : "s")
        if uniqueFileExts.count > 0 {
            informativeText += " | " + (Array(uniqueFileExts) as NSArray).componentsJoinedByString(", ")
        }
        notification.informativeText = informativeText

        NSUserNotificationCenter.defaultUserNotificationCenter().deliverNotification(notification)
    }
    
}
