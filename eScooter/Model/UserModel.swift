//
//  UserModel.swift
//  eScooter
//
//  Created by Ana Vultur on 19.04.2022.
//

import Foundation

class User: Codable {
    
    let email: String
    let username: String
    let drivingLicense: String
    let numberOfTrips: Int
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case username = "username"
        case drivingLicense = "drivingLicense"
        case numberOfTrips = "numberOfTrips"
    }
}
