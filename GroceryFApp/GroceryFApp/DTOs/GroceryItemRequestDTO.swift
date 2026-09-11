//
//  GroceryItemRequestDTO.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 07/09/26.
//

import Foundation


struct GroceryItemRequestDTO: Codable{
    let title: String
    let price: Double
    let quantity: Int
    
    init(title: String, price: Double, quantity: Int) {
        self.title = title
        self.price = price
        self.quantity = quantity
    }
}
