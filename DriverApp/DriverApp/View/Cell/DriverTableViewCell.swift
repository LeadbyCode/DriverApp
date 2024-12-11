//
//  DriverTableViewCell.swift
//  DriverApp
//
//  Created by Nilesh Vernekar on 10/12/24.
//

import UIKit

class DriverTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var drivingdutyLbl: UILabel!
    @IBOutlet weak var drivinghrLbl: UILabel!
    @IBOutlet weak var offDutyLbl: UILabel!
    @IBOutlet weak var offDutyhrLbl: UILabel!
    @IBOutlet weak var onDutyNotDrivingLbl: UILabel!
    @IBOutlet weak var onDutyNotDrivinghrLbl: UILabel!
    @IBOutlet weak var sleeperBerthLbl: UILabel!
    @IBOutlet weak var sleeperBerthhrLbl: UILabel!

    static let cellIdentifier = "DriverTableViewCell"
    static let xibName = "DriverTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func getDrivereData(data:Log?) {
        self.drivingdutyLbl.text  = "DRIVING"
        if let duration = data?.DrivingTimeInHours{
            let time = "\(duration)"
            self.drivinghrLbl.text = "\(String(time.prefix(1))) hours"
        }
  
        self.offDutyLbl.text  = "OFF DUTY"
        if let duration = data?.offDutyTimeInHours{
            let time = "\(duration)"
            self.offDutyhrLbl.text = "\(String(time.prefix(1))) hours"
        }
        self.onDutyNotDrivingLbl.text  = "ON DUTY NOT DRIVING"
        if let duration = data?.onDutyNotDrivingTimeInHours{
            let time = "\(duration)"
            self.onDutyNotDrivinghrLbl.text = "\(String(time.prefix(1))) hours"
        }
        self.sleeperBerthLbl.text  = "SLEEPER BERTH"
        if let duration = data?.sleeperBerthTimeInHours{
            let time = "\(duration)"
            self.sleeperBerthhrLbl.text = "\(String(time.prefix(1))) hours"
        }
        self.dateFormate(data?.date ?? "")
    }
    private func dateFormate(_ dateString: String) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateStyle = .medium // e.g., Jul 10, 2024
            
            self.dateLbl.text = dateFormatter.string(from: date)
        } else {
            print("Invalid date format")
        }
    }
}
