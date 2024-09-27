//
//  CurvedLine.swift
//  GoodTrip
//
//  Created by Yutong Sun on 3/2/24.
//

import Foundation
import MapKit

/// A class that represents a curved line overlay on a map view. It is used to visually connect two geographical locations.
class CurvedLine: NSObject, MKOverlay {
    // The central coordinate of the overlay. For curved lines, this is initially set to the departure coordinate.
    var coordinate: CLLocationCoordinate2D
    // The smallest rectangle that completely encompasses the overlay. Used by MapKit to manage rendering.
    var boundingMapRect: MKMapRect
    // The geographical coordinate from which the line starts.
    let departureCoordinate: CLLocationCoordinate2D
    // The geographical coordinate at which the line ends.
    let arrivalCoordinate: CLLocationCoordinate2D
    
    /// Initializes a new CurvedLine overlay with specified departure and arrival coordinates.
    /// - Parameters:
    ///   - departureCoordinate: The coordinate from which the line will start.
    ///   - arrivalCoordinate: The coordinate at which the line will end.
    init(departureCoordinate: CLLocationCoordinate2D, arrivalCoordinate: CLLocationCoordinate2D) {
        self.departureCoordinate = departureCoordinate
        self.arrivalCoordinate = arrivalCoordinate
        self.coordinate = departureCoordinate
        
        // Convert coordinates to map points for calculating the overlay's bounding rectangle.
        let departurePoint = MKMapPoint(departureCoordinate)
        let arrivalPoint = MKMapPoint(arrivalCoordinate)

        // Calculate the bounding map rectangle encompassing both departure and arrival points.
        let rect = MKMapRect(x: min(departurePoint.x, arrivalPoint.x),
                             y: min(departurePoint.y, arrivalPoint.y),
                             width: abs(departurePoint.x - arrivalPoint.x),
                             height: abs(departurePoint.y - arrivalPoint.y))
        self.boundingMapRect = rect
        super.init()
    }
}
