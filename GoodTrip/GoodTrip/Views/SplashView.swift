//
//  SplashView.swift
//  GoodTrip
//
//  Created by Yutong Sun on 3/1/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.blue, Color(red: 0.7, green: 0.7, blue: 0.9)]),
                           center: .center,
                           startRadius: 20,
                           endRadius: 500)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("GoodTrip")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Image("GoodTrip")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                
                Text("Hao Yu Zhou & Yutong Sun")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.white)
            }
            .padding() 
        }
    }
}

#Preview {
    SplashView()
}
