//
//  DataManager.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import Foundation

protocol DataManagerInjector {
    var dataManager: DataManager { get }
}

enum DataManagerKeys: String {
    case hasSeenOnboardingSlide
}

final class DataManager {
    
    // MARK: Init
    init() {
    }
    
    // MARK: Properties (User default)
    fileprivate static let shared = DataManager()
    
    var hasSeenOnboardingSlide: Bool {
        get {
            UserDefaults.standard.bool(forKey: DataManagerKeys.hasSeenOnboardingSlide.rawValue)
        }
        set (value){
            UserDefaults.standard.setValue(value, forKey: DataManagerKeys.hasSeenOnboardingSlide.rawValue)
        }
    }
}

extension DataManagerInjector {
    var dataManager: DataManager {
        return DataManager.shared
    }
}
