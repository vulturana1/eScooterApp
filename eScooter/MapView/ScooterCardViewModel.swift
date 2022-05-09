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
    var address: String = ""
    
    init(scooter: Scooter, location: [Double]) {
        self.scooter = scooter
        self.location = location
        lookUpCurrentLocation()
    }
    
    func pingScooter() {
        API.pingScooter(scooterInternalId: scooter.internalId, coordX: location[1], coordY: location[0]) { result in
            switch result {
            case .success(let message):
                showSuccess(message: message.message)
                break
            case .failure(let error):
                showError(error: error)
                break
            }
        }
    }
    
    func startRide() {
        API.startRide(internalId: scooter.internalId, coordX: location[1], coordY: location[0]) { result in
            switch result {
            case .success(let message):
                showSuccess(message: message.message)
                break
            case .failure(let error):
                showError(error: error)
                break
            }
        }
    }
    
    func lookUpCurrentLocation() {
        // Use the last reported location.
        let lastLocation = scooter.location
        let geocoder = CLGeocoder()
        // Look up the location
        geocoder.reverseGeocodeLocation(CLLocation(latitude: lastLocation.coordinates[0], longitude: lastLocation.coordinates[1]),
                                        completionHandler: { (placemarks, error) in
            guard let placemark = placemarks?.last else {
                return
            }
            if let street = placemark.thoroughfare {
                self.address = street
            }
            if let number = placemark.subThoroughfare {
                self.address  += ", \(number)"
            }
            print(self.address)
        })
    }

}
