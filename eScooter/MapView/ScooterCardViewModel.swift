//
//  ScooterCardViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 03.05.2022.
//

import Foundation

class ScooterCardViewModel: ObservableObject {
    
    let scooter: Scooter
    let location: [Double]
    
    init(scooter: Scooter, location: [Double]) {
        self.scooter = scooter
        self.location = location
    }
    
    func pingScooter() {
        API.pingScooter(scooterInternalId: scooter.internalId, coordX: location[1], coordY: location[0]) { result in
            switch result {
            case .success(let message):
                showSuccess(message: message.message)
                break
            case .failure(let error):
                showError(error: error.localizedDescription)
                break
            }
        }
    }

}
