//
//  MapPolylineView.swift
//  eScooter
//
//  Created by Ana Vultur on 12.05.2022.
//

import SwiftUI
import UIKit
import MapKit
import CoreLocation

struct MapPolylineView: UIViewRepresentable {
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var locations: [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: 46.753567, longitude: 23.584288), CLLocationCoordinate2D(latitude: 46.753666, longitude: 23.581428)]
    
    func makeUIView(context: Context) -> some MKMapView {
        let mapView = MKMapView()
        let polyline = MKPolyline(coordinates: locations, count: locations.count)
        print(locations)
    
        mapView.setRegion(MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: false)
        mapView.delegate = context.coordinator
        mapView.addOverlay(polyline)
        
        return mapView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapPolylineView
        
        init(_ parent: MapPolylineView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            guard let polyline = overlay as? MKPolyline else {
                return MKOverlayRenderer()
            }
            let polylineRenderer = MKPolylineRenderer(overlay: polyline)
            polylineRenderer.strokeColor = UIColor(Color.init(red: 0.898, green: 0.188, blue: 0.384))
            polylineRenderer.lineWidth = 3.5
            
            return polylineRenderer
        }
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
