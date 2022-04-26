//
//  AuthenticationModel.swift
//  eScooter
//
//  Created by Ana Vultur on 18.04.2022.
//

import Foundation

struct Authentication: Decodable {
    var token: String
    var customer: Customer
}

struct Password: Decodable {
    let success: Bool
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
    }
}
