//
//  StartRideView.swift
//  eScooter
//
//  Created by Ana Vultur on 03.05.2022.
//

import SwiftUI

struct StartRideView: View {
    let scooter: Scooter = Scooter(id: "knsok1o3k2nrokv", number: 5, battery: 50, locked: false, booked: false, internalId: 1222, location: Location(type: "Point", coordinates: [23.5, 45.1]), lastSeen: "2022-04-26T06:24:07.550Z", status: "ACTIVE", unlockCode: 1234)
    @State var offset = CGFloat(200.0)
    let dragDown: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            cardContent
                .transition(.slide)
                .gesture(DragGesture()
                    .onChanged { value in
                        offset = value.location.y
                    }
                    .onEnded { value in
                        offset = geometry.size.height
                        dragDown()
                    }
                )
                .onAppear {
                    offset = geometry.size.height - 375
                }
        }
    }
    
    var cardContent: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 29)
                        .fill(Color.white)
                        .frame(width: geometry.size.width)
                    Image("pinkBar")
                    VStack {
                        HStack {
                            details
                            Spacer()
                            Image("scooter1")
                        }
                        .padding()
                        startRideButton
                    }
                    .padding()
                }
                .offset(y: offset)
                .onAppear {
                    offset = geometry.size.height
                }
            }
        }
    }
    
    var startRideButton: some View {
        Button {
            
        } label: {
            HStack {
                Text("Start ride")
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
        }
    }
    
    var details: some View {
        VStack(alignment: .leading) {
            Text("Scooter")
                .font(.custom("BaiJamjuree-Medium", size: 14))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                .opacity(0.7)
            Text("#" + "\(self.scooter.internalId)")
                .font(.custom("BaiJamjuree-Bold", size: 20))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            BatteryView(batteryLevel: self.scooter.battery)
        }
    }
}

struct StartRideView_Previews: PreviewProvider {
    static var previews: some View {
        StartRideView(dragDown: {})
    }
}
