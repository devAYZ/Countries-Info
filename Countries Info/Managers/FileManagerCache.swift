//
//  FileManagerCache.swift
//  Countries Info
//
//  Created by Ayokunle Pro on 9/3/24.
//

import Foundation

class FileManagerCache: CacheManagerProtocol {
    static let shared: FileManagerCache = {
        FileManagerCache()
    }()
    
    // Construct a file path using FileManager
    private let manager = FileManager.default
    private let cacheDirectory: URL
    
    // MARK: Initialization
    private init() {
        if let cacheDirectory = manager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let appFolder = cacheDirectory.appendingPathComponent(SConstants.appName)
            try? manager.createDirectory(at: appFolder, withIntermediateDirectories: true)
            self.cacheDirectory = appFolder
        } else {
            fatalError("Unable to locate cache directory")
        }
    }
    
    func cacheObject<T>(object: T, key: CacheKey) where T : Encodable {
        
        let fileURL = cacheDirectory.appendingPathComponent(key.rawValue)
        let data = try? JSONEncoder().encode(object)
        manager.createFile(atPath: fileURL.path, contents: data, attributes: nil)
    }
    
    func retrieveCachedObject<T>(object: T.Type, key: CacheKey) -> T? where T : Decodable {
        
        let fileURL = cacheDirectory.appendingPathComponent(key.rawValue)
        guard let data = try? Data(contentsOf: fileURL) else {
            return nil
        }
        
        let decodedObject = try? JSONDecoder().decode(T.self, from: data)
        return decodedObject
    }
    
    func removeObject(key: CacheKey) {
        let fileURL = cacheDirectory.appendingPathComponent(key.rawValue)
        try? manager.removeItem(at: fileURL)
    }
}
