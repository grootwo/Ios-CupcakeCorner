//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Groo on 6/22/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("Error: Failed to load the image")
            } else {
                ProgressView()
            }
        }
        .frame(width: 100)
    }
}

#Preview {
    ContentView()
}
