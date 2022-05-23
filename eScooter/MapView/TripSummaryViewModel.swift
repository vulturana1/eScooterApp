//
//  TripSummaryViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 18.05.2022.
//

import SwiftUI
import CoreLocation

class TripSummaryViewModel: ObservableObject {
    
    let trip: Trip
    let location: [Coordinates]
    @Published var placemarkStart: CLPlacemark?
    @Published var placemarkEnd: CLPlacemark?
    
    var startAddress: String? {
        guard let placemark = placemarkStart else {
            return nil
        }
        let street = placemark.thoroughfare ?? "N/A"
        let number = placemark.subThoroughfare ?? ""
        return "\(street) \(number)"
    }
    
    var endAddress: String? {
        guard let placemark = placemarkEnd else {
            return nil
        }
        let street = placemark.thoroughfare ?? "N/A"
        let number = placemark.subThoroughfare ?? ""
        return "\(street) \(number)"
    }
    
    init(trip: Trip, location: [Coordinates]) {
        self.trip = trip
        self.location = location
    }
    
    func computeAddressIfNeeded() {
        if startAddress != nil { return }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: location[0].latitude, longitude: location[0].longitude), completionHandler: { (places, error) in
            print("finished computed address")
            if error == nil {
                self.placemarkStart = places?[0]
                print("succesfully retrieved placemark")
            }
        })
        if endAddress != nil { return }
        geocoder.reverseGeocodeLocation(CLLocation(latitude: location[location.count - 1].latitude, longitude: location[location.count - 1].longitude), completionHandler: { (places, error) in
            print("finished computed address")
            if error == nil {
                self.placemarkEnd = places?[0]
                print("succesfully retrieved placemark")
            }
        })
    }
    
    func getCoordinates() -> [CLLocationCoordinate2D] {
        var coordinates: [CLLocationCoordinate2D] = []
        for index in 0..<trip.coordinatesArray.count {
            coordinates.append(CLLocationCoordinate2D(latitude: trip.coordinatesArray[index].latitude, longitude: trip.coordinatesArray[index].longitude))
        }
        return coordinates
    }
}
