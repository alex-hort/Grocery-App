//
//  GroceryCategoryResponseDTO.swift
//  grocery-app-server
//
//  Created by Alexis Horteales Espinosa on 02/09/26.
//
import Foundation
import Vapor

struct GroceryCategoryResponseDTO: Content{
    let id: UUID
    let title: String
    let image: String
    
    init(id: UUID, title: String, image: String) {
        self.id = id
        self.title = title
        self.image = image
    }
}
