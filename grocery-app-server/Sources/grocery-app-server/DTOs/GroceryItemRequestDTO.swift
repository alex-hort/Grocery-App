//
//  GroceryItemRequestDTO.swift
//  grocery-app-server
//
//  Created by Alexis Horteales Espinosa on 06/09/26.
//

import Foundation
import Vapor

struct GroceryItemRequestDTO: Content{
    let title: String
    let price: Double
    let quantity: Int
    
    init(title: String, price: Double, quantity: Int) {
        self.title = title
        self.price = price
        self.quantity = quantity
    }
}


struct GroceryItemResponsetDTO: Content{
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
