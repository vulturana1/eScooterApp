//
//  HistoryModel.swift
//  eScooter
//
//  Created by Ana Vultur on 11.05.2022.
//

import Foundation

struct HistoryTrip: Codable {
    let id: String
    let coordinatesArray: [Coordinates]
    let totalTime: Int
    let distance: Double
    let cost: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case coordinatesArray = "coordinatesArray"
        case distance = "distance"
        case totalTime = "totalTime"
        case cost = "cost"
    }
}

class AllTripsHistory: Codable {
    let trips: [HistoryTrip]
    
    enum CodingKeys: String, CodingKey {
        case trips = "trips"
    }
}
