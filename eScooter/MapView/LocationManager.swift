//
//  LocationManager.swift
//  eScooter
//
//  Created by Ana Vultur on 13.04.2022.
//

import UIKit
import MapKit
import CoreLocation
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 46.7712, longitude: 23.6236), latitudinalMeters: CLLocationDistance.init(4000), longitudinalMeters: CLLocationDistance.init(4000))
    
    var manager = CLLocationManager()
    @Published var city: String
    @Published var lastLocation: CLLocation?
    @Published var enabled: Bool
    private var geoCoder = CLGeocoder()
    
    override init() {
        self.city = "Cluj-Napoca"
        self.enabled = false
        super.init()
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.distanceFilter = kCLDistanceFilterNone
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
        self.manager.delegate = self
        self.checkLocationAuthotization()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.setCurrentLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
        self.getCityName(location: location)
        //print(self.lastLocation?.coordinate)
        //print(self.city)
    }
    
    func getCityName(location: CLLocation){
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            guard let placemark = placemarks?.last else { return }
            if let cityName = placemark.locality {
                self.city = cityName
            }
        })
    }
    
    func checkIfLocationServicesIsEnabled(){
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
        }
        else {
            showError(error: APIError(message: "Turn on your location"))
        }
    }
    
    func checkLocationAuthotization() {
        switch manager.authorizationStatus {
        case .notDetermined:
            enabled = false
            manager.requestWhenInUseAuthorization()
        case .restricted:
            showError(error: APIError(message: "Your location is restricted likely due to parental controls."))
            enabled = false
        case .denied:
            enabled = false
            self.city = "Allow location"
            showError(error: APIError(message: "You have denied this app location permission. Go into settings to change it."))
        case .authorizedAlways, .authorizedWhenInUse:
            guard let location = manager.location else { return }
            getCityName(location: location)
            enabled = true
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthotization()
    }
    
    func setCurrentLocation() {
        if let location = self.lastLocation {
            self.region = MKCoordinateRegion(center: location.coordinate , latitudinalMeters: 400, longitudinalMeters: 400)
        }
    }
    
    
}
