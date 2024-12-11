//
//  DriverService.swift
//  DriverApp
//
//  Created by Nilesh Vernekar on 10/12/24.
//

import Foundation

protocol DriverServiceProtocol {
    func fetchData(completion: @escaping (Result<DriverModel, Error>) -> Void)
}

class DriverService: DriverServiceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    func fetchData(completion: @escaping (Result<DriverModel, Error>) -> Void) {
        let endpoint = URLEndpoint()
        
        networkService.fetchData(from: endpoint) { [weak self] (result: Result<DriverModel, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
