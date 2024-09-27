//
//  MapView.swift
//  GoodTrip
//
//  Created by Yutong Sun on 3/2/24.
//

import SwiftUI
import MapKit


struct MapView: View {
    let flight: Flight

    var body: some View {
        CustomMapView(departureCoordinate: flight.DepartureLocation, arrivalCoordinate: flight.ArrivalLocation, departureAirport: flight.departureAirport, arrivalAirport: flight.arrivalAirport)
            .edgesIgnoringSafeArea(.all)
    }
}


#Preview {
    let flight = FlightClient.shared.Flights.first!
    return MapView(flight: flight)
}
