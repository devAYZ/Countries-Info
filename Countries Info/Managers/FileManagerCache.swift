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
    private var cacheDirectory: URL
    
    // MARK: Initialization
    private init() {
        if let cacheDirectory = manager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            let appFolder = cacheDirectory.appendingPathComponent(SConstants.appName)
            do {
                try manager.createDirectory(at: appFolder, withIntermediateDirectories: true)
                self.cacheDirectory = appFolder
            } catch {
                self.cacheDirectory = cacheDirectory
                print(error)
                fatalError(error.localizedDescription)
            }
            
        } else {
            fatalError("Unable to locate cache directory")
        }
    }
    
    func cacheObject<T>(object: T, key: CacheKey) where T : Encodable {
        
        let fileURL = cacheDirectory.appendingPathComponent(key.rawValue)
        do {
            let data = try JSONEncoder().encode(object)
            manager.createFile(atPath: fileURL.path, contents: data, attributes: nil)
        } catch {
            print(error)
            fatalError(error.localizedDescription)
        }
    }
    
    func retrieveCachedObject<T>(object: T.Type, key: CacheKey) -> T? where T : Decodable {
        
        let fileURL = cacheDirectory.appendingPathComponent(key.rawValue)
        guard let data = try? Data(contentsOf: fileURL) else {
            return nil
        }
        
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch {
            print(error)
            fatalError(error.localizedDescription)
        }
    }
    
    func removeObject(key: CacheKey) {
        let fileURL = cacheDirectory.appendingPathComponent(key.rawValue)
        do {
            try manager.removeItem(at: fileURL)
        } catch {
            print(error)
            fatalError(error.localizedDescription)
        }
    }
}
