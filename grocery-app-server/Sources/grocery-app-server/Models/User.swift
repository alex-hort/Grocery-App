//
//  User.swift
//  grocery-app-server
//
//  Created by Alexis Horteales Espinosa on 28/08/26.
//


import Fluent
import Vapor


final class User: Model, Validatable, Content, @unchecked Sendable{
 
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "password")
    var password: String
    
    
    init(){}
    
    init(id: UUID? = nil , name: String, username: String, password:String){
        self.id = id
        self.name = name
        self.username = username
        self.password = password
        
    }
    
    static func validations(_ validations: inout Vapor.Validations) {
        validations.add("name", as: String.self, is: !.empty, customFailureDescription: "Name cannot be empty." )
        validations.add("username",as: String.self, is: !.empty, customFailureDescription: "Username cannot be empty.")
        validations.add("password",as: String.self, is: !.empty, customFailureDescription: "Password cannot be empty.")
        
        validations.add("password", as: String.self , is: .count(6...10), customFailureDescription: "Password must be betweent 6 and 10 chracters long.")
    }
}

