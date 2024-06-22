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
                VStack(alignment: .leading) {
                    Text(result.trackName)
                        .font(.headline)
                    Text(result.collectionName)
                        .font(.caption)
                }
            }
        }
        .task {
            await loadData()
        }
    }
    func loadData() async {
        // 1: read url
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Error: Invalid url")
            return
        }
        do {
            // 2: fetch data
            let (data, _) = try await URLSession.shared.data(from: url)
            // 3: decode data
            if let decoded = try? JSONDecoder().decode(Response.self, from: data) {
                results = decoded.results
            }
        } catch {
            print("Error: Invalid data")
        }
    }
}

#Preview {
    ContentView()
}
