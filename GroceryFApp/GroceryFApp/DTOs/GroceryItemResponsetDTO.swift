//
//  GroceryItemResponsetDTO.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 07/09/26.
//

import Foundation

struct GroceryItemResponsetDTO: Codable{
    let id: UUID
    let title: String
    let price: Double
    let quantity: Int
    
    init(id: UUID, title: String, price: Double, quantity: Int) {
        self.id = id
        self.title = title
        self.price = price
        self.quantity = quantity
    }
}

extension GroceryItemResponsetDTO: Identifiable{
    
}
