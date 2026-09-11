//
//  GroceryCategoryRequestDTO.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 04/09/26.
//

import Foundation


struct GroceryCategoryRequestDTO: Codable{
    let title: String
    let image: String
    
    init(title: String, image: String) {
        self.title = title
        self.image = image
    }
}
