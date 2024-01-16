//
//  UberMapViewrepresentable.swift
//  UberClone
//
//  Created by User on 16.1.2024.
//

import SwiftUI
import MapKit

struct UberMapView: UIViewRepresentable {
    
    private let mapview = MKMapView()
    private let locationManager = LocationManager()
    
    func makeUIView(context: Context) -> some UIView {
        self.mapview.delegate = context.coordinator
        self.mapview.isRotateEnabled = false
        self.mapview.showsUserLocation = true
        self.mapview.userTrackingMode = .follow
        return self.mapview
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}


extension UberMapView {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        private let parent: UberMapView
        
        init(parent: UberMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: userLocation.coordinate.latitude,
                    longitude: userLocation.coordinate.longitude
                ),
                span: .init(
                    latitudeDelta: 0.05,
                    longitudeDelta: 0.05
                )
            )
            self.parent.mapview.setRegion(region, animated: true)
        }
    }
}
