//
//  NetworkClass.swift
//  Countries Info
//
//  Created by Ayokunle Pro on 8/23/24.
//

import Foundation
import Alamofire

protocol NetworkClassProtocol {
    func makeNetworkCall_Native<T: Decodable>(
        urlString: Endpoint,
        completion: @escaping (Result<T, NetworkError>) -> ())
    
    func makeNetworkCall_AF<T: Decodable>(
        urlString: Endpoint,
        completion: @escaping (AFDataResponse<T>) -> () )
}

typealias FError = AFError
typealias FResponse = DataResponse

class NetworkClass: NetworkClassProtocol {
    
    func makeNetworkCall_Native<T: Decodable>(
        urlString: Endpoint,
        completion: @escaping (Result<T, NetworkError>) -> ()
    ) {
        
        guard let url = URL(string: urlString.rawValue) else {
            completion(.failure(.badUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .returnCacheDataElseLoad
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            //
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
            }
        }
        task.resume()
    }
    
    func makeNetworkCall_AF<T: Decodable>(urlString: Endpoint, completion: @escaping (AFDataResponse<T>) -> ()){
        print("STARTING.. Network call")
        AF.request(urlString.rawValue).responseDecodable(of: T.self) { response in
            print("COMPLETED.. Network call")
            completion(response)
        }
    }
}


