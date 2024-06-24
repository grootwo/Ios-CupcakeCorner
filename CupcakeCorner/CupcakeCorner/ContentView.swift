//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Groo on 6/22/24.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    var body: some View {
        Button("tap count: \(tapCount)") {
            tapCount += 1
        }
        .sensoryFeedback(.impact(flexibility: .soft, intensity: 1), trigger: tapCount)
    }
}

#Preview {
    ContentView()
}
