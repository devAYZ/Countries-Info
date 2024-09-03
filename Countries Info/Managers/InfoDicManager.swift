//
//  InfoDic Manager.swift
//  Countries Info
//
//  Created by Ayokunle Pro on 9/2/24.
//

import Foundation

enum InfoDicKey: String {
    case appVersion = "CFBundleShortVersionString"
    case appVersionBuild = "CFBundleVersion"
    case restBaseUrl = "RestCountriesBaseURL"
}

struct InfoDicManager {
    static func getStringValue(key: InfoDicKey) -> String {
        guard let value = Bundle.main.infoDictionary?[key.rawValue] as? String else {
            fatalError("Could not find value for: \(key.rawValue)")
        }
        return value
    }
}
