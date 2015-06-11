//
//  TAGFileManagerExtensionsTest.swift
//  TAGToolbox
//
//  Created by etagarira on 10/06/2015.
//
//

import Cocoa
import XCTest

class TAGFileManagerExtensionsTest: XCTestCase {

    let fileManager = NSFileManager.defaultManager()
    
    private func performCollisionSafePathTest(path: String, shouldExist: Bool=true, expected: String) {
        let actual = fileManager.collisionSafePath(path)
        XCTAssertEqual(actual, expected)
        XCTAssertEqual(fileManager.fileExistsAtPath(path), shouldExist, "File should" + (shouldExist ? "" : " NOT") + " exist: \(path)")
    }
    
    func testCollisionSafePath() {
        let testFixturesPath = fileManager.pathForFixtures(className)
        fileManager.changeCurrentDirectoryPath(testFixturesPath)

        performCollisionSafePathTest("File 1", expected: "File 4")
        performCollisionSafePathTest("File 2", expected: "File 4")
        performCollisionSafePathTest("File 3", expected: "File 4")
        performCollisionSafePathTest("File 4", shouldExist: false, expected: "File 4")
        
        performCollisionSafePathTest("In Folder/File 1", expected: "In Folder/File 4")
        performCollisionSafePathTest("In Folder/File 2", expected: "In Folder/File 4")
        performCollisionSafePathTest("In Folder/File 3", expected: "In Folder/File 4")
        performCollisionSafePathTest("In Folder/File 4", shouldExist: false, expected: "In Folder/File 4")
        
        performCollisionSafePathTest("File 3.ext", expected: "File 6.ext")
        performCollisionSafePathTest("File 4.ext", expected: "File 6.ext")
        performCollisionSafePathTest("File 5.ext", expected: "File 6.ext")
        performCollisionSafePathTest("File 6.ext", shouldExist: false, expected: "File 6.ext")

        performCollisionSafePathTest("In Folder/File 3.ext", expected: "In Folder/File 6.ext")
        performCollisionSafePathTest("In Folder/File 4.ext", expected: "In Folder/File 6.ext")
        performCollisionSafePathTest("In Folder/File 5.ext", expected: "In Folder/File 6.ext")
        performCollisionSafePathTest("In Folder/File 6.ext", shouldExist: false, expected: "In Folder/File 6.ext")
}

}
