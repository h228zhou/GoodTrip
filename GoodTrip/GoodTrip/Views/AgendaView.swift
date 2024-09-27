//
//  AgendaView.swift
//  GoodTrip
//
//  Created by Ryan Zhou on 2/26/24.
//

import SwiftUI

struct AgendaView: View {
    @ObservedObject var flightClient = FlightClient.shared // Using observed object to listen to data changes
    @State private var showingProfile = false

    var body: some View {
        NavigationStack {
            List(flightClient.UserFlights) { item in
                NavigationLink(value: item) {
                    FlightRow(flight: item)
                }
            }
            .listStyle(.inset)
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
            }
            .navigationDestination(for: Flight.self) { item in
                FlightDetailView(flight: item)
            }
            .navigationTitle("My Flights")
            .refreshable {
                flightClient.loadUserFlights() // Reloading the agenda
            }
        }
    }
}




#Preview {
    let flights = FlightClient.shared
    return FlightTabView(flights: flights.Flights)
}
