//
//  MapCoordinatorViewModel.swift
//  eScooter
//
//  Created by Ana Vultur on 02.05.2022.
//

import Foundation

class MapCoordinatorViewModel: ObservableObject {
    
    @Published var currentScooter1: Scooter = Scooter(id: "1234", number: 1, battery: 0, locked: false, booked: false, internalId: 0000, location: Location(type: "Point", coordinates: [23.5, 45.1]), lastSeen: "2022-04-26T06:24:07.550Z", status: "ACTIVE", unlockCode: 0000)
    @Published var ongoingTrip: Ongoing = Ongoing(time: 10, distance: 122, price: 12.03)
    @Published var locationManager = LocationManager()
    
    @Published var detailShow = false
    @Published var unlockShow = false
    @Published var startRideShow = false
    @Published var tripDetailsShow = false
    @Published var trip: Trip?
    
    var currentScooter: ScooterCardViewModel?
    var currentUnlockScooter: SerialNumberViewModel?
    var currentTrip: TripDetailsViewModel?
    var currentUser: Customer?
    
    let defaultLocation = [47.25368173443409, 23.881470551690658]
    var currentLocation: [Double] {
        [locationManager.lastLocation?.coordinate.longitude ?? defaultLocation[0], locationManager.lastLocation?.coordinate.latitude ?? defaultLocation[1]]
    }
    
    init() {
        //self.tripDetailsShow = true
        self.getCurrentTrip()
    }
    
    func getCurrentTrip() {
        API.getCurrentTrip { response in
            switch response {
            case .success(let trip):
                self.tripDetailsShow = true
                self.trip = trip.trip
                self.getScooterById(id: trip.trip.scooterId)
                //self.selectScooter(scooter: self.currentScooter1)
                self.setTrip(trip: trip.trip)
                self.tripDetailsShow = true
            case .failure:
                self.tripDetailsShow = false
                break
            }
        }
    }
    
    func selectScooter(scooter: Scooter) {
        let viewModel = ScooterCardViewModel(scooter: scooter, location: currentLocation)
        currentScooter = viewModel
        viewModel.computeAddressIfNeeded()
        
        let unlockViewModel = SerialNumberViewModel(scooter: scooter, location: currentLocation)
        currentUnlockScooter = unlockViewModel
        
        if scooter.locked == true && scooter.booked == false {
            self.detailShow = true
            self.startRideShow = false
            self.tripDetailsShow = false
        } else if scooter.locked == false && scooter.booked == false {
            self.startRideShow = true
            self.detailShow = false
            self.tripDetailsShow = false
        }
        self.objectWillChange.send()
    }
    
    func setTrip(trip: Trip) {
        let tripViewModel = TripDetailsViewModel(scooter: currentScooter?.scooter ?? currentScooter1, trip: trip, location: currentLocation)
        self.currentTrip = tripViewModel
        self.objectWillChange.send()
    }
    
    func getScooterById(id: Int) {
        API.getScooterById(scooterId: id) { response in
            switch response {
            case .success(let scooter):
                self.currentScooter1 = scooter
                self.selectScooter(scooter: scooter)
                //self.tripDetailsShow = true
            case .failure:
                break
            }
        }
    }
}
