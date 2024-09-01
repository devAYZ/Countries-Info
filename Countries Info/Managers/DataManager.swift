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

enum DataManagerKeys: String {
    case userProfile
    case allCountries
}

final class DataManager {
    
    // MARK: Init
    init() {
    }
    
    // MARK: Properties (User default)
    fileprivate static let shared = DataManager()
    
    var allCountries: CountriesResponseList? {
        get {
            if let data = UserDefaults.standard.data(forKey: DataManagerKeys.allCountries.rawValue) {
                return try? JSONDecoder().decode(CountriesResponseList.self, from: data)
            }
            return nil
        }
        set(value){
            if let encoded = try? JSONEncoder().encode(value) {
                UserDefaults.standard.set(encoded, forKey: DataManagerKeys.allCountries.rawValue)
            }
        }
    }
    
    var userProfile: UserProfile? {
        get {
            if let data = UserDefaults.standard.data(forKey: DataManagerKeys.userProfile.rawValue) {
                return try? JSONDecoder().decode(UserProfile.self, from: data)
            }
            return nil
        }
        set(value){
            if let encoded = try? JSONEncoder().encode(value) {
                UserDefaults.standard.set(encoded, forKey: DataManagerKeys.userProfile.rawValue)
            }
        }
    }
    
    func logOut() {
        userProfile = nil
        GIDSignIn.sharedInstance.signOut()
    }
}

extension DataManagerInjector {
    var dataManager: DataManager {
        return DataManager.shared
    }
}
