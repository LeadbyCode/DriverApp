//
//  DriverViewModel.swift
//  DriverApp
//
//  Created by Nilesh Vernekar on 10/12/24.
//

import Foundation

class DriverViewModel:DriverViewModelProtocols{
    var reloadTableView: (() -> Void)?
    private let driverService: DriverServiceProtocol
    var driverData: DriverModel?

    init(driverService: DriverServiceProtocol = DriverService()) {
        self.driverService = driverService
    }
    
    
    func fetchData() {
        driverService.fetchData(completion: { [weak self] result in
            switch result {
            case .success(let driverData):
                self?.driverData = driverData
                self?.reloadTableView?()
            case .failure(let error):
                print("Error fetching articles: \(error)")

                self?.reloadTableView?()
            }
        })
    }
    
    func numberOfLogs() -> Int {
        return driverData?.logs.count ?? 0
    }
    
    func driver(at index: Int) -> Log {
        return (driverData?.logs[index])!
    }
    


}
