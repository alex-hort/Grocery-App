//
//  Image+Extesions.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 05/09/26.
//

import UIKit

extension UIImage {
    func resized(toMaxDimension maxDimension: CGFloat) -> UIImage? {
        let widthRatio = maxDimension / size.width
        let heightRatio = maxDimension / size.height
        let scale = min(widthRatio, heightRatio, 1.0) // no agrandar imágenes pequeñas

        let newSize = CGSize(width: size.width * scale, height: size.height * scale)

        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
