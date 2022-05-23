//
//  TripSummaryView.swift
//  eScooter
//
//  Created by Ana Vultur on 06.05.2022.
//

import SwiftUI
import CoreLocation
import MapKit
import PassKit

struct TripSummaryView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    @State private var location = CLLocationCoordinate2D(latitude: 46.75618, longitude: 23.5948)
    let paymentHandler = PaymentHandler()
    let onNext: () -> Void
    @State var showAlert = false
    let trip: Trip
    @ObservedObject private var viewModel: TripSummaryViewModel
    
    init(onNext: @escaping () -> Void, trip: Trip) {
        self.onNext = onNext
        self.trip = trip
        self.viewModel = TripSummaryViewModel(trip: self.trip, location: self.trip.coordinatesArray)
    }
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Trip Details")
                    .multilineTextAlignment(.center)
                    .font(.custom("BaiJamjuree-Bold", size: 16))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                    .padding()
                
                MapPolylineView(centerCoordinate: $location, locations: getCoordinates())
                    .frame(maxWidth: .infinity, maxHeight: 172)
                    .clipShape(RoundedRectangle(cornerRadius: 29))
                    .padding(.horizontal, 22)
                
                sectionFromTo
                
                HStack {
                    detailsLeft
                    Spacer()
                    detailsRight
                }
                Spacer()
                applePayButton
            }
        }
        .onAppear {
            region.center = CLLocationCoordinate2D(latitude: CLLocationDegrees(trip.coordinatesArray[0].latitude), longitude: CLLocationDegrees(trip.coordinatesArray[0].longitude))
        }
    }
    
    func getCoordinates() -> [CLLocationCoordinate2D] {
        var coordinates: [CLLocationCoordinate2D] = []
        for index in 0..<trip.coordinatesArray.count {
            coordinates.append(CLLocationCoordinate2D(latitude: trip.coordinatesArray[index].latitude, longitude: trip.coordinatesArray[index].longitude))
        }
        return coordinates
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
                Text(String(format: "%02d:%02d", trip.totalTime / 3600, trip.totalTime / 60))
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
                Text(String(format: "%.2f km", trip.distance / Double(1000)))
                    .font(.custom("BaiJamjuree-Bold", size: 16))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            }
        }
        .padding()
        .padding(.trailing, 30)
    }
    
    var applePayButton: some View {
        Button {
            showSuccess(message: "Payment succesful of \(trip.cost) lei")
            onNext()
            //            self.paymentHandler.startPayment(price: "\(trip.cost)") { success in
            //                if success {
            //
            //                    showSuccess(message: "You can find your recipt in your mail")
            //                    onNext()
            //
            //                } else {
            ////                    showError(error: Error( "We couln't process your payment"))
            //                    print("Eroare plata")
            //                    showAlert = true
            //                    //onNext()
            //                }
            //            }
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
    
    var sectionFromTo: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.black.opacity(0.07))
            VStack(alignment: .leading, spacing: 5) {
                Text("From")
                    .font(.custom("BaiJamjuree-Medium", size: 12))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                    .opacity(0.5)
                Text(viewModel.startAddress ?? "N/A")
                    .font(.custom("BaiJamjuree-Bold", size: 14))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                Spacer()
                Text("To")
                    .font(.custom("BaiJamjuree-Medium", size: 12))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
                    .opacity(0.5)
                Text(viewModel.endAddress ?? "N/A")
                    .font(.custom("BaiJamjuree-Bold", size: 14))
                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
            }
            .padding(20)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.init(red: 0.129, green: 0.043, blue: 0.314))
        )
        .frame(width: 340, height: 175)
    }
}

//struct SectionFromTo: View {
//    let trip: Trip
//    @State private var from: String?
//    @State private var to: String?
//    
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 15)
//                .fill(.black.opacity(0.07))
//            VStack(alignment: .leading, spacing: 5) {
//                Text("From")
//                    .font(.custom("BaiJamjuree-Medium", size: 12))
//                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
//                    .opacity(0.5)
//                Text(from ?? "N/A")
//                    .onAppear {
//                        lookUpCurrentLocation(trip: trip, location: trip.coordinatesArray[0]) { value in
//                            from = value?.thoroughfare
//                        }
//                    }
//                    .font(.custom("BaiJamjuree-Bold", size: 14))
//                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
//                Spacer()
//                Text("To")
//                    .font(.custom("BaiJamjuree-Medium", size: 12))
//                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
//                    .opacity(0.5)
//                Text(to ?? "N/A")
//                    .onAppear {
//                        lookUpCurrentLocation(trip: trip, location: trip.coordinatesArray[trip.coordinatesArray.count - 1]) { value in
//                            to = value?.thoroughfare
//                        }
//                    }
//                    .font(.custom("BaiJamjuree-Bold", size: 14))
//                    .foregroundColor(.init(red: 0.129, green: 0.043, blue: 0.314))
//            }
//            .padding(20)
//        }
//        .overlay(
//            RoundedRectangle(cornerRadius: 15)
//                .stroke(Color.init(red: 0.129, green: 0.043, blue: 0.314))
//        )
//        .frame(width: 340, height: 175)
//    }
//    
//    func lookUpCurrentLocation(trip: Trip, location: Coordinates, completionHandler: @escaping (CLPlacemark?)
//                               -> Void) {
//        let geocoder = CLGeocoder()
//        geocoder.reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude),
//                                        completionHandler: { (placemarks, error) in
//            if error == nil {
//                let firstLocation = placemarks?[0]
//                completionHandler(firstLocation)
//            }
//            else {
//                completionHandler(nil)
//            }
//        })
//    }
//}

//struct TripSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        TripSummaryView()
//    }
//}
