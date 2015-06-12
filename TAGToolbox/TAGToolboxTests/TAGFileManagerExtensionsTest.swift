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
    let fixturesPath = NSFileManager.defaultManager().pathForFixtures(className())
    
    override func setUp() {
        fileManager.changeCurrentDirectoryPath(fixturesPath)
    }
    
    private func performCollisionSafePathTest(path: String, shouldExist: Bool=true, expected: String) {
        let actual = fileManager.collisionSafePath(path)
        XCTAssertEqual(actual, expected)
        XCTAssertEqual(fileManager.fileExistsAtPath(path), shouldExist, "File should" + (shouldExist ? "" : " NOT") + " exist: \(path)")
    }
    
    func testCollisionSafePath() {
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
        
    func testSubpathsAtPathWithExtensionDepth() {
        XCTAssertEqual(fileManager.subpathsAtPath(".", withExtension: ""), fileManager.subpathsAtPath(".", withExtension: "", depth: 0))
        XCTAssertEqual(fileManager.subpathsAtPath(".", withExtension: "ext"), fileManager.subpathsAtPath(".", withExtension: "ext", depth: 0))
        
        let level0NoExt = [ "File 1", "File 2", "File 3", "In Folder" ]
        let level0WithExt = [ "File 3.ext", "File 4.ext", "File 5.ext" ]

        let dsStores = [".DS_Store", "In Folder/.DS_Store"]
        
        XCTAssertEqual(fileManager.subpathsAtPath(".", withExtension: "", depth: 0).subtract(dsStores), Set(level0NoExt))
        XCTAssertEqual(fileManager.subpathsAtPath(".", withExtension: "ext", depth: 0), Set(level0WithExt))
        
        let mapper = { "In Folder".stringByAppendingPathComponent($0) }

        let level1NoExt: [String] = level0NoExt.map(mapper) + level0NoExt
        let level1WithExt: [String] = level0WithExt.map(mapper) + level0WithExt
        
        XCTAssertEqual(fileManager.subpathsAtPath(".", withExtension: "", depth: 1).subtract(dsStores), Set(level1NoExt).subtract(["In Folder/In Folder"]))
        XCTAssertEqual(fileManager.subpathsAtPath(".", withExtension: "ext", depth: 1), Set(level1WithExt))

        XCTAssertEqual(fileManager.subpathsAtPath(".", withExtension: "", depth: 2), fileManager.subpathsAtPath(".", withExtension: "", depth: 1))
        XCTAssertEqual(fileManager.subpathsAtPath(".", withExtension: "ext", depth: 2), fileManager.subpathsAtPath(".", withExtension: "ext", depth: 1))
    }

}
