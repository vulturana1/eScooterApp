//
//  MapView.swift
//  eScooter
//
//  Created by Ana Vultur on 13.04.2022.
//

import MapKit
import SwiftUI
import Combine

struct MapView: View {
    
    @StateObject var mapViewModel: MapViewModel = MapViewModel(locationManager: LocationManager())
    
    let scooters = [Scooter(id: "knsok1o3k2nrokv", number: 5, battery: 50, locked: false, booked: false, internalId: 1222, location: Location(type: "Point", coordinates: [23.6236, 46.7712]), lastSeen: "2022-04-26T06:24:07.550Z", status: "ACTIVE")]
    
    let onMenu: () -> Void
    let showScooter: (Scooter) -> Void
    var enabled: Bool = true
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapViewModel.locationManager.region, interactionModes: .all, showsUserLocation: true, annotationItems: mapViewModel.scooters) { scooter in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: scooter.location.coordinates[0], longitude: scooter.location.coordinates[1])) {
                    Image("pin-map")
                        .onTapGesture {
                            print("scooter")
                            showScooter(scooter)
                        }
                }
                
            }
            .ignoresSafeArea()
            .onAppear {
                mapViewModel.locationManager.checkIfLocationServicesIsEnabled()
            }
            VStack {
                LocationTopBar(location: self.mapViewModel.city, enabled: self.mapViewModel.locationManager.enabled) {
                    onMenu()
                }
                Spacer()
            }
        }
    }
    
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(manager: LocationManager(), onMenu: {})
//    }
//}
