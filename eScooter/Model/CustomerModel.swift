//
//  Customer.swift
//  eScooter
//
//  Created by Ana Vultur on 18.04.2022.
//

import Foundation

struct Customer: Codable {
    
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

struct CustomerData: Codable {
    
    var customer: Customer
    
    enum CodingKeys: String, CodingKey {
        case customer = "customer"
    }
}

    
