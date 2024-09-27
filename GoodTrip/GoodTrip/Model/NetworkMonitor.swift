//
//  NetworkMonitor.swift
//  GoodTrip
//
//  Created by Ryan Zhou on 3/5/24.
//  A model to check internet connectivity every time the user searches for a new flight

import Foundation
import Network
import os.log

/// Monitors for network connectivity changes and updates the `isConnected` property accordingly.
class NetworkMonitor: ObservableObject {
    @Published var isConnected: Bool = true // Tracks the current network connection status.
    private let monitor: NWPathMonitor // The network path monitor.
    private let queue = DispatchQueue(label: "NetworkMonitor") // Serial queue for the monitor to run on.

    static let shared = NetworkMonitor()
    
    private let logger = Logger(subsystem: "com.example.GoodTrip", category: "NetworkMonitor")

    private init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                self?.logger.log("Network status updated. Connected: \(self?.isConnected == true ? "Yes" : "No")")
            }
        }
        monitor.start(queue: queue)
        logger.log("Network monitoring started")
    }

    deinit {
        monitor.cancel()
        logger.log("Network monitoring stopped")
    }
}
