//
//  TripModel.swift
//  eScooter
//
//  Created by Ana Vultur on 28.04.2022.
//

import Foundation
import CoreLocation

struct Trip: Codable {
    let id: String
//    let username: String
//    let scooterId: Int
    let coordinatesArray: [Coordinates]
    let totalTime: Int
    let distance: Int
    let cost: Double
//    let status: String
//    let startTime: String
//    let endTime: String
//    let v: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
//        case username = "username"
//        case scooterId = "scooterId"
        case coordinatesArray = "coordinatesArray"
        case distance = "distance"
        case totalTime = "totalTime"
        case cost = "cost"
//        case status = "status"
//        case startTime = "startTime"
//        case endTime = "endTime"
//        case v = "__v"
    }
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
        case id = "_id"
    }
}

class AllTrips: Codable {
    let trips: [Trip]
    
    enum CodingKeys: String, CodingKey {
        case trips = "trips"
    }
}
