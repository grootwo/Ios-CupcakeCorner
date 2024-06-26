//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Groo on 6/25/24.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                Text("Your cost is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place Order") {
                    Task {
                        if !(await placeOrder()) {
                            confirmationMessage = "Failed to place order. Please check if you're in proper environment."
                            showingConfirmation = true
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check Out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("Okay") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    func placeOrder() async -> Bool{
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Error: Failed to encode order")
            return false
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
            return true
        } catch {
            print("Error: Get \(error.localizedDescription)")
            return false
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
