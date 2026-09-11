//
//  AddGroceryItemScreen.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 07/09/26.
//

import SwiftUI

struct AddGroceryItemScreen: View {
    
    @State private var title: String = ""
    @State private var price: Double? = nil
    @State private var quantity: Int? = nil
    
    @EnvironmentObject private var model: GroceryModel
    
    @Environment(\.dismiss) private var dismiss
    
    private var isFormValid: Bool {
        guard let price = price,
              let quantity = quantity else {
            return false
        }
        return !title.isEmptyOrWhiteSpace && price > 0 && quantity > 0
    }
    
    private func saveGroceryItem() async{
        //get the selected grocery item
        guard let groceryCategory = model.groceryCategory,
              let price = price,
              let quantity = quantity
        else {return}
        let groceryItemRequestDTO = GroceryItemRequestDTO(title: title, price: price, quantity: quantity)
        
        do{
            try await model.saveGroceryItem(groceryItemRequestDTO, groceryCategoryId: groceryCategory.id)
            dismiss()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        
      
            NavigationStack{
                Form{
                    TextField("Title", text: $title)
                    TextField("Price", value: $price, format:.currency(code: Locale.current.currencySymbol ?? ""))
                    TextField("Quantity", value: $quantity, format: .number)
                    
                }.navigationTitle("New Grocery Item")
                    .toolbar{
                        ToolbarItem(placement: .topBarLeading){
                            Button{
                                dismiss()
                            }label: {
                                Text("Close")
                            }
                        }
                        
                        ToolbarItem(placement: .topBarTrailing){
                            Button{
                                Task{
                                    await saveGroceryItem()
                                }
                            }label: {
                                Text("Save")
                            }
                        }
                    }
            }
        
    }
}

#Preview {
    AddGroceryItemScreen()
}
