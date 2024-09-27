//
//  GoodTripApp.swift
//  GoodTrip
//
//  Created by Ryan Zhou on 2/26/24.
//

import SwiftUI
import os // Import os for logging
private let logger = Logger(subsystem: "com.example.GoodTrip", category: "Lifecycle")

@main
struct GoodTripApp: App {
    // Initialize the app
    init() {
        // Check for the "Initial Launch" preference
        if UserDefaults.standard.object(forKey: "Initial Launch") == nil {
            logger.log("First launch detected. Setting 'Initial Launch' date.")
            // If not found, this is the first launch. Save the current date
            UserDefaults.standard.set(Date(), forKey: "Initial Launch")
        }
        else{
            // If the "Initial Launch" preference exists, log that this is not the first launch.
            logger.log("Not the first launch.")
        }
    }
    // Shared flights data from FlightClient
    private var sharedFlights = FlightClient.shared
    var body: some Scene {
        WindowGroup {
            ContentView(flights: sharedFlights)
        }
    }
}
