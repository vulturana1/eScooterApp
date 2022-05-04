//
//  MapCoordinatorViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 02.05.2022.
//

import Foundation

class MapCoordinatorViewModel: ObservableObject {
    
    @Published var currentScooter: Scooter?
    @Published var locationManager = LocationManager()
    
    func getScooterById(id: String) {
        API.getScooterById(scooterId: id, { result in
            switch result {
            case .success(let scooter):
                self.currentScooter = scooter
                break
            case .failure:
                break
            }
        })
    }
    
    func lockScooter() {

    }
    
}
