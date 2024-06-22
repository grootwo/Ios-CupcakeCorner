//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Groo on 6/22/24.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()
    var body: some View {
        List {
            ForEach(results, id: \.trackId) { result in
                VStack {
                    Text(result.trackName)
                        .font(.headline)
                    Text(result.collectionName)
                        .font(.caption)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
