//
//  NetworkModels.swift
//  Countries Info
//
//  Created by Ayokunle Pro on 8/23/24.
//

import Foundation

enum Endpoint: String {
    case allCountries = "/v3.1/all"
}

enum NetworkError: Error {
    case badUrl
    case error
    case dataNotFound
}
