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
    
    override class func initialize() {
        struct Static {
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            NSFileManager.swizzle(Selector("createDirectoryAtPath:withIntermediateDirectories:attributes:error:"), withSelector: Selector("_createDirectoryAtPath:withIntermediateDirectories:attributes:error:"))
            NSFileManager.swizzle(Selector("moveItemAtPath:toPath:error:"), withSelector: Selector("_moveItemAtPath:toPath:error:"))
        }
    }
    
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
        XCTAssertEqual(fileManager.subpathsAtPath(".", withExtension: "someRandomFakeExt", depth: 0), Set())
        XCTAssertEqual(fileManager.subpathsAtPath(".", withExtension: "someRandomFakeExt", depth: 1), Set())
        XCTAssertEqual(fileManager.subpathsAtPath(".", withExtension: "someRandomFakeExt", depth: 2), Set())

        XCTAssertEqual(fileManager.subpathsAtPath("Some Random Fake Folder", withExtension: "ext", depth: 0), Set())
        XCTAssertEqual(fileManager.subpathsAtPath("Some Random Fake Folder", withExtension: "ext", depth: 1), Set())
        XCTAssertEqual(fileManager.subpathsAtPath("Some Random Fake Folder", withExtension: "ext", depth: 2), Set())
        
        let dsStores = [ ".DS_Store", "In Folder/.DS_Store" ]
        
        XCTAssertEqual(fileManager.subpathsAtPath(".", withExtension: ""), fileManager.subpathsAtPath(".", withExtension: "", depth: 0))
        XCTAssertEqual(fileManager.subpathsAtPath(".", withExtension: "ext"), fileManager.subpathsAtPath(".", withExtension: "ext", depth: 0))
        
        let level0NoExt = [ "File 1", "File 2", "File 3", "In Folder" ]
        let level0WithExt = [ "File 3.ext", "File 4.ext", "File 5.ext" ]
        
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
    
    func testOrganiseFilesAtPathWithExtension() {
        XCTAssertEqual(fileManager.organiseFilesAtPath(".", withExtension: "someRandomFakeExt"), Set())
        XCTAssertEqual(fileManager.organiseFilesAtPath("File 1", withExtension: "someRandomFakeExt"), Set())
        XCTAssertEqual(fileManager.organiseFilesAtPath("In Folder", withExtension: "someRandomFakeExt"), Set())
        
        XCTAssertEqual(fileManager.organiseFilesAtPath("File 1", withExtension: "ext"), Set())
        XCTAssertEqual(fileManager.organiseFilesAtPath("Some Random Fake Folder", withExtension: "ext"), Set())
        
        let dsStores = [ ".DS_Store", "In Folder/.DS_Store" ]

        let level0NoExt = [ "File 1", "File 2", "File 3", "In Folder" ]
        let level0Ext = [ "ext/File 3.ext", "ext/File 4.ext", "ext/File 5.ext" ]
        let level0Ext2 = [ "ext2/File 5.ext2", "ext2/File 6.ext2", "ext2/File 7.ext2" ]
        
        XCTAssertEqual(fileManager.organiseFilesAtPath(".", withExtension: "").subtract(dsStores), Set(level0NoExt))
        XCTAssertEqual(fileManager.organiseFilesAtPath(".", withExtension: "ext").subtract(dsStores), Set(level0Ext))
        XCTAssertEqual(fileManager.organiseFilesAtPath(".", withExtension: "ext2").subtract(dsStores), Set(level0Ext2))
     
        let mapper = { "In Folder".stringByAppendingPathComponent($0) }
        
        let level1NoExt: [String] = level0NoExt.map(mapper)
        let level1Ext: [String] = level0Ext.map(mapper)
        let level1Ext2: [String] = level0Ext2.map(mapper)

        XCTAssertEqual(fileManager.organiseFilesAtPath("In Folder", withExtension: "").subtract(dsStores), Set(level1NoExt).subtract(["In Folder/In Folder"]))
        XCTAssertEqual(fileManager.organiseFilesAtPath("In Folder", withExtension: "ext").subtract(dsStores), Set(level1Ext))
        XCTAssertEqual(fileManager.organiseFilesAtPath("In Folder", withExtension: "ext2").subtract(dsStores), Set(level1Ext2))
    }

}

extension NSFileManager {
    
    func _createDirectoryAtPath(path: String, withIntermediateDirectories createIntermediates: Bool, attributes: [NSObject : AnyObject]?, error: NSErrorPointer) -> Bool {
        return true
    }
    
    func _moveItemAtPath(srcPath: String, toPath dstPath: String, error: NSErrorPointer) -> Bool {
        return true
    }
    
}

