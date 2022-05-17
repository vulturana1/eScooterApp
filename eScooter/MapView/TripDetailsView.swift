//
//  TripDetailsView.swift
//  eScooter
//
//  Created by Ana Vultur on 03.05.2022.
//

import SwiftUI

struct TripDetailsView: View {
    
    @ObservedObject var viewModel: TripDetailsViewModel
    @State var offset = CGFloat(200.0)
    @State var lock = false
    let onEndRide: (TripResponse) -> Void
    
    init(viewModel: TripDetailsViewModel, onEndRide: @escaping (TripResponse) -> Void) {
        self.viewModel = viewModel
        self.onEndRide = onEndRide
    }
    
    var body: some View {
        GeometryReader { geometry in
            if offset == 0 {
                extendedView
                    .transition(.slide)
                    .gesture(
                        maximizeCardGesture(contentHight: geometry.size.height)
                    )
                    .offset(y: offset)
            }
            else {
                cardContent
                    .transition(.slide)
                    .gesture(
                        minimizeCardGesture(contentHight: geometry.size.height)
                    )
            }
        }
    }
    
    
    func minimizeCardGesture(contentHight: CGFloat) -> some Gesture {
        DragGesture()
            .onChanged { value in
                offset = value.location.y
            }
            .onEnded { value in
                if value.location.y > offset {
                    withAnimation(.default) {
                        offset =  contentHight - 310
                    }
                } else {
                    offset = 0
                }
            }
    }
    
    func maximizeCardGesture(contentHight: CGFloat) -> some Gesture {
        DragGesture()
            .onChanged { value in
                if value.location.y > offset {
                    //withAnimation(.spring()) {
                        offset = value.location.y
                    //}
                }
            }
            .onEnded { value in
                    offset = contentHight - 310
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
                        Text("Trip Details")
                            .multilineTextAlignment(.center)
                            .font(.custom("BaiJamjuree-Bold", size: 16))
                            .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                        HStack {
                            detailsLeft
                            Spacer()
                            detailsRight
                        }
                        .padding()
                        HStack {
                            if lock {
                                unlockButton
                            } else {
                                lockButton
                            }
                            endRideButton
                        }
                    }
                    .padding()
                }
                .offset(y: offset)
                .onAppear {
                    offset = geometry.size.height - 310
                }
            }
        }
    }
    
    var endRideButton: some View {
        Button {
            viewModel.endRide { result in
                switch result {
                case .success(let result):
                    onEndRide(result)
                    break
                case .failure(let error):
                    showError(error: error)
                    break
                }
            }
            //onEndRide()
        } label: {
            HStack {
                Text("End ride")
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
    
    var lockButton: some View {
        Button {
            viewModel.lockScooter()
            lock.toggle()
        } label: {
            HStack {
                Image("lock")
                Text("Lock")
                    .font(.custom("BaiJamjuree-SemiBold", size: 16))
                    .foregroundColor(Color.init(red: 0.898, green: 0.188, blue: 0.384))
            }
            .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
            .background(Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.init(red: 0.898, green: 0.188, blue: 0.384), lineWidth: 2)
            )
        }
    }
    var unlockButton: some View {
        Button {
            viewModel.unlockScooter()
            lock.toggle()
        } label: {
            HStack {
                Image("unlock")
                Text("Unlock")
                    .font(.custom("BaiJamjuree-SemiBold", size: 16))
                    .foregroundColor(Color.init(red: 0.898, green: 0.188, blue: 0.384))
            }
            .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
            .background(Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.init(red: 0.898, green: 0.188, blue: 0.384), lineWidth: 2)
            )
            
        }
    }
    
    var detailsLeft: some View {
        VStack(alignment: .leading) {
            BatteryView(batteryLevel: viewModel.scooter.battery)
            HStack {
                Image("time")
                Text("Travel time")
                    .font(.custom("BaiJamjuree-Medium", size: 14))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                    .opacity(0.7)
            }
            HStack {
                Text(String(format: "%02d:%02d", viewModel.trip.time / 3600, viewModel.trip.time / 60))
                    .font(.custom("BaiJamjuree-Bold", size: 30))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                Text("  min")
                    .font(.custom("BaiJamjuree-Bold", size: 20))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            }
        }
    }
    
    var detailsRight: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("map")
                Text("Distance")
                    .font(.custom("BaiJamjuree-Medium", size: 14))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                    .opacity(0.7)
            }
            HStack {
                Text(String(format: "%.2f", viewModel.trip.distance / Double(1000)))
                    .font(.custom("BaiJamjuree-Bold", size: 30))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                Text("  km")
                    .font(.custom("BaiJamjuree-Bold", size: 20))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            }
        }
    }
    
    var extendedView: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack {
                HStack {
//                    Image("down")
//                        .onTapGesture {
//
//                        }
                Text("Trip Details")
                    .multilineTextAlignment(.center)
                    .font(.custom("BaiJamjuree-Bold", size: 16))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                }
                extendedViewContent
                HStack {
                    if lock {
                        unlockButton
                    } else {
                        lockButton
                    }
                    endRideButton
                }
            }
            .padding()
        }
    }
    
    var time: some View {
        VStack(alignment: .center) {
            HStack {
                Image("time")
                Text("Travel time")
                    .font(.custom("BaiJamjuree-Medium", size: 14))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                    .opacity(0.7)
            }
            Text(String(format: "%02d:%02d:%02d", viewModel.trip.time / 3600, viewModel.trip.time / 60 % 60, viewModel.trip.time % 60))
                .font(.custom("BaiJamjuree-Bold", size: 44))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
        }
    }
    
    var distance: some View {
        VStack(alignment: .center) {
            HStack {
                Image("map")
                Text("Distance")
                    .font(.custom("BaiJamjuree-Medium", size: 14))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                    .opacity(0.7)
            }
            
            Text(String(format: "%.2f", viewModel.trip.distance / Double(1000)))
                .font(.custom("BaiJamjuree-Bold", size: 44))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            Text("  km")
                .font(.custom("BaiJamjuree-Medium", size: 16))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
        }
    }
    
    var extendedViewContent: some View {
        VStack {
            RoundedRectangle(cornerRadius: 29)
                .stroke(Color.black.opacity(0.5), lineWidth: 1)
                .overlay(BatteryViewExtended(batteryLevel: viewModel.scooter.battery))
                .padding()
            
            RoundedRectangle(cornerRadius: 29)
                .stroke(Color.black.opacity(0.5), lineWidth: 1)
                .overlay(time)
                .padding()
            
            RoundedRectangle(cornerRadius: 29)
                .stroke(Color.black.opacity(0.5), lineWidth: 1)
                .overlay(distance)
                .padding()
        }
    }
}

//struct TripDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TripDetailsView(dragDown: {}, onEndRide: {}, onLock: {})
//    }
//}
