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
    
    @StateObject var viewModel = MapCoordinatorViewModel()
    
    var body: some View {
        MapView(onMenu: {
            onMenu()
        }, showScooter: { scooter in
            viewModel.selectScooter(scooter: scooter)
        })
        .overlay(handleScooter())
        .overlay(showUnlockTypes())
        .overlay(handleStartRide())
        .overlay(handleOngoingRide())
//        .onTapGesture {
//            self.viewModel.detailShow = false
//        }
        .onAppear {
            viewModel.getCurrentTrip()
        }
    }
    
    @ViewBuilder
    func handleScooter() -> some View {
        if viewModel.detailShow {
            if let currentScooter = viewModel.currentScooter {
                ScooterCardView(viewModel: currentScooter) {
                    viewModel.unlockShow = true
                    viewModel.detailShow = false
                } onClose: {
                    viewModel.detailShow = false
                }
            }
        }
    }
    
    @ViewBuilder
    func showUnlockTypes() -> some View {
        if viewModel.unlockShow {
            if let currentScooter = viewModel.currentScooter {
                ScooterUnlockView(viewModel: currentScooter) {
                    viewModel.unlockShow = false
                } onVerifySerialNumber: {
                    handleSerialNumberUnlock()
                } onVerifyNfc: {
                    handleNFCUnlock()
                } onVerifyQr: {
                    handleQRUnlock()
                }
            }
        }
    }
    
    func handleSerialNumberUnlock() {
        if let currentUnlockScooter = viewModel.currentUnlockScooter {
            navigationViewModel.push(UnlockViewSerialNumber(viewModel: currentUnlockScooter, onClose: {
                navigationViewModel.pop(to: .view(withId: "map"))
            }, onQr: {
                handleQRUnlock()
            }, onNFC: {
                handleNFCUnlock()
            }, onStartRide: {
                navigationViewModel.push(ValidCodeView())
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    viewModel.startRideShow = true
                    navigationViewModel.pop(to: .view(withId: "map"))
                }
            }))
        }
    }
    
    func handleQRUnlock() {
        if let currentUnlockScooter = viewModel.currentUnlockScooter {
            navigationViewModel.push(UnlockViewQr(viewModel: currentUnlockScooter, onClose: {
                navigationViewModel.pop(to: .view(withId: "map"))
            }, onSerial: {
                handleSerialNumberUnlock()
            }, onNfc: {
                handleNFCUnlock()
            }, onStartRide: {
                navigationViewModel.push(ValidCodeView())
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    viewModel.startRideShow = true
                    navigationViewModel.pop(to: .view(withId: "map"))
                }
            }))
        }
    }
    
    func handleNFCUnlock() {
        navigationViewModel.push(UnlockViewNFC(onClose: {
            navigationViewModel.pop(to: .view(withId: "map"))
        }, onSerial: {
            handleSerialNumberUnlock()
        }, onQr: {
            handleQRUnlock()
        }))
    }
    
    @ViewBuilder
    func handleStartRide() -> some View {
        if viewModel.startRideShow {
            if let currentScooter = viewModel.currentScooter {
                StartRideView(viewModel: currentScooter) {
                    viewModel.startRideShow = false
                } onTripDetails: { result in
                    //viewModel.getCurrentTrip()
                    viewModel.setTrip(trip: result)
                    viewModel.startRideShow = false
                    viewModel.tripDetailsShow = true
                }
            }
        }
    }
    
    @ViewBuilder
    func handleOngoingRide() -> some View {
        if viewModel.tripDetailsShow {
            if let currentTrip = viewModel.currentTrip {
                TripDetailsView(viewModel: currentTrip, onEndRide: { result in
                    handleTripSummary(trip: result.trip)
                })
            }
        }
    }
    
    func handleTripSummary(trip: Trip) {
        navigationViewModel.push(TripSummaryView(onNext: {
            navigationViewModel.pop(to: .view(withId: "map"))
        }, trip: trip))
    }
}

