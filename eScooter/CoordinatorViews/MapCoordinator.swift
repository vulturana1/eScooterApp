//
//  MapCoordinator.swift
//  eScooter
//
//  Created by Ana Vultur on 16.04.2022.
//

import SwiftUI
import NavigationStack

struct MapCoordinator: View {
    let navigationViewModel: NavigationStack
    let onMenu: () -> Void
    @State var detailShow = false
    @State var unlockShow = false
    @State var startRideShow = false
    @State var tripDetailsShow = false
    @State var loading = false
    @StateObject var viewModel = MapCoordinatorViewModel()
    let defaultLocation = [47.25368173443409, 23.881470551690658]
    
    var body: some View {
        MapView(onMenu: {
            onMenu()
        }, showScooter: { scooter in
            viewModel.currentScooter = scooter
            detailShow = true
            if scooter.locked == false {
                startRideShow = true
                detailShow = false
                tripDetailsShow = false
            }
            if scooter.booked == true {
                startRideShow = false
                detailShow = false
                tripDetailsShow = true
            }
            
        })
        .overlay(handleScooter())
        .overlay(showUnlockTypes())
        .overlay(handleStartRide())
        .onTapGesture {
            detailShow = false
        }
        .overlay(handleOngoingRide())
    }
    
    func handleScooter() -> AnyView {
        if detailShow {
            return AnyView(ScooterCardView(scooter: viewModel.currentScooter, currentLocation: [viewModel.locationManager.lastLocation?.coordinate.longitude ?? defaultLocation[0], viewModel.locationManager.lastLocation?.coordinate.latitude ?? defaultLocation[1]] , onRing: {
                
            }, onUnlock: {
                self.unlockShow = true
                self.detailShow = false
            }, onLocation: {}))
        } else {
            return AnyView(EmptyView())
        }
    }
    
    func showUnlockTypes() -> AnyView {
        if unlockShow {
            return AnyView(
                ScooterUnlockView(scooter: viewModel.currentScooter, currentLocation: [viewModel.locationManager.lastLocation?.coordinate.longitude ?? defaultLocation[0], viewModel.locationManager.lastLocation?.coordinate.latitude ?? defaultLocation[1]], dragDown: {
                    self.unlockShow = false
                }, onVerifySerialNumber: {
                    handleSerialNumberUnlock()
                }, onVerifyNfc: {
                    handleNFCUnlock()
                }, onVerifyQr: {
    
                }))
        } else {
            return AnyView(EmptyView())
        }
    }
    
    func handleSerialNumberUnlock() {
        loading = true
        navigationViewModel.push(UnlockViewSerialNumber(scooter: viewModel.currentScooter, currentLocation: [viewModel.locationManager.lastLocation?.coordinate.longitude ?? defaultLocation[0], viewModel.locationManager.lastLocation?.coordinate.latitude ?? defaultLocation[1]], onClose: {
            navigationViewModel.pop()
        }, onQr: {
            
        }, onNFC: {
            handleNFCUnlock()
        }, onStartRide: {
            self.startRideShow = true
            navigationViewModel.pop()
            
        }))
    }
    
    func handleNFCUnlock() {
        navigationViewModel.push(UnlockViewNFC(onClose: {
            navigationViewModel.pop()
        }, onSerial: {
            handleSerialNumberUnlock()
        }, onQr: {
            
        }))
    }
    
    func handleStartRide() -> AnyView {
        if self.startRideShow {
            return AnyView(StartRideView(scooter: viewModel.currentScooter, currentLocation: [viewModel.locationManager.lastLocation?.coordinate.longitude ?? defaultLocation[0], viewModel.locationManager.lastLocation?.coordinate.latitude ?? defaultLocation[1]], dragDown: {
                self.startRideShow = false
            }, onTripDetails: {
                self.startRideShow = false
                self.tripDetailsShow = true
            }))
        } else {
            return AnyView(EmptyView())
        }
    }
    
    func handleOngoingRide() -> AnyView {
        if self.tripDetailsShow {
            return AnyView(TripDetailsView(scooter: viewModel.currentScooter, trip: viewModel.ongoingTrip, currentLocation: [viewModel.locationManager.lastLocation?.coordinate.longitude ?? defaultLocation[0], viewModel.locationManager.lastLocation?.coordinate.latitude ?? defaultLocation[1]], onEndRide: {
                handleTripSummary()
            }))
        } else {
            return AnyView(EmptyView())
        }
    }
    
    func handleTripSummary() {
        navigationViewModel.push(TripSummaryView())
    }
}

