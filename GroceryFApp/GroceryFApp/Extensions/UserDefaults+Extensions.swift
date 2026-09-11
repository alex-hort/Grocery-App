//
//  UserDefaults+Extensions.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 04/09/26.
//

import Foundation


extension UserDefaults{
    
    var userId: UUID? {
        get{
            guard let userIdAsString = string(forKey: "userId") else {
                return nil
            }
            return UUID(uuidString: userIdAsString)
        }
        
        set {
            set(newValue?.uuidString, forKey: "userId")
        }
    }
}
