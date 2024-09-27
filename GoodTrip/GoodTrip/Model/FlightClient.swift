//
//  FlightClient.swift
//  GoodTrip
//
//  Created by Ryan Zhou on 2/26/24.
//

import Foundation
import Combine
import os.log

private let flightClientLogger = Logger(subsystem: "com.example.GoodTrip", category: "FlightClient")

class FlightClient: ObservableObject {
    @Published var Flights : [Flight] = []
    @Published var SearchResultsFlights : [Flight] = []
    @Published var UserFlights : [Flight] = []
    
    fileprivate init(){
        loadUserFlights()
        /// Creating fake data for project testing
        Flights = [
            Flight(airline: "Air Canada", flightNumber: "CA1212", departureAirport: "ORD", arrivalAirport: "YYZ", departureTimestamp: "2024-03-06T13:46:52Z", arrivalTimestamp: "2024-03-06T18:46:52Z", departureTerminal: "1", arrivalTerminal: "1", gate: "G5", baggageClaim: "3", arrivalGate: "D2"),
            Flight(airline: "United Airlines", flightNumber: "UA0657", departureAirport: "ORD", arrivalAirport: "YYZ", departureTimestamp: "2024-03-06T11:46:52Z", arrivalTimestamp: "2024-03-06T17:46:52Z", departureTerminal: "1", arrivalTerminal: "1", gate: "G5", baggageClaim: "3", arrivalGate: "D2"),
            Flight(airline: "Delta Air Lines", flightNumber: "DL186", departureAirport: "ORD", arrivalAirport: "YYZ", departureTimestamp: "2024-03-06T08:46:52Z", arrivalTimestamp: "2024-03-06T13:46:52Z", departureTerminal: "1", arrivalTerminal: "1", gate: "G5", baggageClaim: "3", arrivalGate: "D2"),
            Flight(airline: "Delta Air Lines", flightNumber: "DL123", departureAirport: "JFK", arrivalAirport: "LAX", departureTimestamp: "2024-03-06T08:00:00Z", arrivalTimestamp: "2024-03-06T11:00:00Z", departureTerminal: "2", arrivalTerminal: "4", gate: "A7", baggageClaim: "1", arrivalGate: "C3"),
            Flight(airline: "American Airlines", flightNumber: "AA456", departureAirport: "LAX", arrivalAirport: "DFW", departureTimestamp: "2024-03-06T12:30:00Z", arrivalTimestamp: "2024-03-06T15:30:00Z", departureTerminal: "3", arrivalTerminal: "B", gate: "B4", baggageClaim: "B12", arrivalGate: "A1"),
            Flight(airline: "United Airlines", flightNumber: "UA789", departureAirport: "ORD", arrivalAirport: "SFO", departureTimestamp: "2024-03-08T10:15:00Z", arrivalTimestamp: "2024-03-08T13:30:00Z", departureTerminal: "1", arrivalTerminal: "3", gate: "C9", baggageClaim: "5", arrivalGate: "E4"),
            Flight(airline: "Southwest Airlines", flightNumber: "WN101", departureAirport: "LAS", arrivalAirport: "DEN", departureTimestamp: "2024-03-12T09:45:00Z", arrivalTimestamp: "2024-03-12T12:15:00Z", departureTerminal: "1", arrivalTerminal: "C", gate: "E12", baggageClaim: "2", arrivalGate: "B3"),
            Flight(airline: "JetBlue Airways", flightNumber: "B6222", departureAirport: "BOS", arrivalAirport: "MCO", departureTimestamp: "2024-03-15T11:20:00Z", arrivalTimestamp: "2024-03-15T14:30:00Z", departureTerminal: "C", arrivalTerminal: "A", gate: "D5", baggageClaim: "A4", arrivalGate: "C6"),
            Flight(airline: "Alaska Airlines", flightNumber: "AS333", departureAirport: "SEA", arrivalAirport: "SAN", departureTimestamp: "2024-03-18T14:00:00Z", arrivalTimestamp: "2024-03-18T16:30:00Z", departureTerminal: "N", arrivalTerminal: "2", gate: "F8", baggageClaim: "4", arrivalGate: "G1"),
            Flight(airline: "Spirit Airlines", flightNumber: "NK444", departureAirport: "FLL", arrivalAirport: "ATL", departureTimestamp: "2024-03-22T08:45:00Z", arrivalTimestamp: "2024-03-22T11:30:00Z", departureTerminal: "1", arrivalTerminal: "D", gate: "A10", baggageClaim: "5", arrivalGate: "G21"),
            Flight(airline: "Frontier Airlines", flightNumber: "F9555", departureAirport: "MCO", arrivalAirport: "PHX", departureTimestamp: "2024-03-25T13:10:00Z", arrivalTimestamp: "2024-03-25T15:45:00Z", departureTerminal: "A", arrivalTerminal: "3", gate: "I5", baggageClaim: "1", arrivalGate: "H2"),
            Flight(airline: "Hawaiian Airlines", flightNumber: "HA777", departureAirport: "HNL", arrivalAirport: "SFO", departureTimestamp: "2024-03-30T10:30:00Z", arrivalTimestamp: "2024-03-30T14:00:00Z", departureTerminal: "3", arrivalTerminal: "2", gate: "5", baggageClaim: "2", arrivalGate: "C4")

        ]
    }
    // Singleton instance for global access
    static let shared = FlightClient()
    
