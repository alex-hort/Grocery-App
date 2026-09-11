//
//  String+Extensions.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 29/08/26.
//

import Foundation

extension String{
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

