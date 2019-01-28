//
//  HexadTestTests.swift
//  HexadTestTests
//
//  Created by Anand, Walvekar on 1/28/19.
//  Copyright © 2019 Anand, Walvekar. All rights reserved.
//

import XCTest

class HexadTestTests: XCTestCase {
    
    let model = ItemListViewModel()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        model.refresh {
//            print("loaded \(self.model.items.count) items")
            XCTAssertTrue(self.model.items.count != 0, "ItemListViewModel failed to load items")
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSortByRating() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //sort by rating
        model.sort(.rating)
        
        //verify
        for i in 0..<(model.items.count - 1) {
            let itemA = model.items[i]
            let itemB = model.items[i+1]
            XCTAssertTrue(itemA.totalRating/itemA.ratingCount >= itemB.totalRating/itemB.ratingCount)
        }
    }
    
    func testSortByName() {
        //sort by rating
        model.sort(.name)
        
        //verify
        for i in 0..<(model.items.count - 1) {
            let itemA = model.items[i]
            let itemB = model.items[i+1]
            XCTAssertTrue(itemA.itemName < itemB.itemName)
        }
    }

    func testPerformanceRatingSort() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            // Intentionally baselined to perform better
            model.sort(.rating)
        }
    }
    
    func testPerformanceNameSort() {
        // This is an example of a performance test case.
        // Intentionally baselined to perform worse
        self.measure {
            // Put the code you want to measure the time of here.
            model.sort(.name)
        }
    }


}
