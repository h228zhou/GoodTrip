//
//  ProfileSummary.swift
//  GoodTrip
//
//  Created by Ryan Zhou on 3/5/24.
//

import SwiftUI

struct ProfileSummary: View {
    var profile: Profile
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(profile.username)
                    .bold()
                    .font(.title)
                Divider()
                
                Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
            }
            .padding()
        }
    }
}

#Preview {
    ProfileSummary(profile: Profile.default)
}
