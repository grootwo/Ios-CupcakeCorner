//
//  Order.swift
//  CupcakeCorner
//
//  Created by Groo on 6/24/24.
//

import Foundation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    var name = "" {
        didSet {
            UserDefaults.standard.setValue(name, forKey: "Name")
        }
    }
    var streetAddress = "" {
        didSet {
            UserDefaults.standard.setValue(streetAddress, forKey: "StreetAddress")
        }
    }
    var city = "" {
        didSet {
            UserDefaults.standard.setValue(city, forKey: "City")
        }
    }
    var zip = "" {
        didSet {
            UserDefaults.standard.setValue(zip, forKey: "Zip")
        }
    }
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return false
        }
        return true
    }
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    init() {
        self.name = UserDefaults.standard.string(forKey: "Name") ?? ""
        self.streetAddress = UserDefaults.standard.string(forKey: "StreetAddress") ?? ""
        self.city = UserDefaults.standard.string(forKey: "City") ?? ""
        self.zip = UserDefaults.standard.string(forKey: "Zip") ?? ""
    }
}
