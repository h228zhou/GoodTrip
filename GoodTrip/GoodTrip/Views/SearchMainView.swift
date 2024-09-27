//
//  SearchMainView.swift
//  GoodTrip
//
//  Created by Ryan Zhou on 2/26/24.
//

import SwiftUI

struct SearchMainView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    Image("Goodtrip 1")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding()
                    Text("Search your upcoming flight using one of the following options!!")
                        .padding()
                        .background(Color.mint)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .padding()
                }
                Spacer()
                NavigationLink(destination: SearchByFlightNumberView()) {
                    Text("Search by Flight Number")
                        .padding()
                }
                
                NavigationLink(destination: SearchByDateView()) {
                    Text("Search by Date")
                        .padding()
                }
                Spacer()
            }
        }
    }
}

#Preview {
    SearchMainView()
}
