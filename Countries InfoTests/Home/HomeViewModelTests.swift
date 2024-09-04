//
//  HomeViewModelTests.swift
//  Countries InfoTests
//
//  Created by Ayokunle Pro on 8/23/24.
//

import XCTest
@testable import Countries_Info

final class HomeViewModelTests: XCTestCase {
    
    // MARK: Properties
    var sut: HomeViewModel!
    var mockView: MockHomeView!
    var mockNetworkClass: MockNetworkClass!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockNetworkClass = MockNetworkClass()
        sut = HomeViewModel(networkClass: mockNetworkClass)
        mockView = MockHomeView()
        sut.attachView(view: mockView)
    }

    override func tearDown() {
        mockView = nil
        mockNetworkClass = nil
        sut = nil
        super.tearDown()
    }
    
    /// `test_fetchCountryList_Success`
    func test_fetchCountryList_Success() {
        let exp = expectation(description: "Wait for fetch completion")
        sut.fetchCountryList()
        
        XCTAssertEqual(mockView.response?.status, true)
        exp.fulfill()
        
        waitForExpectations(timeout: 0.1)
    }
    
    func  test_fetchCountryList_CompletesOnMainThread() {
        let exp = expectation(description: "Wait for fetch completion")
        
        mockNetworkClass.makeNetworkCall_AF(urlString: .allCountries) {(response: FResponse<CountriesResponseList, FError>) in
            XCTAssertTrue(Thread.isMainThread)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 0.1)
    }
    
    /// `test_fetchCountryList_ValidData`
    func test_fetchCountryList_ValidData() {
        sut.fetchCountryList()
        XCTAssertNotNil(mockView.response?.data)
        XCTAssertEqual(mockView.response?.data?.count, 2)
    }

    /// `test_fetchCountryList_ValidDataObjects`
    func test_fetchCountryList_ValidDataObjects() {
        sut.fetchCountryList()
        XCTAssertNotNil( mockView.response?.data?.allSatisfy { $0.name?.common != nil } )
        XCTAssertEqual(mockView.response?.data?.first?.name?.common, "Sweden")
        XCTAssertEqual(mockView.response?.data?.first?.population, 10_000_000)
    }
    
    /// `test_fetchCountryList_hasRealCurrency`
    func test_fetchCountryList_hasRealCurrency() {
        sut.fetchCountryList()
        XCTAssertNotNil( mockView.response?.data?.allSatisfy { $0.currencies != nil } )
        
    }
}
