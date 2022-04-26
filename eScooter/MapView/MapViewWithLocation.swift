//
//  MapViewWithLocation.swift
//  eScooter
//
//  Created by Ana Vultur on 13.04.2022.
//

import MapKit
import SwiftUI

struct MapViewWithLocation: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.6, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    @ObservedObject var manager = LocationManager()
    @State var scooters: String = ""
    
    let onMenu: () -> Void
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $manager.region, showsUserLocation: true)
        
//        annotationItems: scooters) { scooter in
//                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: scooter.location.coordinates[1], longitude: scooter.location.coordinates[0])) {
//                    Image("pin-map")
//                        .onTapGesture {
//                            onShowScooters([scooter])
//                        }
//                }
//            }
            .ignoresSafeArea()
            //                .onAppear {
            //                    manager.checkIfLocationServicesIsEnabled()
            //                }
            VStack {
                LocationTopBar(location: manager.city, enabled: true) {
                    onMenu()
                }
                Spacer()
            }
        }
    }
    
    private func setCurrentLocation() {
        if let loc = manager.location {
            mapRegion = MKCoordinateRegion(center: loc.coordinate , latitudinalMeters: 200, longitudinalMeters: 200)
        }
    }
    
}

struct MapViewWithLocation_Previews: PreviewProvider {
    static var previews: some View {
        MapViewWithLocation(onMenu: {})
    }
}
