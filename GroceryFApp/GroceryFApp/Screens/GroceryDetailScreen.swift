//
//  GroceryDetailScreen.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 07/09/26.
//

import SwiftUI

struct GroceryDetailScreen: View {
    
    let groceryCategory: GroceryCategoryResponseDTO
    @State private var isPresented: Bool = false
    @EnvironmentObject private var model: GroceryModel
    
    private func populateeGroceryItems() async{
        do{
            try await model.populateGroceryItemsBy(groceryCategoryId: groceryCategory.id)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    private func deleteGroceryItem(groceryItemId: UUID){
        Task{
            do{
                try await model.deleteGroceryItem(groceryCategoryId: groceryCategory.id, groceryItemId: groceryItemId)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack{
                if model.groceryItems.isEmpty{
                    Text("No items found")
                        .fontWeight(.semibold)
                } else {
                    GroceryItemListView(groceryItems: model.groceryItems, onDelete: deleteGroceryItem)
                }
            }.navigationTitle(groceryCategory.title)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Add grocery item"){
                            isPresented = true
                        }
                    }
                }.sheet(isPresented: $isPresented){
                        AddGroceryItemScreen()
                    
                }
                .onAppear {
                    model.groceryCategory = groceryCategory
                }
                .task {
                    await populateeGroceryItems()
                }
        }
    }
}

#Preview {
    GroceryDetailScreen(groceryCategory: GroceryCategoryResponseDTO(id: UUID(), title: "Fish", image: "https://880noticias-prod-us-west-1.s3.us-west-1.amazonaws.com/wp_media/2024/03/12/image/Pescados-y-mariscos-portada.jpg")).environmentObject(GroceryModel())
}
