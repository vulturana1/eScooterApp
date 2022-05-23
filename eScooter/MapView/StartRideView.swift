//
//  StartRideView.swift
//  eScooter
//
//  Created by Ana Vultur on 03.05.2022.
//

import SwiftUI

struct StartRideView: View {

    @ObservedObject var viewModel: ScooterCardViewModel
    @State var offset = CGFloat(200.0)
    let dragDown: () -> Void
    let onTripDetails: (Trip) -> Void
    
    init(viewModel: ScooterCardViewModel, dragDown: @escaping () -> Void, onTripDetails: @escaping (Trip) -> Void) {
        self.viewModel = viewModel
        self.dragDown = dragDown
        self.onTripDetails = onTripDetails
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
            viewModel.startRide { result in
                onTripDetails(result)
            }
//            { result in
//                switch result {
//                case .success(let result):
//                    onTripDetails(result)
//                    break
//                case .failure(let error):
//                    showError(error: error)
//                    break
//                }
//            }
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
            Text("#" + "\(viewModel.scooter.internalId)")
                .font(.custom("BaiJamjuree-Bold", size: 20))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            BatteryView(batteryLevel: viewModel.scooter.battery)
        }
    }
}

//struct StartRideView_Previews: PreviewProvider {
//    static var previews: some View {
//        StartRideView(dragDown: {}, onStartRide: {})
//    }
//}
