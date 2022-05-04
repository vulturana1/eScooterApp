//
//  ScooterModel.swift
//  eScooter
//
//  Created by Ana Vultur on 26.04.2022.
//

import Foundation

struct Location: Codable {
    let type: String
    let coordinates: [Double]
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case coordinates = "coordinates"
    }
}

struct Scooter: Codable, Identifiable {
    let id: String
    let number: Int
    let battery: Int
    let locked: Bool
    let booked: Bool
    let internalId: Int
    let location: Location
    let lastSeen: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case number = "number"
        case battery = "battery"
        case locked = "locked"
        case booked = "booked"
        case internalId = "internalId"
        case location = "location"
        case lastSeen = "lastSeen"
        case status = "status"
    }
}
