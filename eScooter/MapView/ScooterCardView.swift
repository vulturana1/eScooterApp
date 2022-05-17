//
//  ScooterCardView.swift
//  eScooter
//
//  Created by Ana Vultur on 22.04.2022.
//

import SwiftUI
import CoreLocation
import MapKit

struct ScooterCardView: View {
    
    @ObservedObject var viewModel: ScooterCardViewModel
    let onUnlock: () -> Void
    
    init(viewModel: ScooterCardViewModel, onUnlock: @escaping () -> Void) {
        self.viewModel = viewModel
        self.onUnlock = onUnlock
    }
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Image("scooter-background")
                VStack {
                    HStack {
                        Image("scooter")
                        details
                    }
                    location
                    unlockButton
                        .scaledToFit()
                }
            }
        }
        .padding()
    }
    
    var details: some View {
        VStack(alignment: .trailing) {
            Text("Scooter")
                .font(.custom("BaiJamjuree-Medium", size: 14))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                .opacity(0.7)
            Text("#" + "\(viewModel.scooter.internalId)")
                .font(.custom("BaiJamjuree-Bold", size: 20))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            BatteryView(batteryLevel: viewModel.scooter.battery)
            HStack(spacing: 20) {
                ringButton
                locationButton
            }
        }
        .padding(.trailing, 15)
    }
    
    var ringButton: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 36, height: 36)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.20), radius: 13, x: 7, y: 7)
            Image("ring1")
                .onTapGesture {
                    if viewModel.checkDistance() <= 0.4 {
                        viewModel.pingScooter()
                    }
                }
        }
    }
    
    var locationButton: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 36, height: 36)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.20), radius: 13, x: 7, y: 7)
            Image("location")
                .onTapGesture {
                    let latitude = viewModel.scooter.location.coordinates[0]
                    let longitude = viewModel.scooter.location.coordinates[1]
                    let url = URL(string: "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")
                    if UIApplication.shared.canOpenURL(url!) {
                        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                    }
                    else{
                        let urlBrowser = URL(string: "https://www.google.co.in/maps/dir/??saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")
                        
                        UIApplication.shared.open(urlBrowser!, options: [:], completionHandler: nil)
                    }
                }
        }
    }
    
    var location: some View {
        HStack {
            Image("pin")
            Group {
                if let address = viewModel.address {
                    Text("\(address)")
                } else {
                    Text("loading address...")
                }
            }
            .font(.custom("BaiJamjuree-Medium", size: 14))
            .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
        }
        .padding()
    }
    
    var unlockButton: some View {
        Button {
            onUnlock()
        } label: {
            HStack {
                Text("Unlock")
                    .font(.custom("BaiJamjuree-SemiBold", size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.init(red: 0.898, green: 0.188, blue: 0.384), lineWidth: 2)
                    )
            }
            .background(Color.init(red: 0.898, green: 0.188, blue: 0.384))
            .cornerRadius(20)
            .frame(width: 200)
        }
    }
}

//struct ScooterCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScooterCardView(scooter: Scooter(id: "knsok1o3k2nrokv", number: 5, battery: 50, locked: false, booked: false, internalId: 1222, location: Location(type: "Point", coordinates: [23.5, 45.1]), lastSeen: "2022-04-26T06:24:07.550Z", status: "ACTIVE"), currentLocation: [], onRing: {}, onUnlock: {}, onLocation: {})
//    }
//}
