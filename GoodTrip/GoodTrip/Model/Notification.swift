//
//  Notification.swift
//  GoodTrip
//
//  Created by Ryan Zhou on 3/5/24.
//

import Foundation
import UserNotifications
import os.log

private let notificationLogger = Logger(subsystem: "com.example.GoodTrip", category: "Notifications")

/// Schedules a notification to alert the user about an upcoming flight.
/// - Parameter departureTimestamp: The ISO 8601 formatted departure timestamp of the flight.
func scheduleNotificationForFlight(departureTimestamp: String) {
    notificationLogger.debug("Attempting to schedule notification for flight at \(departureTimestamp, privacy: .public)")

    // Convert timestamp to Date object
    guard let departureDate = convertTimestampToDate(departureTimestamp) else {
        notificationLogger.error("Invalid departure date provided: \(departureTimestamp, privacy: .public)")
        print("Invalid departure date")
        return
    }
    
    let notificationContent = UNMutableNotificationContent()
    notificationContent.title = NSString.localizedUserNotificationString(forKey: "Flight Reminder", arguments: nil)
    notificationContent.body = NSString.localizedUserNotificationString(forKey: "Your flight is departing soon.", arguments: nil)
    notificationContent.sound = UNNotificationSound.default
    // Calculate the date to trigger the notification (1 hour before departure)
    guard let triggerDate = Calendar.current.date(byAdding: .hour, value: -1, to: departureDate) else {
        notificationLogger.error("Failed to calculate trigger date for notification.")
        return
    }
    
    // Create the trigger for the notification
    let triggerDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)
    
    // Create the request
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
    
    // Schedule the notification
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.add(request) { (error) in
       if let error = error {
           notificationLogger.error("Error scheduling notification: \(error.localizedDescription, privacy: .public)")
           // Handle any errors
           print("Error scheduling notification: \(error.localizedDescription)")
       } else {
           notificationLogger.debug("Notification successfully scheduled.")
       }
    }
}

/// Converts an ISO 8601 formatted timestamp into a Date object.
/// - Parameter timestamp: The ISO 8601 formatted timestamp.
/// - Returns: The Date object corresponding to the timestamp, or nil if conversion fails.
func convertTimestampToDate(_ timestamp: String) -> Date? {
    let dateFormatter = ISO8601DateFormatter()
    return dateFormatter.date(from: timestamp)
}
