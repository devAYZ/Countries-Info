//
//  DataManager.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import Foundation
import GoogleSignIn

protocol DataManagerInjector {
    var dataManager: DataManager { get }
}

final class DataManager {
    
    // MARK: Init
    init() {
    }
    
    // MARK: Properties (User default)
    fileprivate static let shared = DataManager()
    
    var allCountries: CountriesResponseList? {
        get {
            return CacheManager.shared.retrieveCachedObject(object: CountriesResponseList.self, key: .allCountries)
        }
        set(value){
            CacheManager.shared.cacheObject(object: value, key: .allCountries)
        }
    }
    
    var userProfile: UserProfile? {
        get {
            return CacheManager.shared.retrieveCachedObject(object: UserProfile.self, key: .userProfile)
        }
        set(value){
            CacheManager.shared.cacheObject(object: value, key: .userProfile)
        }
    }
    
    var appVersion: String {
        "v\(InfoDicManager.getStringValue(key: .appVersion))(\(InfoDicManager.getStringValue(key: .appVersionBuild)))"
    }
    
    func logOut() {
        CacheManager.shared.removeObject(key: .userProfile)
        CacheManager.shared.removeObject(key: .allCountries)
        GIDSignIn.sharedInstance.signOut()
    }
}

extension DataManagerInjector {
    var dataManager: DataManager {
        return DataManager.shared
    }
}
