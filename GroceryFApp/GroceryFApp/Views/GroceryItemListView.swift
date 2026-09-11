//
//  GroceryItemListView.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 08/09/26.
//

import SwiftUI

struct GroceryItemListView: View {
    let groceryItems: [GroceryItemResponsetDTO]
    let onDelete: (UUID) -> Void
    
    private func deleteGroceryItem(at offsets: IndexSet){
        offsets.forEach { i in
            let groceryItem = groceryItems[i]
            onDelete(groceryItem.id)
        }
    }
    
    var body: some View {
        List{
            ForEach(groceryItems) { groceryItem in
                Text(groceryItem.title)
                
            }.onDelete(perform: deleteGroceryItem)
        }
    }
}

#Preview {
    GroceryItemListView(groceryItems: [], onDelete: { _ in })
}
