//
//  DriverViewProtocols.swift
//  DriverApp
//
//  Created by Nilesh Vernekar on 10/12/24.
//

import Foundation
protocol DriverViewModelProtocols {
    var reloadTableView: (() -> Void)? { get set }
    func fetchData()
    func numberOfLogs() -> Int
    func driver(at index: Int) -> Log
}
