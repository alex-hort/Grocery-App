//
//  GroceryCategoryResponseDTO+Exte.swift
//  grocery-app-server
//
//  Created by Alexis Horteales Espinosa on 02/09/26.
//
import Foundation
import Vapor


extension GroceryCategoryResponseDTO{
    
    init?(_ groceryCategory: GroceryCategory){
        guard let id = groceryCategory.id else {
            return nil
        }
        self.init(id: id, title: groceryCategory.title, image: groceryCategory.image)
    }
}
