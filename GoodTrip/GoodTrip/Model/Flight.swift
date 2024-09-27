//
//  Flight.swift
//  GoodTrip
//
//  Created by Ryan Zhou on 2/26/24.
//

import Foundation
import MapKit
import os.log

private let logger = Logger(subsystem: "com.example.GoodTrip", category: "FlightData")

/// A structure to represent flight data
struct Flight: Codable, Identifiable, Hashable {
    /// Unique ID of the flight
    var id = UUID()
    /// Airline Name
    var airline: String
    /// Flight number
    var flightNumber: String
    /// Departing airport name in 3 capital letters
    var departureAirport: String
    /// Arriving airport name in 3 capital letters
    var arrivalAirport: String
    /// Departure time in ISO 8601 format
    var departureTimestamp: String
    /// Arrival time in ISO 8601 format
    var arrivalTimestamp: String
    /// Departure terminal name
    var departureTerminal: String
    /// Arrival terminal name
    var arrivalTerminal: String
    /// Departure Gate
    var gate: String
    ///Arrival Baggage Claim
    var baggageClaim: String
    ///Arrival Gate
    var arrivalGate: String
    
    /// Returns an optional airline image URL as a String
    var airlineImage: String? {
        logger.log("Requesting image for airline: \(self.airline)")
        return AirlineClient.shared.image(forAirline: self.airline)
    }
    
    /// Formats the departure date into a readable format
    var DepartureDate: String? {
        logger.log("Formatting departure date for flight: \(self.flightNumber)")
        return FlightClient.formatDate(date: departureTimestamp, timeZone: AirportClient.shared.airportTimeZone(forCode: self.departureAirport)!)
    }
    
    /// Formats the arrival date into a readable format
    var ArrivalDate: String? {
        logger.log("Formatting arrival date for flight: \(self.flightNumber)")
        return FlightClient.formatDate(date: arrivalTimestamp, timeZone: AirportClient.shared.airportTimeZone(forCode: self.arrivalAirport)!)
    }
    
    /// Formats the departure time into a readable format
    var DepartureTime: String? {
        logger.log("Formatting departure time for flight: \(self.flightNumber)")
        return FlightClient.formatTime(date: departureTimestamp,timeZone: AirportClient.shared.airportTimeZone(forCode: self.departureAirport)!)
    }
    
    /// Formats the arrival time into a readable format
    var ArrivalTime: String? {
        logger.log("Formatting arrival time for flight: \(self.flightNumber)")
        return FlightClient.formatTime(date: arrivalTimestamp, timeZone: AirportClient.shared.airportTimeZone(forCode: self.arrivalAirport)!)
    }
    
    /// Calculates the estimated flight time
    var estimatedFlightTime: String? {
        logger.log("Calculating estimated flight time for flight: \(self.flightNumber)")
        return FlightClient.calculateFlightDuration(departure: departureTimestamp, arrival: arrivalTimestamp)
    }
    
    /// Returns the departure city
    var DepartureCity: String? {
        logger.log("Fetching departure city for airport: \(self.departureAirport)")
        return AirportClient.shared.airportCity(forCode: self.departureAirport)
    }
    
    /// Returns the arrival city
    var ArrivalCity: String? {
        logger.log("Fetching arrival city for airport: \(self.arrivalAirport)")
        return AirportClient.shared.airportCity(forCode: self.arrivalAirport)
    }
    
    /// Provides the geographic location of the departure airport
    var DepartureLocation: CLLocationCoordinate2D {
        AirportClient.shared.airportLocation(forCode: self.departureAirport) ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    
    /// Provides the geographic location of the arrival airport
    var ArrivalLocation: CLLocationCoordinate2D {
        AirportClient.shared.airportLocation(forCode: self.arrivalAirport) ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    
}

extension Flight: Equatable {
    static func == (lhs: Flight, rhs: Flight) -> Bool {
        return lhs.flightNumber == rhs.flightNumber && lhs.departureAirport == rhs.departureAirport && lhs.arrivalAirport == rhs.arrivalAirport && lhs.departureTimestamp == rhs.departureTimestamp && lhs.arrivalTimestamp == rhs.arrivalTimestamp
    }
}
