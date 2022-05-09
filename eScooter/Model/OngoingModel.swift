//
//  OngoingModel.swift
//  eScooter
//
//  Created by Ana Vultur on 08.05.2022.
//

import Foundation

struct Ongoing: Codable {
    let time: Double
    let distance: Double
    let price: Double
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case distance = "distance"
        case price = "price"
    }
}
