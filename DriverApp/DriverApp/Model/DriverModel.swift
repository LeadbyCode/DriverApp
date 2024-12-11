//
//  DriverModel.swift
//  DriverApp
//
//  Created by Nilesh Vernekar on 10/12/24.
//

import Foundation

// MARK: - Driver
struct DriverModel: Codable {
    let driverID: String?
    var logs: [Log]

    enum CodingKeys: String, CodingKey {
        case driverID = "driverId"
        case logs
    }
}

// MARK: - Log
struct Log: Codable {
    var date: String
    var entries: [Entry]?
    var DrivingTimeInHours: Double {
        entries?.filter { $0.status == "DRIVING" }
            .reduce(0) { $0 + $1.durationInHours } ?? 0
    }
    var offDutyTimeInHours: Double {
        entries?.filter { $0.status == "OFF_DUTY" }
               .reduce(0) { $0 + $1.durationInHours } ?? 0
    }
    var onDutyNotDrivingTimeInHours: Double {
        entries?.filter { $0.status == "ON_DUTY_NOT_DRIVING" }
            .reduce(0) { $0 + $1.durationInHours } ?? 0
    }
    var sleeperBerthTimeInHours: Double {
        entries?.filter { $0.status == "SLEEPER_BERTH" }
               .reduce(0) { $0 + $1.durationInHours } ?? 0
    }
}

// MARK: - Entry
struct Entry: Codable {
    var startTime, endTime: Date?
    var status: String?
    var location: String?
    var durationInHours: Double {
        let interval = endTime?.timeIntervalSince(startTime ?? Date()) ?? 0
          return interval / 3600
      }
}

enum Status: String, Codable {
    case driving = "DRIVING"
    case offDuty = "OFF_DUTY"
    case onDutyNotDriving = "ON_DUTY_NOT_DRIVING"
    case sleeperBerth = "SLEEPER_BERTH"
}
