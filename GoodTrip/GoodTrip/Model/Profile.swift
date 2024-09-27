//
//  Profile.swift
//  GoodTrip
//
//  Created by Ryan Zhou on 3/5/24.
//

import Foundation

struct Profile {
    var username: String
    var prefersNotifications = true
    
    static let `default` = Profile(username: "Donald Trump")
}
