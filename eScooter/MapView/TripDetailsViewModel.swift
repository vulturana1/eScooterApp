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
    @Published var trip: Trip
    //@Published var time = 0
    var time: Int {
        get {
            UserDefaults.standard.integer(forKey: "time")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "time")
            objectWillChange.send()
        }
    }
    
    var ended = false
    
    init(scooter: Scooter, trip: Trip, location: [Double]) {
        self.scooter = scooter
        self.trip = trip
        self.location = location
        
        self.loadData()
    }
    
    func endRide(_ callback: @escaping (Result<TripResponse>) -> Void) {
        self.ended = true
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
        self.time = 0
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
        API.unlockScooterSerialNumber(internalId: scooter.internalId, coordX: location[0], coordY: location[1], unlockCode: scooter.unlockCode, qrCode: false) { result in
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
//        API.getOngoingTrip(internalId: scooter.internalId) { result in
//            switch result {
//            case .success(let ongoingTrip):
//                self.trip = ongoingTrip
//                self.ended = false
//                break
//            case .failure(_):
//                self.ended = true
//                break
//            }
//        }
        
        API.getCurrentTrip { response in
            switch response {
            case .success(let trip):
                self.trip = trip.trip
                self.ended = false
            case .failure:
                self.ended = true
                break
            }
        }
    }
    
    func loadData() {
        self.getOngoingTrip()
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            if !self.ended {
                self.loadData()
            }
        }
    }
}
