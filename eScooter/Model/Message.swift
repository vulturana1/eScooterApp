//
//  Message.swift
//  eScooter
//
//  Created by Ana Vultur on 18.04.2022.
//

import Foundation

class Message: Codable {
    var message: String
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}