    /// Formats the given ISO 8601 date string to a more user-friendly date format.
    /// - Parameters:
    ///   - date: The ISO 8601 date string.
    ///   - timeZone: The timezone identifier for the date conversion.
    /// - Returns: A user-friendly date string or nil if conversion fails.
    static func formatDate(date: String, timeZone: String) -> String? {
        flightClientLogger.debug("Formatting date: \(date, privacy: .public) with timeZone: \(timeZone, privacy: .public)")
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        dateFormatterPrint.timeZone = TimeZone(identifier: timeZone) // Setting the time zone

        if let curdate = dateFormatterGet.date(from: date) {
            return dateFormatterPrint.string(from: curdate)
        } else {
            return nil
        }
    }
    
    /// Formats the given ISO 8601 date string to a user-friendly time format.
    /// - Parameters:
    ///   - date: The ISO 8601 date string.
    ///   - timeZone: The timezone identifier for the time conversion.
    /// - Returns: A user-friendly time string or nil if conversion fails.
    static func formatTime(date: String, timeZone: String) -> String? {
        flightClientLogger.debug("Formatting time: \(date, privacy: .public) with timeZone: \(timeZone, privacy: .public)")
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let timeFormatterPrint = DateFormatter()
        timeFormatterPrint.dateFormat = "HH:mm"
        timeFormatterPrint.timeZone = TimeZone(identifier: timeZone) // Setting the time zone

        if let curdate = dateFormatterGet.date(from: date) {
            return timeFormatterPrint.string(from: curdate)
        } else {
            return nil
        }
    }
    
