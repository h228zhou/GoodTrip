//
//  CustomMapView.swift
//  GoodTrip
//
//  Created by Yutong Sun on 3/2/24.
//

import os.log
import SwiftUI
import MapKit

private let mapViewLogger = Logger(subsystem: "com.example.GoodTrip", category: "CustomMapView")

/// Creates a mapview for the departure and arrival coordinates
struct CustomMapView: UIViewRepresentable {
    var departureCoordinate: CLLocationCoordinate2D
    var arrivalCoordinate: CLLocationCoordinate2D
    var departureAirport: String
    var arrivalAirport: String
    
    /// Creates the `MKMapView` to be displayed in the SwiftUI view hierarchy.
    /// - Parameter context: The context of the view.
    /// - Returns: A configured `MKMapView` instance.
    func makeUIView(context: Context) -> MKMapView {
        mapViewLogger.debug("Creating MKMapView")
        
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        let coordinates = [departureCoordinate, arrivalCoordinate]
        // Setup the annotations for departure and arrival airports
        let departureAnnotation = MKPointAnnotation()
        departureAnnotation.coordinate = departureCoordinate
        departureAnnotation.title = departureAirport
        
        mapView.addAnnotation(departureAnnotation)

        let arrivalAnnotation = MKPointAnnotation()
        arrivalAnnotation.coordinate = arrivalCoordinate
        arrivalAnnotation.title = arrivalAirport
        
        mapView.addAnnotation(arrivalAnnotation)
        // Automatically adjusts the map region to display both annotations
        mapView.showAnnotations([departureAnnotation, arrivalAnnotation], animated: true)

        // Drawing the polyline on the mapKit
        let geodesic = MKGeodesicPolyline(coordinates: coordinates, count: 2)
        mapView.addOverlay(geodesic)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    /// A coordinator to manage interactions between `MKMapView` and SwiftUI.
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: CustomMapView

        init(_ parent: CustomMapView) {
            self.parent = parent
        }
        
        /// Provides a renderer for the overlay. This method customizes the appearance of the polyline.
        /// - Parameters:
        ///   - mapView: The map view requesting the renderer.
        ///   - overlay: The overlay object that needs a renderer.
        /// - Returns: An `MKOverlayRenderer` object to use when presenting the overlay on the map.
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            mapViewLogger.debug("Configuring renderer for MKOverlay")
            if overlay is MKGeodesicPolyline {
                let renderer = MKPolylineRenderer(overlay: overlay)
                renderer.strokeColor = .blue // Sets the color of the line
                renderer.lineWidth = 3 // Sets the width of the line
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}



