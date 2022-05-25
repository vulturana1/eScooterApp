//
//  ScooterCardViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 03.05.2022.
//

import Foundation
import CoreLocation

class ScooterCardViewModel: ObservableObject {
    
    let scooter: Scooter
    let location: [Double]
    @Published var placemark: CLPlacemark?
    
    var address: String? {
        guard let placemark = placemark else {
            return nil
        }
        let street = placemark.thoroughfare ?? "N/A"
        let number = placemark.subThoroughfare ?? ""
        return "\(street) \(number)"
    }
    
    init(scooter: Scooter, location: [Double]) {
        self.scooter = scooter
        self.location = location
    }
    
    func pingScooter(success callbackSuccess: @escaping () -> Void, failure callbackFailure: @escaping () -> Void) {
        API.pingScooter(scooterInternalId: scooter.internalId, coordX: location[0], coordY: location[1]) { result in
            switch result {
            case .success(let message):
                showSuccess(message: message.message)
                callbackSuccess()
                break
            case .failure(let error):
                showError(error: error)
                callbackFailure()
                break
            }
        }
    }
    
    func checkDistance() -> Double {
        // Haversine formula
        let R: Double = 6371 // Radius of the earth in km
        let dLat = deg2rad(scooter.location.coordinates[1] - location[0])
        let dLon = deg2rad(scooter.location.coordinates[0] - location[1])
        let a = sin(dLat/2) * sin(dLat/2) + cos(deg2rad(location[0])) * cos(deg2rad(scooter.location.coordinates[1])) * sin(dLon/2) * sin(dLon/2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        let d = R * c  //in km
        return d
    }
    
    func deg2rad(_ number: Double) -> Double {
        return number * .pi / 180
    }
    
    func startRide(_ callback: @escaping (Trip) -> Void) {
        API.startRide(internalId: scooter.internalId, coordX: location[0], coordY: location[1]) { result in
            switch result {
            case .success(let ride):
                callback(ride.trip)
                break
            case .failure(let error):
                showError(error: error)
                break
            }
        }
    }
    
    func computeAddressIfNeeded() {
        if address != nil { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: scooter.location.coordinates[1], longitude: scooter.location.coordinates[0]), completionHandler: { (places, error) in
            if error == nil {
                self.placemark = places?[0]
            }
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    
}
