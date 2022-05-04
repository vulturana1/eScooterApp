//
//  ScooterUnlockViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 03.05.2022.
//

import Foundation

class ScooterUnlockViewModel: ObservableObject {
    
    let scooter: Scooter
    let location: [Double]
    
    init(scooter: Scooter, location: [Double]) {
        self.scooter = scooter
        self.location = location
    }
    
    func pingScooter() {
        
    }

}
