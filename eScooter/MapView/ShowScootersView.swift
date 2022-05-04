//
//  ShowScootersView.swift
//  eScooter
//
//  Created by Ana Vultur on 27.04.2022.
//

import SwiftUI

//struct ShowScootersView: View {
//    let scooters: [Scooter]
//    let location: [Double]
//    let onUnlock: (Scooter) -> Void
//
//    var body: some View {
//        GeometryReader { geometry in
//            HStack(alignment: .center) {
//                Spacer()
//                ForEach(scooters, id: \.id) { scooter in
//                    ScooterCardView(scooter: scooter, onRing: {
//
//                    }, onUnlock: {
//
//                    }, onLocation: {
//
//                    })
//                    .frame(width: geometry.size.width / 2)
//                    .padding(30)
//                }
//                Spacer()
//            }
//        }.frame(height: 315)
//    }
//}
//
//struct ShowScootersView_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowScootersView(scooters:  [Scooter(id: "knsok1o3k2nrokv", number: 5, battery: 50, locked: false, booked: false, internalId: 1222, location: Location(type: "Point", coordinates: [23.5, 45.1]), lastSeen: "2022-04-26T06:24:07.550Z", status: "ACTIVE"), Scooter(id: "knsok1o3k2nrokv", number: 5, battery: 50, locked: false, booked: false, internalId: 1222, location: Location(type: "Point", coordinates: [23.5, 45.1]), lastSeen: "2022-04-26T06:24:07.550Z", status: "ACTIVE"), Scooter(id: "knsok1o3k2nrokv", number: 5, battery: 50, locked: false, booked: false, internalId: 1222, location: Location(type: "Point", coordinates: [23.5, 45.1]), lastSeen: "2022-04-26T06:24:07.550Z", status: "ACTIVE")], location: [34.543, 54.58974], onUnlock: {_ in })
//    }
//}
