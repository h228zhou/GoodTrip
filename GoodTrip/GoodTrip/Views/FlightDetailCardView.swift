//
//  FlightDetailCardView.swift
//  GoodTrip
//
//  Created by Yutong Sun on 3/2/24.
//

import SwiftUI

struct FlightDetailCardView: View {
    let title: String
    let info: String

    var body: some View {
        // creating result cards
        VStack(alignment: .center, spacing: 10) {
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            Text(info)
                .multilineTextAlignment(.center)
        }
        .padding() // 添加内边距
        .frame(maxWidth: 135, maxHeight: 150)
        .background(Color.green)
        .cornerRadius(30)
        .padding()
    }
}

#Preview {
    let title = "Gate"
    let info = "A2"
    return FlightDetailCardView(title: title, info: info)
        .previewLayout(.fixed(width: 135, height: 150))
}
