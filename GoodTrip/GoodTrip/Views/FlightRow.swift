//
//  FlightRow.swift
//  GoodTrip
//
//  Created by Yutong Sun on 2/29/24.
//

import SwiftUI

struct FlightRow: View {
    let flight: Flight
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: flight.airlineImage ?? "")) { phase in
                switch phase {
                    /// Empty search results
                    case .empty:
                        Image(systemName: "person.crop.circle.badge.questionmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding(.trailing, 10)
                    /// Successful search results displaying resulted airline image
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding(.trailing, 10)
                    /// Failed searching result icon
                    case .failure:
                        Image(systemName: "exclamationmark.icloud")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding(.trailing, 10)
                    /// empty view as the default case
                    @unknown default:
                        EmptyView()
                }
            }
            
            /// Displaying flight details
            VStack(alignment: .leading, content: {
                Text(flight.DepartureDate!)
                Text(flight.DepartureCity! + " -> " + flight.ArrivalCity!)
                Text(flight.flightNumber)
                Text(flight.airline)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            })
            .padding(.leading, 10)

            
        
        .padding(10)
     
        }
    }
}

#Preview {
    let flight = FlightClient.shared.Flights.first!
    return FlightRow(flight: flight)
        .previewLayout(.fixed(width: 400, height: 80))
}
