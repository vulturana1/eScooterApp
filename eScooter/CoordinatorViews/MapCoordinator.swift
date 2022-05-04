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
    
    var body: some View {
        MapView(onMenu: {
            onMenu()
        }, showScooter: { scooter in
            viewModel.currentScooter = scooter
            detailShow = true
        })
        .overlay(handleScooter(show: detailShow))
        .overlay(showUnlockTypes(scooter: viewModel.currentScooter ?? Scooter(id: "knsok1o3k2nrokv", number: 5, battery: 50, locked: false, booked: false, internalId: 1222, location: Location(type: "Point", coordinates: [23.5, 45.1]), lastSeen: "2022-04-26T06:24:07.550Z", status: "ACTIVE"), unlockShow: unlockShow))
    }
    
    func handleScooter(show: Bool) -> AnyView {
        if detailShow {
            return AnyView(ScooterCardView(scooter: viewModel.currentScooter ?? Scooter(id: "knsok1o3k2nrokv", number: 5, battery: 50, locked: false, booked: false, internalId: 1222, location: Location(type: "Point", coordinates: [23.5, 45.1]), lastSeen: "2022-04-26T06:24:07.550Z", status: "ACTIVE"), currentLocation: [viewModel.locationManager.lastLocation?.coordinate.longitude ?? 47.25368173443409, viewModel.locationManager.lastLocation?.coordinate.latitude ?? 23.881470551690658] , onRing: {}, onUnlock: {
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
                ScooterUnlockView(scooter: scooter, currentLocation: [23.5, 45.1], onRing: {
        
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
        navigationViewModel.push(UnlockViewSerialNumber(onClose: {
            navigationViewModel.pop()
        }, onQr: {
            
        }, onNFC: {
            handleNFCUnlock()
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

