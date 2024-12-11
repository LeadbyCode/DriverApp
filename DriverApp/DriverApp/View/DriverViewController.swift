//
//  ViewController.swift
//  DriverApp
//
//  Created by Nilesh Vernekar on 10/12/24.
//

import UIKit

class DriverViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var driverData: DriverModel?
    private var viewModel: DriverViewModelProtocols = DriverViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: DriverTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: DriverTableViewCell.cellIdentifier)
        loaddata()
    }

    func loaddata() {
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.fetchData()
//        fetchJSON(from: "https://dcd8e5bc-8d27-4257-8c92-f81a553da7a7.mock.pstmn.io", decodeType: DriverModel.self) { result in
//            switch result {
//            case .success(let user):
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            case .failure(let error):
//                print("error")
//            }
//        }
    }
    func fetchJSON<T: Decodable>(from urlString: String, decodeType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                 if let error = error {
                     completion(.failure(error))
                     return
                 }
                 
                 if let httpResponse = response as? HTTPURLResponse {
                     print("Status code:", httpResponse.statusCode)
                 }
                 
                 if let data = data {
                     do {
                         let decodedData = try JSONDecoder().decode(decodeType, from: data)
                         completion(.success(decodedData))
                     } catch {
                         completion(.failure(error))
                     }
                 }
             }
             
             task.resume()
         }

}

extension DriverViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfLogs()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: DriverTableViewCell.cellIdentifier) as? DriverTableViewCell {
            let driverEntry = viewModel.driver(at: indexPath.row)
            cell.getDrivereData(data: driverEntry)
            // set the text from the data model            
            return cell
        }
        return UITableViewCell()
    }
    
    
}
