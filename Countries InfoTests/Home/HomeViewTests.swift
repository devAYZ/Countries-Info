//
//  HomeViewTests.swift
//  Countries InfoTests
//
//  Created by Ayokunle Pro on 9/3/24.
//

import UIKit

import XCTest
import Kingfisher
@testable import Countries_Info

final class HomeViewTests: XCTestCase {
    
    // MARK: Properties
    //var sut: HomeViewController!
    var mockDisplayView: HomeViews!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        //sut = HomeViewController()
        mockDisplayView = HomeViews()
        //sut.attachViews(mockDisplayView)
    }
    
    override func tearDown() {
        mockDisplayView = nil
        //sut = nil
        super.tearDown()
    }
    
    /// `test_searchController_placeholder`
    func test_searchController_placeholder() {
        let placeholderInUse = mockDisplayView.searchController.searchBar.placeholder
        let validPlaceholder = "Search by: Name, Capital, Currency"
        XCTAssertEqual(placeholderInUse, validPlaceholder)
    }
    
}
