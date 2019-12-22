//
//  PodcastedNeoUnitTests.swift
//  PodcastedNeoUnitTests
//
//  Created by Ali Moussa on 29/11/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import XCTest
import AFDateHelper

extension Int {
    func formatMSToDate(miliseconds: Int) -> String {
        let milisecond = miliseconds
        let dateVar = Date.init(timeIntervalSince1970: TimeInterval(milisecond)/1000)
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var dateFormatterString = dateFormatter.string(from: dateVar)
        
        return dateFormatterString
    }
}

class PodcastedNeoUnitTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDateInMSToDate() {
        let pubDateInMS = 1546232460000 // 31. December 2018
        let pubDateInString = pubDateInMS.formatMSToDate(miliseconds: pubDateInMS)
        XCTAssertEqual("31-12-2018", pubDateInString)
    }
    
}
