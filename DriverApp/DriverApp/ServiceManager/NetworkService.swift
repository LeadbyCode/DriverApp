//
//  NetworkService.swift
//  DriverApp
//
//  Created by Nilesh Vernekar on 10/12/24.
//


import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Codable>(from endpoint: URLEndpoint, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func fetchData<T: Codable>(from endpoint: URLEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        let urlEndpoint = URL(string: "https://dcd8e5bc-8d27-4257-8c92-f81a553da7a7.mock.pstmn.io")
        guard let url = urlEndpoint else {
            completion(.failure(NSError(domain: "URLError", code: -1, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
