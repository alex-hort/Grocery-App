//
//  GroceryItemResponseDTO.swift
//  grocery-app-server
//
//  Created by Alexis Horteales Espinosa on 06/09/26.
//

import Foundation
import Fluent
import Vapor


extension GroceryItemResponsetDTO{
    
    init?(_ groceryItem: GroceryItem){
        
        guard let groceryItemId = groceryItem.id else {
            return nil
        }
        self.init(id: groceryItemId,
                  title: groceryItem.title,
                  price: groceryItem.price,
                  quantity: groceryItem.quantity,
        )
    }
}
