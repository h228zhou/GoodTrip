//
//  FlightTabView.swift
//  GoodTrip
//
//  Created by Ryan Zhou on 2/26/24.
//

import SwiftUI

struct FlightTabView: View {
    let flights: [Flight]
    
    var body: some View {
        NavigationStack {
            List (flights) { item in
                NavigationLink(value: item) {
                    FlightRow(flight: item)
                }
            }
            .navigationDestination(for: Flight.self) { item in
                FlightDetailView(flight: item)
            }
            .navigationTitle("Flight Results")
        }
        
    }
}

#Preview {
    let flights = FlightClient.shared
    return FlightTabView(flights: flights.Flights)
}
