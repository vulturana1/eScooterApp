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
    @StateObject var viewModel = MapCoordinatorViewModel()
    let defaultLocation = [47.25368173443409, 23.881470551690658]
    
    var body: some View {
        MapView(onMenu: {
            onMenu()
        }, showScooter: { scooter in
            viewModel.currentScooter = scooter
            detailShow = true
        })
        .overlay(handleScooter(show: detailShow))
        .overlay(showUnlockTypes(scooter: viewModel.currentScooter, unlockShow: unlockShow))
    }
    
    func handleScooter(show: Bool) -> AnyView {
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
    
    func showUnlockTypes(scooter: Scooter, unlockShow: Bool) -> AnyView {
        if unlockShow {
            return AnyView(
                ScooterUnlockView(scooter: scooter, currentLocation: [viewModel.locationManager.lastLocation?.coordinate.longitude ?? defaultLocation[0], viewModel.locationManager.lastLocation?.coordinate.latitude ?? defaultLocation[1]], onRing: {
                    
                }, dragDown: {
                    
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
        navigationViewModel.push(UnlockViewSerialNumber(scooter: viewModel.currentScooter, currentLocation: [viewModel.locationManager.lastLocation?.coordinate.longitude ?? defaultLocation[0], viewModel.locationManager.lastLocation?.coordinate.latitude ?? defaultLocation[1]], onClose: {
            navigationViewModel.pop()
        }, onQr: {
            
        }, onNFC: {
            handleNFCUnlock()
        }, onStartRide: {
            
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
    
}

