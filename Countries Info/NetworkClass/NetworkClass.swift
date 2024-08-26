//
//  NetworkClass.swift
//  Countries Info
//
//  Created by Ayokunle Pro on 8/23/24.
//

import Foundation
import Alamofire

protocol NetworkClassProtocol {
    /// Blueprint network call using Alamofire
    /// - Parameters:
    ///   - urlString: urlString
    ///   - completion: completion handler
    func makeNetworkCall_AF<T: Decodable>(
        urlString: Endpoint,
        completion: @escaping (AFDataResponse<T>) -> () )
}

final class NetworkClass: NetworkClassProtocol {
    
    /// Implement network call using Alamofire
    /// - Parameters:
    ///   - urlString: urlString
    ///   - completion: completion handler
    func makeNetworkCall_AF<T: Decodable>(urlString: Endpoint, completion: @escaping (AFDataResponse<T>) -> ()){
        print(SConstants.startingNC) // Track network call
        AF.request(urlString.rawValue).responseDecodable(of: T.self) { response in
            print(SConstants.completedNC)
            completion(response)
        }
    }
    
    func makeNetworkCall_Native<T: Decodable>(
        urlString: Endpoint,
        completion: @escaping (Result<T, NetworkError>) -> ()
    ) {
        
        guard let url = URL(string: urlString.rawValue) else {
            completion(.failure(.badUrl))
            return
        }
        
        print(SConstants.startingNC) // Track network call
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .returnCacheDataElseLoad
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            print(SConstants.completedNC)
            
            guard error == nil else {
                print(error as Any)
                completion(.failure(error as? NetworkError ?? .error))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataNotFound))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                print(error)
                completion(.failure(error as? NetworkError ?? .error))
            }
        }
        task.resume()
    }
}


