//
//  MapCoordinatorViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 02.05.2022.
//

import Foundation

class MapCoordinatorViewModel: ObservableObject {
    
    @Published var currentScooter1: Scooter = Scooter(id: "knsok1o3k2nrokv", number: 1, battery: 0, locked: false, booked: false, internalId: 0000, location: Location(type: "Point", coordinates: [23.5, 45.1]), lastSeen: "2022-04-26T06:24:07.550Z", status: "ACTIVE", unlockCode: 0000)
    @Published var currentTrip1: Trip = Trip(id: "lsjfno12423", scooterId: 0000, coordinatesArray: [Coordinates(latitude: 47.8, longitude: 27.3, id: "dkfjnvef223")], totalTime: 10, distance: 10, cost: 10)
    
    @Published var ongoingTrip: Ongoing = Ongoing(time: 10, distance: 122, price: 12.03)
    @Published var locationManager = LocationManager()
    
    var currentScooter: ScooterCardViewModel?
    var currentUnlockScooter: SerialNumberViewModel?
    var currentTrip: TripDetailsViewModel?
    
    let defaultLocation = [47.25368173443409, 23.881470551690658]
    var currentLocation: [Double] {
        [locationManager.lastLocation?.coordinate.longitude ?? defaultLocation[0], locationManager.lastLocation?.coordinate.latitude ?? defaultLocation[1]]
    }
    
    func selectScooter(scooter: Scooter) {
        let viewModel = ScooterCardViewModel(scooter: scooter, location: currentLocation)
        currentScooter = viewModel
        viewModel.computeAddressIfNeeded()
        
        let unlockViewModel = SerialNumberViewModel(scooter: scooter, location: currentLocation)
        currentUnlockScooter = unlockViewModel
        
        self.objectWillChange.send()
    }
    
    func setTrip(trip: Ongoing) {
        let tripViewModel = TripDetailsViewModel(scooter: currentScooter?.scooter ?? currentScooter1, trip: trip, location: currentLocation)
        currentTrip = tripViewModel
    }
    
//    func getScooterById(id: String) {
//        API.getScooterById(scooterId: id, { result in
//            switch result {
//            case .success(let scooter):
//                self.currentScooter = scooter
//                break
//            case .failure(let error):
//                showError(error: error)
//                break
//            }
//        })
//    }
    
    func getOngoingTrip(internalId: Int, coordX: Double, coordY: Double) {
        API.getOngoingTrip(internalId: internalId, coordX: coordX, coordY: coordY) { result in
            switch result {
            case .success(let ongoingTrip):
                self.ongoingTrip = ongoingTrip
                break
            case .failure(let error):
                showError(error: error)
                break
            }
        }
    }
}
