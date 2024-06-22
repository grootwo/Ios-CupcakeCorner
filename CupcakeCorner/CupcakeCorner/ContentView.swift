//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Groo on 6/22/24.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var email = ""
    var IsDisabled: Bool {
        name.count < 5 || email.count < 5
    }
    var body: some View {
        Form {
            Section {
                TextField("name", text: $name)
                TextField("email", text: $email)
            }
            Section {
                Button("Create an account") {
                    print("create!")
                }
            }
            .disabled(IsDisabled)
        }
    }
}

#Preview {
    ContentView()
}
