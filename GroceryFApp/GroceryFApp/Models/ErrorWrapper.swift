//
//  ErrorWrapper.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 09/09/26.
//

import Foundation


struct ErrorWrapper: Identifiable{
    let id = UUID()
    let error: Error
    let guiadance: String
}
