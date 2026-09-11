//
//  GroceryCategoryRequestDTO.swift
//  grocery-app-server
//
//  Created by Alexis Horteales Espinosa on 02/09/26.
//

import Foundation
import Vapor

struct GroceryCategoryRequestDTO: Content{
    let title: String
    let image: String
    
    init(title: String, image: String) {
        self.title = title
        self.image = image
    }
}
