//
//  MockNetworkClass.swift
//  Countries InfoTests
//
//  Created by Ayokunle Pro on 8/23/24.
//

import Alamofire
@testable import Countries_Info
import Foundation

class MockNetworkClass: NetworkClassProtocol {
    
    // MARK: Properties
    var shouldSucceed: Bool = true
    var response: CountriesResponseList?
    var error: FError?
    
    func makeNetworkCall_AF<T>(urlString: Endpoint, completion: @escaping (Alamofire.AFDataResponse<T>) -> ()) where T : Decodable {
        
        completion(fetchCountriesSampleResponse())
        
        /* Test for Completion in Background
         DispatchQueue.global(qos: .background).async {
             completion(self.fetchCountriesSampleResponse())
         }
         */
    }
    
    func fetchCountriesSampleResponse<T>() -> AFDataResponse<T> { //DataResponse<T, AFError> {
        return DataResponse(
            request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 1,
            result: .success(
                [
                    CountriesResponse(
                        name: .init(common: "Sweden", official: "Kingdom of Sweden"),
                        currencies: ["SEK" : .init(name: "Krona", symbol: "kr")],
                        capital: ["Stockholm"],
                        population: 10_000_000,
                        timezones: ["UTC+01:00"],
                        continents: ["Europe"],
                        startOfWeek: "Monday"
                    ),
                    CountriesResponse(
                        name: .init(common: "Nigeria", official: "Federal Republic of Nigeria"),
                        currencies: ["NGN" : .init(name: "Nigerian naira", symbol: "₦")],
                        capital: ["Abuja"],
                        population: 206_000_000,
                        timezones: ["UTC+01:00"],
                        continents: ["Africa"],
                        startOfWeek: "Monday"
                    )
                ] as! T
            )
        )
    }
}
