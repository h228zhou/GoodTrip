//
//  Airport.swift
//  GoodTrip
//
//  Created by Yutong Sun on 3/2/24.
//

import Foundation
import MapKit
import os.log

private let airportClientLogger = Logger(subsystem: "com.example.GoodTrip", category: "AirportClient")

/// Represents an airport with associated details.
struct Airport: Codable, Hashable {
    var code: String // Airport code, e.g., "ORD" for Chicago O'Hare.
    var city: String // City where the airport is located.
    var latitude: Double // Geographic latitude of the airport.
    var longitude: Double // Geographic longitude of the airport.
    var timeZone: String // Time zone identifier for the airport.
}

class AirportClient {
    static let shared = AirportClient()
    private init() {}
    
    // Dictionary mapping airport codes to Airport structs.
    var airports: [String: Airport] = [
        "ORD": Airport(code: "ORD", city: "Chicago", latitude: 41.9742, longitude: -87.9073, timeZone: "America/Chicago"),
        "YYZ": Airport(code: "YYZ", city: "Toronto", latitude: 43.6777, longitude: -79.6248, timeZone: "America/Toronto"),
        "JFK": Airport(code: "JFK", city: "New York", latitude: 40.6413, longitude: -73.7781, timeZone: "America/New_York"),
        "LAX": Airport(code: "LAX", city: "Los Angeles", latitude: 33.9416, longitude: -118.4085, timeZone: "America/Los_Angeles"),
        "DFW": Airport(code: "DFW", city: "Dallas/Fort Worth", latitude: 32.8998, longitude: -97.0403, timeZone: "America/Chicago"),
        "SFO": Airport(code: "SFO", city: "San Francisco", latitude: 37.6213, longitude: -122.3790, timeZone: "America/Los_Angeles"),
        "LAS": Airport(code: "LAS", city: "Las Vegas", latitude: 36.0840, longitude: -115.1537, timeZone: "America/Los_Angeles"),
        "DEN": Airport(code: "DEN", city: "Denver", latitude: 39.8561, longitude: -104.6737, timeZone: "America/Denver"),
        "BOS": Airport(code: "BOS", city: "Boston", latitude: 42.3656, longitude: -71.0096, timeZone: "America/New_York"),
        "MCO": Airport(code: "MCO", city: "Orlando", latitude: 28.4312, longitude: -81.3081, timeZone: "America/New_York"),
        "SEA": Airport(code: "SEA", city: "Seattle", latitude: 47.4502, longitude: -122.3088, timeZone: "America/Los_Angeles"),
        "SAN": Airport(code: "SAN", city: "San Diego", latitude: 32.7338, longitude: -117.1933, timeZone: "America/Los_Angeles"),
        "FLL": Airport(code: "FLL", city: "Fort Lauderdale", latitude: 26.0742, longitude: -80.1506, timeZone: "America/New_York"),
        "ATL": Airport(code: "ATL", city: "Atlanta", latitude: 33.6407, longitude: -84.4277, timeZone: "America/New_York"),
        "PHX": Airport(code: "PHX", city: "Phoenix", latitude: 33.4484, longitude: -112.0740, timeZone: "America/Phoenix"),
        "HNL": Airport(code: "HNL", city: "Honolulu", latitude: 21.3069, longitude: -157.8583, timeZone: "Pacific/Honolulu")
    ]
    
    /// Returns the city name for a given airport code.
    /// - Parameter code: The airport code.
    /// - Returns: The city name as a string, or nil if the airport code is not found.
    func airportCity(forCode code: String) -> String? {
        airportClientLogger.debug("Fetching city for airport code: \(code, privacy: .public)")
        return airports[code]?.city
    }
    
    /// Returns the time zone identifier for a given airport code.
    /// - Parameter code: The airport code.
    /// - Returns: The time zone identifier as a string, or nil if the airport code is not found.
    func airportTimeZone(forCode code: String) -> String? {
        airportClientLogger.debug("Fetching time zone for airport code: \(code, privacy: .public)")
        return airports[code]?.timeZone
    }
    
    /// Returns the geographic location for a given airport code.
    /// - Parameter code: The airport code.
    /// - Returns: The geographic location as a CLLocationCoordinate2D, or nil if the airport code is not found.
    func airportLocation(forCode code: String) -> CLLocationCoordinate2D? {
        airportClientLogger.debug("Fetching location for airport code: \(code, privacy: .public)")
        guard let airport = airports[code] else {
            airportClientLogger.error("Airport code not found: \(code, privacy: .public)")
            return nil
        }
        return CLLocationCoordinate2D(latitude: airport.latitude, longitude: airport.longitude)
    }
}
