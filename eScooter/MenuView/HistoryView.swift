//
//  HistoryView.swift
//  eScooter
//
//  Created by Ana Vultur on 27.04.2022.
//

import SwiftUI
import CoreLocation

struct HistoryView: View {
    
    @StateObject var viewModel = HistoryViewModel()
    let onBack: () -> Void
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack {
                backButton
                RefreshableScrollView(height: 70, refreshing: self.$viewModel.loading) {
                    ForEach(viewModel.trips, id: \.id) { trip in
                        Section(trip: trip)
                    }
                    if viewModel.trips.count > 10 {
                        Button {
                            viewModel.loadMore()
                        } label: {
                            Text("Load more")
                                .font(.custom("BaiJamjuree-SemiBold", size: 16))
                                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                                .padding()
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    var backButton: some View {
        HStack {
            Button {
                onBack()
            } label: {
                Image("left-arrow")
                    .renderingMode(.template)
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            }
            Spacer()
            Text("History")
                .font(.custom("BaiJamjuree-SemiBold", size: 17))
                .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            Spacer()
            Text("         ")
        }
        .padding(.top, 20)
    }
    
}

struct Section: View {
    let trip: HistoryTrip
    @State private var from: String?
    @State private var to: String?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.black.opacity(0.07))
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("From")
                        .font(.custom("BaiJamjuree-Medium", size: 12))
                        .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                        .opacity(0.5)
                    Text(from ?? "no place found")
                        .onAppear {
                            lookUpCurrentLocation(trip: trip, location: trip.coordinatesArray[0]) { value in
                                from = value?.thoroughfare
                            }
                        }
                        .font(.custom("BaiJamjuree-Bold", size: 14))
                        .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                    Spacer()
                    Text("To")
                        .font(.custom("BaiJamjuree-Medium", size: 12))
                        .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                        .opacity(0.5)
                    Text(to ?? "no place found")
                        .onAppear {
                            lookUpCurrentLocation(trip: trip, location: trip.coordinatesArray[trip.coordinatesArray.count - 1]) { value in
                                to = value?.thoroughfare
                            }
                        }
                        .font(.custom("BaiJamjuree-Bold", size: 14))
                        .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                }
                .padding(20)
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    Text("Travel time")
                        .font(.custom("BaiJamjuree-Medium", size: 12))
                        .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                        .opacity(0.5)
                    Text(String(format: "%02d:%02d min", trip.totalTime / 3600, trip.totalTime / 60))
                        .font(.custom("BaiJamjuree-Bold", size: 14))
                        .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                    Spacer()
                    Text("Distance")
                        .font(.custom("BaiJamjuree-Medium", size: 12))
                        .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                        .opacity(0.5)
                    Text(String(format: "%.2f km", trip.distance / Double(1000)))
                        .font(.custom("BaiJamjuree-Bold", size: 14))
                        .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                }
                .padding(20)
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.init(red: 0.129, green: 0.043, blue: 0.314))
        )
        .frame(width: 340, height: 160)
    }
    
    func lookUpCurrentLocation(trip: HistoryTrip, location: Coordinates, completionHandler: @escaping (CLPlacemark?)
                               -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude),
                                        completionHandler: { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                completionHandler(firstLocation)
            }
            else {
                completionHandler(nil)
            }
        })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(onBack: {})
    }
}
