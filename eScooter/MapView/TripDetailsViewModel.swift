//
//  TripDetailsViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 06.05.2022.
//

import SwiftUI
import CoreLocation

class TripDetailsViewModel: ObservableObject {
    
    let scooter: Scooter
    let trip: Ongoing
    let location: [Double]
    //var tripCompleted: Trip?
    
    init(scooter: Scooter, trip: Ongoing, location: [Double]) {
        self.scooter = scooter
        self.trip = trip
        self.location = location
    }
    
    func endRide(_ callback: @escaping (Result<TripResponse>) -> Void) {
        API.endRide(internalId: scooter.internalId, coordX: location[1], coordY: location[0]) { result in
            switch result {
            case .success(let response):
                //self.tripCompleted = response.trip
                showSuccess(message: response.message)
                break
            case .failure(let error):
                showError(error: error)
                break
            }
            callback(result)
        }
    }
    
    func lockScooter() {
        API.lockScooter(internalId: scooter.internalId, coordX: location[1], coordY: location[0]) { result in
            switch result {
            case .success(let response):
                showSuccess(message: response.message)
                break
            case .failure(let error):
                showError(error: error)
                break
            }
        }
    }
    
    func unlockScooter() {
        API.unlockScooterSerialNumber(internalId: scooter.internalId, coordX: location[1], coordY: location[0], unlockCode: scooter.unlockCode) { result in
            switch result {
            case .success(let response):
                showSuccess(message: response.message)
                break
            case .failure(let error):
                showError(error: error)
                break
            }
        }
    }

}
