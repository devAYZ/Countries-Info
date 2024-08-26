//
//  MockHomeView.swift
//  Countries InfoTests
//
//  Created by Ayokunle Pro on 8/23/24.
//

import Foundation
@testable import Countries_Info

struct MockResponse {
    var status: Bool
    var data: CountriesResponseList?
}

class MockHomeView: HomeView {
    // MARK: Properties
    var response: MockResponse?
    
    func networkCallSuccess(data: CountriesResponseList?) {
        response = MockResponse(status: true, data: data)
    }
    
    func networkCallFailed(error: Countries_Info.FError?) {
        //
    }
    
    
}
