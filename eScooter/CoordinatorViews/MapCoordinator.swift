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
            viewModel.selectScooter(scooter: scooter)
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
        //        .onTapGesture {
        //            viewModel.current = nil
        //        }
        .overlay(handleOngoingRide())
    }
    
    @ViewBuilder
    func handleScooter() -> some View {
        if detailShow {
            if let currentScooter = viewModel.currentScooter {
                ScooterCardView(viewModel: currentScooter) {
                    self.unlockShow = true
                    self.detailShow = false
                }
            }
        }
    }
    
    @ViewBuilder
    func showUnlockTypes() -> some View {
        if unlockShow {
            if let currentScooter = viewModel.currentScooter {
                ScooterUnlockView(viewModel: currentScooter) {
                    self.unlockShow = false
                } onVerifySerialNumber: {
                    handleSerialNumberUnlock()
                } onVerifyNfc: {
                    handleNFCUnlock()
                } onVerifyQr: {
                    
                }
            }
        }
    }
    
    func handleSerialNumberUnlock() {
        if let currentUnlockScooter = viewModel.currentUnlockScooter {
            navigationViewModel.push(UnlockViewSerialNumber(viewModel: currentUnlockScooter, onClose: {
                navigationViewModel.pop()
            }, onQr: {
                
            }, onNFC: {
                handleNFCUnlock()
            }, onStartRide: {
                self.startRideShow = true
                navigationViewModel.pop()
                
            }))
        }
    }
    
    func handleNFCUnlock() {
        navigationViewModel.push(UnlockViewNFC(onClose: {
            navigationViewModel.pop()
        }, onSerial: {
            handleSerialNumberUnlock()
        }, onQr: {
            
        }))
    }
    
    @ViewBuilder
    func handleStartRide() -> some View {
        if self.startRideShow {
            if let currentScooter = viewModel.currentScooter {
                StartRideView(viewModel: currentScooter) {
                    self.startRideShow = false
                } onTripDetails: { result in
                    viewModel.setTrip(trip: result)
                    self.startRideShow = false
                    self.tripDetailsShow = true
                }
            }
        }
    }
    
    @ViewBuilder
    func handleOngoingRide() -> some View {
        if self.tripDetailsShow {
            if let currentTrip = viewModel.currentTrip {
                TripDetailsView(viewModel: currentTrip, onEndRide: { result in
                handleTripSummary(trip: result.trip)
            })
            }
        }
    }
    
    func handleTripSummary(trip: Trip) {
        navigationViewModel.push(TripSummaryView(trip: trip))
    }
}

