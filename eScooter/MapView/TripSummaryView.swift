//
//  TripSummaryView.swift
//  eScooter
//
//  Created by Ana Vultur on 06.05.2022.
//

import SwiftUI
import CoreLocation

struct TripSummaryView: View {
    let trip: Trip = Trip(id: "235kna", coordinatesArray: [Coordinates(latitude: 46.99378173443409, longitude: 23.969880551690657, id: "626fe36687242a28bbd70054")], totalTime: 12, distance: 10, cost: 10)
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack {
                Text("Trip Details")
                    .multilineTextAlignment(.center)
                    .font(.custom("BaiJamjuree-Bold", size: 16))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                    .padding()
                //map
                SectionFromTo(trip: self.trip)
                
                HStack {
                    detailsLeft
                    Spacer()
                    detailsRight
                }
                Spacer()
                applePayButton
            }
        }
    }
    
    var detailsLeft: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("time")
                Text("Travel time")
                    .font(.custom("BaiJamjuree-Medium", size: 16))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                    .opacity(0.7)
            }
            HStack {
                Text("\(trip.totalTime)")
                    .font(.custom("BaiJamjuree-Bold", size: 16))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                Text("  min")
                    .font(.custom("BaiJamjuree-Bold", size: 16))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            }
        }
        .padding()
        .padding(.leading, 30)
    }
    
    var detailsRight: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("map")
                Text("Distance")
                    .font(.custom("BaiJamjuree-Medium", size: 16))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                    .opacity(0.7)
            }
            HStack {
                Text("\(trip.distance)")
                    .font(.custom("BaiJamjuree-Bold", size: 16))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                Text("  km")
                    .font(.custom("BaiJamjuree-Bold", size: 16))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            }
        }
        .padding()
        .padding(.trailing, 30)
    }
    
    var applePayButton: some View {
        Button {
            
        } label: {
            HStack {
                Text("Pay with Pay")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black)
                    )
            }
            .background(Color.black)
            .cornerRadius(20)
        }
        .padding()
    }
}

struct SectionFromTo: View {
    let trip: Trip
    @State private var from: String?
    @State private var to: String?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.black.opacity(0.07))
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
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.init(red: 0.129, green: 0.043, blue: 0.314))
        )
        .frame(width: 327, height: 160)
    }
    
    func lookUpCurrentLocation(trip: Trip, location: Coordinates, completionHandler: @escaping (CLPlacemark?)
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

struct TripSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        TripSummaryView()
    }
}
