//
//  SearchByDateView.swift
//  GoodTrip
//
//  Created by Ryan Zhou on 2/26/24.
//

import SwiftUI
import Combine

struct SearchByDateView: View {
    @State private var showingResults = false
    @State private var selectedDate = Date()
    @State private var departureCode = ""
    @State private var arrivalCode = ""
    @State private var departureCity = ""
    @State private var arrivalCity = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        Form {
            Section(header: Text("Airports")) {
                TextField("Departure Airport Code", text: $departureCode)
                    .onChange(of: departureCode) { _, newValue in
                        departureCode = String(newValue.prefix(3)).uppercased()
                        updateCityName(for: newValue, isDeparture: true)
                    }
                    .limitInputLength(3, for: $departureCode)
                    .uppercaseText($departureCode)
                if !departureCity.isEmpty {
                    Text("City: \(departureCity)")
                }
                
                TextField("Arrival Airport Code", text: $arrivalCode)
                    .onChange(of: arrivalCode) { _, newValue in
                        arrivalCode = String(newValue.prefix(3)).uppercased()
                        updateCityName(for: newValue, isDeparture: false)
                    }
                    .limitInputLength(3, for: $arrivalCode)
                    .uppercaseText($arrivalCode)
                if !arrivalCity.isEmpty {
                    Text("City: \(arrivalCity)")
                }
                
                Button("Swap Airports") {
                    swapAirports()
                }
            }
            
            Section(header: Text("Date")) {
                DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
            }
            
            Button("Search") {
                if NetworkMonitor.shared.isConnected {
                    FlightClient.shared.searchFlights(departureAirport: departureCode, arrivalAirport: arrivalCode, date: selectedDate)
                    showingResults = true
                } else {
                    showingAlert = true
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
        }
        .navigationBarTitle("Search by Date", displayMode: .inline)
        .sheet(isPresented: $showingResults) {
            // Pass the search results to FlightTabView
            FlightTabView(flights: FlightClient.shared.SearchResultsFlights)
        }
    }
    
    private func updateCityName(for code: String, isDeparture: Bool) {
        let city = AirportClient.shared.airportCity(forCode: code)
        if isDeparture {
            departureCity = city ?? ""
        } else {
            arrivalCity = city ?? ""
        }
    }
    
    private func swapAirports() {
        (departureCode, arrivalCode) = (arrivalCode, departureCode)
        (departureCity, arrivalCity) = (arrivalCity, departureCity)
    }
    
    private func searchFlights() {
        FlightClient.shared.searchFlights(departureAirport: departureCode, arrivalAirport: arrivalCode, date: selectedDate)
    }
}

extension View {
    func limitInputLength(_ maxLength: Int, for binding: Binding<String>) -> some View {
        self.onReceive(Just(binding.wrappedValue)) { _ in
            if binding.wrappedValue.count > maxLength {
                binding.wrappedValue = String(binding.wrappedValue.prefix(maxLength))
            }
        }
    }
    
    func uppercaseText(_ text: Binding<String>) -> some View {
        self.onReceive(Just(text.wrappedValue)) { _ in
            text.wrappedValue = text.wrappedValue.uppercased()
        }
    }
}


#Preview {
    SearchByDateView()
}
