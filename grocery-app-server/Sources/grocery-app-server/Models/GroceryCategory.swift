//
//  GroceryCategory.swift
//  grocery-app-server
//
//  Created by Alexis Horteales Espinosa on 01/09/26.
//

import Foundation
import Vapor
import Fluent


final class GroceryCategory: Model, Content, Validatable, @unchecked Sendable {
        
    static let schema = "grocery_categories"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "image_url")
    var image: String
    
    @Parent(key: "user_id")
    var user: User
    
    init() {}
    
    init(id: UUID? = nil, title: String, image: String ,userId: UUID){
        self.id = id
        self.title = title
        self.image = image
        self.$user.id = userId
        
        
    }
    
    static func validations(_ validations: inout Vapor.Validations) {
        validations.add("title", as: String.self, is: !.empty, customFailureDescription: "Title cannot be empty")
        validations.add("image", as: String.self, is: !.empty, customFailureDescription: "Image cannot be empty")
    }
    
    
    
}
