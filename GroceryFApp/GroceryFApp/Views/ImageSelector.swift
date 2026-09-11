//
//  ImageSelector.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 02/09/26.
//


import SwiftUI
import PhotosUI

struct ImageSelector: View {

    @Binding var image: UIImage?

    @State private var pickerItem: PhotosPickerItem?

    var body: some View {
        VStack(spacing: 16) {

            PhotosPicker(
                selection: $pickerItem,
                matching: .images,
                photoLibrary: .shared()
            ) {
                Text("Choose image")
                    .fontWeight(.light)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(red: 0.78, green: 0.36, blue: 0.16)) .opacity(0.9)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }
        }
        .onChange(of: pickerItem) { _, newItem in
            guard let newItem else { return }

            Task {
                do {
                    if let data = try await newItem.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        image = uiImage
                    }
                } catch {
                    print("Error al cargar la imagen: \(error)")
                }
            }
        }
    }
}

#Preview {
    ImageSelector(image: .constant(nil))
}

