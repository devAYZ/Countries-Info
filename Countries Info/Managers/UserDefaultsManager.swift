//
//  UserDefaults Manager.swift
//  Countries Info
//
//  Created by Ayokunle Pro on 9/2/24.
//

import Foundation

protocol CacheManagerProtocol {
    associatedtype T
    static var shared: T { get }
    func cacheObject<T: Encodable>(object: T, key: CacheKey)
    func retrieveCachedObject<T: Decodable>(object: T.Type, key: CacheKey) -> T?
    func removeObject(key: CacheKey)
}

enum CacheKey: String {
    case userProfile
    case allCountries
}

class UserDefaultCache: CacheManagerProtocol {
    static let shared: UserDefaultCache = {
        UserDefaultCache()
    }()
    private let userDefaults = UserDefaults.standard
    
    // MARK: Initialization
    private init() {}
    
    // Cache - Objects
    func cacheObject<T: Encodable>(object: T, key: CacheKey) {
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(object)
        
        userDefaults.set(data, forKey: key.rawValue)
    }
    
    func retrieveCachedObject<T: Decodable>(object: T.Type, key: CacheKey) -> T? {
        guard let data = userDefaults.data(forKey: key.rawValue) else {
            return nil
        }
        let jsonDecoder = JSONDecoder()
        let object = try? jsonDecoder.decode(T.self, from: data)
        return object
    }
    
    func removeObject(key: CacheKey) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
