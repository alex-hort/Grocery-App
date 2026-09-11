//
//  AddGroceryCategoryScreen.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 02/09/26.
//

import SwiftUI
import PhotosUI

struct AddGroceryCategoryScreen: View {
    
    @EnvironmentObject private var model: GroceryModel

    @State private var title: String = ""
    @State private var image: UIImage? = nil
    @Environment(\.dismiss) private var dismiss

    private func saveGroceryCategory() async {
        guard let image else {
            return
        }

        guard let resizedImage = image.resized(toMaxDimension: 800),
              let imageData = resizedImage.jpegData(compressionQuality: 0.6) else {
            return
        }
        let base64Image = imageData.base64EncodedString()

        let groceryCatgoryRequestDTO = GroceryCategoryRequestDTO(
            title: title,
            image: base64Image)

        do {
            try await model.saveGroceryCategory(groceryCatgoryRequestDTO)
            dismiss()
            // Refresca la lista después de guardar
            try await model.populateGroceryCategories()
        } catch {
            print(error.localizedDescription)
        }
    }
    
   

    private var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo
                Image("a")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(0.7)
                    .shadow(radius: 2)

                VStack(spacing: 24) {

                    // Card: title field + choose image button
                    VStack(spacing: 16) {
                        TextField("Grocery Item Title", text: $title)
                            .padding()
                            .glassEffect()
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                        ImageSelector(image: $image)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                  

                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("New Category")
                        .font(.system(.title2, design: .rounded, weight: .medium))
                }
            
                ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Close")
                        }
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            Task {
                                await saveGroceryCategory()
                            }
                        } label: {
                            Text("Save")
                        }
                        .disabled(!isFormValid)
                    }
            }
        }
        
    }
}



#Preview {
    AddGroceryCategoryScreen().environmentObject(GroceryModel())
}
