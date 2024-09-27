//
//  ContentView.swift
//  GoodTrip
//
//  Created by Ryan Zhou on 2/26/24.
//

import SwiftUI

struct ContentView: View {
    var flights: FlightClient
    @State var isSplashView: Bool = true
    @State private var showRateAppAlert = false
    @AppStorage("appLaunchCount") private var appLaunchCount: Int = 0
    
    var body: some View {
        if self.isSplashView {
            /// Creating a splash view
            SplashView()
                .onAppear {
                    appLaunchCount += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation {
                            self.isSplashView = false
                        }
                    }
                    
                    // Counting app launches
                    if appLaunchCount == 3 {
                        showRateAppAlert = true
                    }
                }
        } else {
            /// Loading the main view
            TabView {
                SearchMainView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .alert(isPresented: $showRateAppAlert) {
                        // Creating "rate us" alert
                        Alert(
                            title: Text("Rate Us"),
                            message: Text("If you enjoy using the app, please take a moment to rate it in the App Store."),
                            primaryButton: .default(Text("Rate Now"), action: {appLaunchCount = 0}),
                            secondaryButton: .cancel()
                        )
                    }
                
                AgendaView()
                    .tabItem {
                        Label("Agenda", systemImage: "calendar")
                    }
            }
        }
    }
}

#Preview {
    ContentView(flights: FlightClient.shared)
}
