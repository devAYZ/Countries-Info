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
            return FileManagerCache.shared.retrieveCachedObject(object: CountriesResponseList.self, key: .allCountries)
        }
        set(value){
            FileManagerCache.shared.cacheObject(object: value, key: .allCountries)
        }
    }
    
    var userProfile: UserProfile? {
        get {
            return UserDefaultCache.shared.retrieveCachedObject(object: UserProfile.self, key: .userProfile)
        }
        set(value){
            UserDefaultCache.shared.cacheObject(object: value, key: .userProfile)
        }
    }
    
    var appVersion: String {
        "v\(InfoDicManager.getStringValue(key: .appVersion))(\(InfoDicManager.getStringValue(key: .appVersionBuild)))"
    }
    
    func logOut() {
        UserDefaultCache.shared.removeObject(key: .userProfile)
        GIDSignIn.sharedInstance.signOut()
    }
}

extension DataManagerInjector {
    var dataManager: DataManager {
        return DataManager.shared
    }
}
