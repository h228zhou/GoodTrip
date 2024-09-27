//
//  Airline.swift
//  GoodTrip
//
//  Created by Yutong Sun on 3/2/24.
//

import Foundation
import os.log

private let airlineLogger = Logger(subsystem: "com.example.GoodTrip", category: "AirlineClient")

/// Represents an airline, including its name and a URL for its logo image.
struct Airline: Codable, Hashable {
    var name: String
    var image: String
}

/// `AirlineClient` is responsible for managing and providing information about airlines, including their names and logo images.
class AirlineClient {
    static let shared = AirlineClient()
    private init() {
        airlineLogger.debug("AirlineClient initialized")
    }
    // Dictionary mapping airline names to `Airline` structs, which include name and image URL.
    var airlines: [String: Airline] = [
        "Air Canada": Airline(name: "Air Canada", image: "https://1000logos.net/wp-content/uploads/2020/03/Air-Canada-Logo.png"),
        "Delta Air Lines": Airline(name: "Delta Air Lines", image: "https://news.delta.com/sites/default/files/2021-11/delta_c_r.png"),
        "American Airlines": Airline(name: "American Airlines", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjFRsb2RYeCAGY3CYjbAvXdzf7z8rqv37ORluRKBtRCA&s"),
        "United Airlines": Airline(name: "United Airlines", image: "https://cdn.iconscout.com/icon/free/png-256/free-united-80-282898.png?f=webp"),
        "Southwest Airlines": Airline(name: "Southwest Airlines", image: "https://1000logos.net/wp-content/uploads/2019/08/southwest-airlines-logo.png"),
        "JetBlue Airways": Airline(name: "JetBlue Airways", image: "https://download.logo.wine/logo/JetBlue/JetBlue-Logo.wine.png"),
        "Alaska Airlines": Airline(name: "Alaska Airlines", image: "https://news.alaskaair.com/wp-content/uploads/2022/03/AS_Wordmark_Official_logo_rgb_midnight.png"),
        "Spirit Airlines": Airline(name: "Spirit Airlines", image: "https://play-lh.googleusercontent.com/EAoDg62PBmZAUp5O7BYuwkmKz7IvO9f6tPs2j623xTSnDbXwPUv1ByqRtfkUtGbjwQ"),
        "Frontier Airlines": Airline(name: "Frontier Airlines", image: "https://1000logos.net/wp-content/uploads/2020/03/Frontier-Airlines-Logo.png"),
        "Hawaiian Airlines": Airline(name: "Hawaiian Airlines", image: "https://img.s-hawaiianairlines.com/static/images/brand/refresh/imagenewpualani2x.png?version=a947&sc_lang=en")
    ]
    
    /// Retrieves the image URL for a specified airline name.
    /// - Parameter airline: The name of the airline.
    /// - Returns: The URL string for the airline's image, or `nil` if the airline is not found.
    func image(forAirline airline: String) -> String? {
        airlineLogger.debug("Retrieving image for airline: \(airline, privacy: .public)")
        return airlines[airline]?.image
    }
}
