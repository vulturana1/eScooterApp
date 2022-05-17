//
//  BatteryViewExtended.swift
//  eScooter
//
//  Created by Ana Vultur on 17.05.2022.
//

import SwiftUI

struct BatteryViewExtended: View {
    let batteryLevel: Int
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                switch batteryLevel {
                case 0..<20: Image("battery-low")
                case 20..<40: Image("battery-medium-low")
                case 40..<60: Image("battery-medium")
                case 60..<80: Image("battery-almost-full")
                default: Image("battery-full")
                }
                Text("Battery")
                    .font(.custom("BaiJamjuree-Medium", size: 16))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            }
            Text("\(batteryLevel)%")
                .font(.custom("BaiJamjuree-Bold", size: 44))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
        }
    }
}

struct BatteryViewExtended_Previews: PreviewProvider {
    static var previews: some View {
        BatteryView(batteryLevel: 70)
    }
}
