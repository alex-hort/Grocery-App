//
//  Contants.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 29/08/26.
//

import Foundation

struct Contants{
    
    private static let baseUrl = "http://127.0.0.1:8080/api"
    
    struct Urls{
        //register
        static let register = URL(string: "\(baseUrl)/register")!
        //login
        static let login = URL(string: "\(baseUrl)/login")!
        
        static func saveGroceryCategoryBy(userId: UUID) -> URL{
            return URL(string: "\(baseUrl)/users/\(userId)/grocery-categories")!
        }
        
        static func groceryCategoriesBy(userId: UUID) -> URL {
            return URL(string: "\(baseUrl)/users/\(userId)/grocery-categories")!
        }
        
        static func deleteGroceryCategory(userId: UUID, groceryCategoryId: UUID) -> URL{
            return URL(string: "\(baseUrl)/users/\(userId)/grocery-categories/\(groceryCategoryId)")!
        }
        
        static func saveGroceryItem(userId: UUID, groceryCategoryId: UUID) -> URL{
            return URL(string: "\(baseUrl)/users/\(userId)/grocery-categories/\(groceryCategoryId)/grocery-items")!
        }
        static func groceryItemsBy(userId: UUID, groceryCategoryId: UUID) -> URL{
            return URL(string:"\(baseUrl)/users/\(userId)/grocery-categories/\(groceryCategoryId)/grocery-items")!
        }
        static func deleteGroceryItem(userId: UUID, groceryCategoryId: UUID, groceryItemId: UUID) -> URL{
            return URL(string:"\(baseUrl)/users/\(userId)/grocery-categories/\(groceryCategoryId)/grocery-items\(groceryItemId)")!
        }
    }
}

