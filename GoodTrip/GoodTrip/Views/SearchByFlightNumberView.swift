//
//  SearchByFlightNumberView.swift
//  GoodTrip
//
//  Created by Ryan Zhou on 2/26/24.
//

import SwiftUI

import SwiftUI

struct SearchByFlightNumberView: View {
    @State private var flightNumber = ""
    @State private var showingResults = false
    @State private var showingAlert = false

    var body: some View {
        Form {
            TextField("Flight Number", text: $flightNumber)
            Button("Search") {
                if NetworkMonitor.shared.isConnected {
                    FlightClient.shared.searchFlights(byFlightNumber: flightNumber)
                    showingResults = true
                } else {
                    showingAlert = true
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("No Internet Connection"),
                message: Text("Please check your internet connection and try again"),
                dismissButton: .default(Text("OK")) {
                showingAlert = false
            })
        }
        .navigationBarTitle("Search by Flight Number", displayMode: .inline)
        .sheet(isPresented: $showingResults) {
            // Pass the search results to FlightTabView
            FlightTabView(flights: FlightClient.shared.SearchResultsFlights)
        }
    }
}



#Preview {
    SearchByFlightNumberView()
}
