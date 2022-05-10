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
    
    func startRide(_ callback: @escaping (Result<Ongoing>) -> Void) {
        API.startRide(internalId: scooter.internalId, coordX: location[1], coordY: location[0]) { result in
            switch result {
            case .success(let message):
                showSuccess(message: message.message)
                API.getOngoingTrip(internalId: self.scooter.internalId, coordX: self.location[1], coordY: self.location[0]) { result in
                    callback(result)
                }
                break
            case .failure(let error):
                showError(error: error)
                break
            }
            
        }
    }
    
    //    func startRide() {
    //        API.startRide(internalId: scooter.internalId, coordX: location[1], coordY: location[0]) { result in
    //            switch result {
    //            case .success(let message):
    //                showSuccess(message: message.message)
    //                break
    //            case .failure(let error):
    //                showError(error: error)
    //                break
    //            }
    //        }
    //    }
    
    func computeAddressIfNeeded() {
        print("compute address for scooter" + scooter.id)
        if address != nil { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: scooter.location.coordinates[0], longitude: scooter.location.coordinates[1]), completionHandler: { (places, error) in
            print("finished computed address")
            if error == nil {
                self.placemark = places?[0]
                print("succesfully retrieved placemark")
            }
            if let error = error {
                print(error.localizedDescription)
            }
        })
    }
    
}
