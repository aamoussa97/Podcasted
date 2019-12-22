//
//  PodcastedNeoUITests.swift
//  PodcastedNeoUITests
//
//  Created by Ali Moussa on 29/11/2019.
//  Copyright © 2019 Ali Moussa. All rights reserved.
//

import XCTest

class PodcastedNeoUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
        
    func testAddPodcastToSavedAndCheckForExistence() {
        let app = XCUIApplication()
        app.launch()
    
        let podcastSeachString = "TechStuff"
        
        // Goto search, and add podcast (podcastSeachString) to saved.
        app.tabBars.buttons["Search"].tap()
        let searchNavBar = app.navigationBars["Search"].searchFields["Search for a podcast by name, person, topic, genre ..."]
        
        searchNavBar.tap()
        searchNavBar.typeText(podcastSeachString)
        app/*@START_MENU_TOKEN@*/.otherElements["PopoverDismissRegion"]/*[[".otherElements[\"dismiss popup\"]",".otherElements[\"PopoverDismissRegion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.tables.cells.containing(.staticText, identifier:podcastSeachString).buttons["plus.app.fill"].tap()
        
        // Check for newly saved podcast from search via podcastSeachString.
        let newSavedPodcastsCell = app.tables.staticTexts[podcastSeachString]
        XCTAssertTrue(newSavedPodcastsCell.exists)
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: newSavedPodcastsCell, handler: nil)
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testShowEpisodesVCFromSavedPodcasts() {
        let app = XCUIApplication()
        app.launch()
        
        let podcastNameString = "Darknet Diaries"
        let episodeNameString = "Ep 52: Magecart"
        
        let chosenPodcastsCell = app.tables.staticTexts[podcastNameString]
        XCTAssertTrue(chosenPodcastsCell.exists)
        
        chosenPodcastsCell.tap()
        
        let chosenEpisodeCell = app.tables.staticTexts[episodeNameString]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: chosenEpisodeCell, handler: nil)
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertTrue(chosenEpisodeCell.exists)
    }
    
    func testPlayEpisodeFromSavedPodcasts() {
        let app = XCUIApplication()
        app.launch()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Darknet Diaries"]/*[[".cells.staticTexts[\"Darknet Diaries\"]",".staticTexts[\"Darknet Diaries\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Ep 52: Magecart")/*[[".cells.containing(.staticText, identifier:\"51m\")",".cells.containing(.staticText, identifier:\"26 November\")",".cells.containing(.staticText, identifier:\"Ep 52: Magecart\")"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Play"].tap()
        
        XCTAssertTrue(app.images["PlayingNowPodcastIcon"].exists)
        XCTAssertTrue(app.buttons["PlayingNowShowAboutEpisode"].exists)
        XCTAssertTrue(app.buttons["PlayingNowShowShowQueue"].exists)
        XCTAssertTrue(app.buttons["PlayingNowShowPlaybackSpeed"].exists)
        XCTAssertTrue(app.buttons["PlayingNowShowAirPlayPicker"].exists)
        XCTAssertTrue(app.buttons["PlayingNowPlayPausePodcast"].exists)
        XCTAssertTrue(app.buttons["PlayingNowSeekBackPodcast"].exists)
        XCTAssertTrue(app.buttons["PlayingNowSeekBackPodcast"].exists)
        XCTAssertTrue(app.buttons["PlayingNowForwardPodcast"].exists)
    }

}
