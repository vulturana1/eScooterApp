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
    let location: [Double]
    @Published var trip: Ongoing
    
    init(scooter: Scooter, trip: Ongoing, location: [Double]) {
        self.scooter = scooter
        self.trip = trip
        self.location = location
        self.loadData()
    }
    
    func endRide(_ callback: @escaping (Result<TripResponse>) -> Void) {
        API.endRide(internalId: scooter.internalId, coordX: location[0], coordY: location[1]) { result in
            switch result {
            case .success(let response):
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
        API.lockScooter(internalId: scooter.internalId, coordX: location[0], coordY: location[1]) { result in
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
        API.unlockScooterSerialNumber(internalId: scooter.internalId, coordX: location[0], coordY: location[1], unlockCode: scooter.unlockCode) { result in
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
    
    func getOngoingTrip() {
        // TODO: sa nu se mai apeleze dupa end ride
        print("ONGOING TRIP")
        API.getOngoingTrip(internalId: scooter.internalId, coordX: location[0], coordY: location[1]) { result in
            switch result {
            case .success(let ongoingTrip):
                self.trip = ongoingTrip
                break
            case .failure(_):
                break
            }
        }
    }
    
    func loadData() {
        self.getOngoingTrip()
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.loadData()
        }
    }
}
