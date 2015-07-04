//
//  StringExtensionsTest.swift
//  TAGToolbox
//
//  Created by etagarira on 10/06/2015.
//
//

import Cocoa
import XCTest

class StringExtensionsTest: XCTestCase {

    func testDateFormatting() {
        let dateComponents = NSDateComponents()
        dateComponents.day = 26
        dateComponents.month = 2
        dateComponents.year = 2010
        
        let date = NSCalendar.currentCalendar().dateFromComponents(dateComponents) as NSDate!

        XCTAssertEqual(String(date: date, format: "yyyy-MM-dd"), "2010-02-26")
        
        XCTAssertEqual(String(date: date, format: "YYYY"), "2010")
        XCTAssertEqual(String(date: date, format: "yy"), "10")

        XCTAssertEqual(String(date: date, format: "MMMM"), "February")
        XCTAssertEqual(String(date: date, format: "MMM"), "Feb")
        XCTAssertEqual(String(date: date, format: "MM"), "02")

        XCTAssertEqual(String(date: date, format: "dd"), "26")

    }

}