    /// Calculates the duration between the departure and arrival times of a flight.
    /// - Parameters:
    ///   - departure: The departure time as an ISO 8601 date string.
    ///   - arrival: The arrival time as an ISO 8601 date string.
    /// - Returns: A string describing the flight duration in hours and minutes, or nil if calculation fails.
    static func calculateFlightDuration(departure: String, arrival: String) -> String? {
        flightClientLogger.debug("Calculating flight duration from \(departure, privacy: .public) to \(arrival, privacy: .public)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        guard let departureDate = dateFormatter.date(from: departure),
              let arrivalDate = dateFormatter.date(from: arrival) else {
            return nil
        }

        let flightDuration = arrivalDate.timeIntervalSince(departureDate)
        let hours = Int(flightDuration) / 3600
        let minutes = Int(flightDuration) % 3600 / 60

        return "\(hours) hours \(minutes) minutes"
    }
    /// Searches for flights by a specific flight number.
    /// - Parameter flightNumber: The flight number to search for.
    func searchFlights(byFlightNumber flightNumber: String) {
        flightClientLogger.debug("Searching for flights with flight number: \(flightNumber, privacy: .public)")
        // Filter flights where flight number matches the search query
        SearchResultsFlights = Flights.filter { $0.flightNumber.lowercased() == flightNumber.lowercased() }
    }
    
    /// Saving user flights to the agenda
    func saveUserFlights() {
        flightClientLogger.debug("Saving user flights to UserDefaults")
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(UserFlights) {
            UserDefaults.standard.set(encoded, forKey: "UserFlights")
        } else {
            flightClientLogger.error("Failed to encode UserFlights for saving")
        }
    }
    
    /// Loading user flights agenda
    func loadUserFlights() {
        flightClientLogger.debug("Loading user flights from UserDefaults")
        let decoder = JSONDecoder()
        if let savedFlights = UserDefaults.standard.object(forKey: "UserFlights") as? Data {
            if let loadedFlights = try? decoder.decode([Flight].self, from: savedFlights) {
                UserFlights = loadedFlights
                sortUserFlightsByDepartureTimestamp()
            } else {
                flightClientLogger.error("Failed to decode UserFlights from UserDefaults")
            }
        }
    }
    
    /// Checks if a particular flight is already added to the user's saved flights.
    /// - Parameter flight: The flight to check.
    /// - Returns: Boolean value indicating whether the flight is in the user's saved flights.
    func isFlightInUserFlights(_ flight: Flight) -> Bool {
        flightClientLogger.debug("Checking if flight \(flight.flightNumber, privacy: .public) is in UserFlights")
        return UserFlights.contains(flight)
    }
    
    /// Adds a flight to the user's saved flights if it's not already added.
    /// - Parameter flight: The flight to add.
    func addUserFlight(flight: Flight) {
        flightClientLogger.debug("Attempting to add flight \(flight.flightNumber, privacy: .public) to UserFlights")

        if !isFlightInUserFlights(flight){
            UserFlights.append(flight)
            saveUserFlights()
            /// Scheduling notification before departure
            scheduleNotificationForFlight(departureTimestamp: flight.departureTimestamp)
            flightClientLogger.debug("Flight \(flight.flightNumber, privacy: .public) added and saved. Scheduling notification.")
        } else {
            flightClientLogger.info("Flight \(flight.flightNumber, privacy: .public) is already in UserFlights")
        }
    }
    
    /// Removes a flight from the user's saved flights.
    /// - Parameter index: The index of the flight to remove in the UserFlights array.
    func removeUserFlight(at index: Int) {
        flightClientLogger.debug("Removing flight \(index, privacy: .public) from UserFlights")
        UserFlights.remove(at: index)
        saveUserFlights()
    }
    
    /// Sorting the flights in the agenda by Departure Time
    func sortUserFlightsByDepartureTimestamp() {
        flightClientLogger.debug("Sorting UserFlights by departure timestamp")
        UserFlights.sort { $0.departureTimestamp < $1.departureTimestamp }
    }
    /// Searches for flights based on departure and arrival airports, and a specific date.
    /// - Parameters:
    ///   - departureAirport: The airport code for the departure airport.
    ///   - arrivalAirport: The airport code for the arrival airport.
    ///   - date: The date of departure.
    func searchFlights(departureAirport: String, arrivalAirport: String, date: Date) {
        flightClientLogger.debug("Searching for flights from \(departureAirport, privacy: .public) to \(arrivalAirport, privacy: .public) on date \(date, privacy: .public)")

        // Convert the selectedDate to a format that matches your flight data's date format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust if necessary
        let selectedDateString = dateFormatter.string(from: date)
        
        SearchResultsFlights = Flights.filter { flight in
            let flightDepartureDate = flight.departureTimestamp.prefix(10) // Assuming 'departureTimestamp' is a String
            return flight.departureAirport == departureAirport &&
                   flight.arrivalAirport == arrivalAirport &&
                   flightDepartureDate == selectedDateString
        }
    }
}


