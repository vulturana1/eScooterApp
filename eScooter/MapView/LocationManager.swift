//
//  LocationManager.swift
//  eScooter
//
//  Created by Ana Vultur on 13.04.2022.
//

import UIKit
import MapKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var region = MKCoordinateRegion()
    @Published var manager = CLLocationManager()
    private var geoCoder = CLGeocoder()
    @Published var city: String
    @Published var location: CLLocation?
    
    override init() {
        self.city = "Cluj-Napoca"
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        if let location = manager.location {
            self.getCityName(location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            let center = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            region = MKCoordinateRegion(center: center, span: span)
        }
    }
    
    func getCityName(location: CLLocation){
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in
            placemarks?.forEach { (placemark) in
                if let city = placemark.locality {
                    print(city)
                    self.city = city
                }
            }
        })
    }
    
    func checkIfLocationServicesIsEnabled() {
        //daca locatia iphone-ului este enable
        if CLLocationManager.locationServicesEnabled() {
            manager = CLLocationManager()
            manager.delegate = self
        }
        else {
            showError(error: "Turn on your location")
        }
    }
    
    func checkLocationAuthotization() {
        //pt permisia aplicatiei
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            showError(error: "Your location is restricted likely due to parental controls.")
        case .denied:
            showError(error: "You have denied this app location permission. Go into settings to change it.")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthotization()
    }
    
    
}
