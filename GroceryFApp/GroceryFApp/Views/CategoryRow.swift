//
//  CategoryRow.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 04/09/26.
//
import SwiftUI

struct CategoryRow: View {

    let category: GroceryCategoryResponseDTO

    var body: some View {
        HStack(spacing: 16) {

            if let imageData = Data(base64Encoded: category.image),
               let uiImage = UIImage(data: imageData) {

                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())

            } else {

                Circle()
                    .strokeBorder(Color.blue, lineWidth: 2)
                    .background(
                        Circle()
                            .fill(Color(.systemGray5))
                    )
                    .frame(width: 44, height: 44)
            }

            Text(category.title)
                .font(.system(.body, design: .monospaced))

            Spacer()
        }
    }
}
