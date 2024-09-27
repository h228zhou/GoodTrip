//
//  FlightDetailView.swift
//  GoodTrip
//
//  Created by Ryan Zhou on 2/26/24.
//

import SwiftUI

struct FlightDetailView: View {
    let flight: Flight
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showingConfirmationDialog = false
    var body: some View {
        VStack {
            MapView(flight: flight)

            HStack {
                Image(systemName: "airplane")
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text(flight.airline)
                        .font(.largeTitle)
                   Text("Estimated flight time " + flight.estimatedFlightTime!)
                }
            }
            .padding()
            
            Divider()
            
            Text(flight.DepartureDate!)
                .font(.title)
                .padding()
            
            HStack {
                VStack(alignment: .leading) {
                    Text(flight.DepartureCity!)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Text(flight.DepartureTime!)
                        .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                    Text(flight.departureAirport)
                    Text("Terminal: " + flight.departureTerminal)
                }
                Spacer()
                Image(systemName: "arrow.right")
                Spacer()
                VStack(alignment: .leading) {
                    Text(flight.ArrivalCity!)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Text(flight.ArrivalTime!)
                        .font(/*@START_MENU_TOKEN@*/.headline/*@END_MENU_TOKEN@*/)
                    Text(flight.arrivalAirport)
                    Text("Terminal: " + flight.arrivalTerminal)
                }
            }
            .padding()
            
            Divider()
            
            HStack {
                FlightDetailCardView(title: "Gate", info: flight.gate)
                    .frame(width: 135, height: 150)
                
                FlightDetailCardView(title: "Arrive Gate", info: flight.arrivalGate)
                    .frame(width: 135, height: 150)
                
                FlightDetailCardView(title: "Baggage", info: flight.baggageClaim)
                    .frame(width: 135, height: 150)
                
            }
            .padding()
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if FlightClient.shared.isFlightInUserFlights(flight) {
                        showingConfirmationDialog = true
                    } else {
                        FlightClient.shared.addUserFlight(flight: flight)
                        alertMessage = "Flight has been added to your agenda."
                        showAlert = true
                    }
                }) {
                    Text(FlightClient.shared.isFlightInUserFlights(flight) ? "Followed" : "Add")
                        .bold()
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 10).fill(FlightClient.shared.isFlightInUserFlights(flight) ? Color.blue : Color.green))
                        .foregroundColor(.white)
                        .frame(height: 28)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .confirmationDialog("Are you sure you want to unfollow this flight?", isPresented: $showingConfirmationDialog, titleVisibility: .visible) {
            Button("Unfollow", role: .destructive) {
                if let index = FlightClient.shared.UserFlights.firstIndex(of: flight) {
                    FlightClient.shared.removeUserFlight(at: index)
                    alertMessage = "Flight has been removed from your agenda."
                    showAlert = true
                }
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

#Preview {
    let flight = FlightClient.shared.Flights.first!
    return FlightDetailView(flight: flight)
}
