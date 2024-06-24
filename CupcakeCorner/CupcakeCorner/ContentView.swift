//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Groo on 6/22/24.
//

import SwiftUI

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
        case _password = "password"
    }
    var name = "New User"
    var password = 1234
}

struct ContentView: View {
    var body: some View {
        Button("Decode & Encode", action: encodeUser)
    }
    func encodeUser() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
}

#Preview {
    ContentView()
}
