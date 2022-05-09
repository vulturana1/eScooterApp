//
//  ScooterUnlockView.swift
//  eScooter
//
//  Created by Ana Vultur on 29.04.2022.
//

import SwiftUI

struct ScooterUnlockView: View {
    
    @ObservedObject var viewModel: ScooterCardViewModel
    let dragDown: () -> Void
    let onVerifySerialNumber: () -> Void
    let onVerifyNfc: () -> Void
    let onVerifyQr: () -> Void
    @State var offset = CGFloat(200.0)
    
    init(scooter: Scooter, currentLocation: [Double], dragDown: @escaping () -> Void, onVerifySerialNumber: @escaping () -> Void, onVerifyNfc: @escaping () -> Void, onVerifyQr: @escaping () -> Void) {
        viewModel = ScooterCardViewModel(scooter: scooter, location: currentLocation)
        self.dragDown = dragDown
        self.onVerifySerialNumber = onVerifySerialNumber
        self.onVerifyQr = onVerifyQr
        self.onVerifyNfc = onVerifyNfc
    }
    
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
                    offset = geometry.size.height - 438
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
                    VStack{
                        Text("You can unlock this scooter through these methods:")
                            .multilineTextAlignment(.center)
                            .font(.custom("BaiJamjuree-Bold", size: 16))
                            .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                        HStack {
                            details
                            Image("scooter1")
                        }
                        buttons
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
    
    var details: some View {
        VStack(alignment: .leading) {
            Text("Scooter")
                .font(.custom("BaiJamjuree-Medium", size: 14))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                .opacity(0.7)
            Text("#" + "\(viewModel.scooter.internalId)")
                .font(.custom("BaiJamjuree-Bold", size: 20))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            BatteryView(batteryLevel: viewModel.scooter.battery)
            ringButton
            missingButton
        }
    }
    
    var missingButton: some View {
        HStack {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 36, height: 36)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.20), radius: 13, x: 7, y: 7)
                Image("missing")
                    .onTapGesture {
                        
                    }
            }
            Text("Missing")
                .font(.custom("BaiJamjuree-Medium", size: 14))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
        }
    }
    
    var ringButton: some View {
        HStack {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 36, height: 36)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.20), radius: 13, x: 7, y: 7)
                Image("ring1")
                    .onTapGesture {
                        viewModel.pingScooter()
                    }
            }
            Text("Ring")
                .font(.custom("BaiJamjuree-Medium", size: 14))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
        }
    }
    
    var buttons: some View {
        HStack {
            Image("nfcUnlock")
                .onTapGesture {
                    onVerifyNfc()
                }
            Image("qrUnlock")
                .onTapGesture {
                    onVerifyQr()
                }
            Image("serialUnlock")
                .onTapGesture {
                    onVerifySerialNumber()
                }
        }
    }
}

//struct ScooterUnlockView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScooterUnlockView(onRing: {}, dragDown: {})
//    }
//}
