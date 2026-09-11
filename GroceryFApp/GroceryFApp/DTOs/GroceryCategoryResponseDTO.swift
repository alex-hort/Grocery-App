//
//  GroceryCategoryResponseDTO.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 04/09/26.
//
import Foundation


struct GroceryCategoryResponseDTO: Codable{
    let id: UUID
    let title: String
    let image: String
    
    init(id: UUID, title: String, image: String) {
        self.id = id
        self.title = title
        self.image = image
    }
}

extension GroceryCategoryResponseDTO: Identifiable, Hashable{
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: GroceryCategoryResponseDTO, rhs: GroceryCategoryResponseDTO) -> Bool{
        return lhs.id == rhs.id
    }
}

