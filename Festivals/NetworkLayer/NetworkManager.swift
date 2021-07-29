//
//  NetworkManager.swift
//  Festivals
//
//  Created by gurjeet singh on 11/7/21.
//

import Foundation

class NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse(Data?, URLResponse?)
    }
    
    public func get(urlString: String, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionBlock(.failure(NetworkError.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionBlock(.failure(error!))
                return
            }
            guard data != nil else {
                completionBlock(.failure(NetworkError.invalidResponse(data, response)))
                return
            }
            completionBlock(.success(data!))
        }
        task.resume()
    }
}

