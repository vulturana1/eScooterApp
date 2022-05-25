//
//  MapViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 20.04.2022.
//

import Foundation
import CoreLocation
import Combine
import MapKit

class MapViewModel: ObservableObject {
    
    @Published var locationManager = LocationManager.shared
    @Published var city: String = ""
    var currentLocation: CLLocationCoordinate2D?
    var disposeBag: [AnyCancellable] = []
    var scooters: [Scooter] = []
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 46.7712, longitude: 23.6236),
                                               latitudinalMeters: CLLocationDistance.init(400),
                                               longitudinalMeters: CLLocationDistance.init(400))
    var regionDebounce: AnyCancellable?
    
    init() {
        regionDebounce = $region.debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink(receiveValue: { region in
                self.getCityName(location: CLLocation(latitude: region.center.latitude, longitude: region.center.longitude))
            })
        
        self.currentLocation = self.locationManager.lastLocation?.coordinate
        self.loadData()
    }
    
    func centerRegion() {
        if currentLocation == nil {
            currentLocation = locationManager.lastLocation?.coordinate
        }
        guard let currentLocation = currentLocation else { return }
        region.center = currentLocation
    }
    
    func getCityName(location: CLLocation) {
        if locationManager.enabled == false {
            self.city = "Allow location"
        } else {
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                guard let placemark = placemarks?.last else { return }
                if let cityName = placemark.locality {
                    self.city = cityName
                }
            })
            print(self.city)
        }
    }
    
    func getScooters()  {
        API.getScooters { result in
            switch result {
            case .success(let scooters):
                self.scooters = scooters
            case .failure:
                break
            }
        }
    }
    
    func getScootersWithin4km()  {
        if let location = locationManager.lastLocation {
            API.getScootersWithin4km(latitude: location.coordinate.latitude, longitude: location.coordinate.latitude) { result in
                switch result {
                case .success(let scooters):
                    self.scooters = scooters
                case .failure:
                    break
                }
            }
        }
    }
    
    func scootersResult() -> [Scooter] {
        getScooters()
        return self.scooters
    }
    
    func loadData() {
        self.getScooters()
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.loadData()
        }
    }
}

