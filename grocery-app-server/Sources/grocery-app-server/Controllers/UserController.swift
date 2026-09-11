//
//  UserController.swift
//  grocery-app-server
//
//  Created by Alexis Horteales Espinosa on 28/08/26.
//

import Foundation
import Vapor
import Fluent
import JWT
import GroceryAppSharedDTO


class UserController: RouteCollection{
    
    func boot(routes: any Vapor.RoutesBuilder) throws {
        
        //user
        let api = routes.grouped("api")
        //api/register
        api.post("register", use: register)
        //api/login
        api.post("login", use: login)
    }
    
    
    func login(req: Request) async throws -> LoginResponseDTO{
        
        //decode the request
        let loginRequest = try req.content.decode(LoginRequestDTO.self)
        
        //check if he user exists in db
        guard let existingUser = try await User.query(on: req.db)
            .filter(\.$username == loginRequest.username)
            .first() else {
            return LoginResponseDTO(error: true, reason: "Username is not found")
        }
        
        //validate the password
        let result = try await req.password.async.verify(loginRequest.password, created: existingUser.password)
        
        if !result {
            return LoginResponseDTO(error: true, reason: "Password is incorret")
        }
        
        //generate the token and return it to user
        let authPayload = try AuthPayload(expiration: .init(value: .distantFuture), userId: existingUser.requireID())
        
        return try await LoginResponseDTO(error: false, token: req.jwt.sign(authPayload), userId: existingUser.requireID())
    }
    
    func register(req: Request) async throws -> RegisterResponseDTO{
        //validate the user to active validations
        
        try User.validate(content: req)
        
        let user = try req.content.decode(User.self)
        
        if let _ = try await User.query(on: req.db)
            .filter(\.$username == user.username)
            .first(){
            throw Abort(.conflict, reason: "Username is already taken.")
        }
        //hash the password
        user.password = try await req.password.async.hash(user.password)
        //save the user to database
        try await user.save(on: req.db)
        return RegisterResponseDTO(error:false)
    }
    
    
}

