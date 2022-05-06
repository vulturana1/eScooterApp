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
    
    @Published var locationManager: LocationManager
    @Published var city: String = ""
    var disposeBag: [AnyCancellable] = []
    var currentLocation: CLLocationCoordinate2D?
    var scooters: [Scooter] = []
    
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        
        locationManager.objectWillChange.sink { [weak self] in
            guard let self = self else {
                return
            }
            //self.locationManager.objectWillChange.send()
            
            self.currentLocation = self.locationManager.lastLocation?.coordinate
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if let lastLocation = self.locationManager.lastLocation {
                    self.locationManager.getCityName(location: lastLocation)
                    self.city = self.locationManager.city
                }
//            }
            
        }.store(in: &disposeBag)
                
        self.loadData()
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
    
    func scootersResult() -> [Scooter] {
        getScooters()
        return self.scooters
    }
    
    func loadData() {
        self.getScooters()
        DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
            self.loadData()
        }
    }
    
}

