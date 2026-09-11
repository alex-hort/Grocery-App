//
//  GroceryController.swift
//  grocery-app-server
//
//  Created by Alexis Horteales Espinosa on 01/09/26.
//
import Foundation
import Vapor
import Fluent

class GroceryController: RouteCollection{
    
    func boot(routes: any RoutesBuilder) throws {
    
        //api/users/:userId
        let api = routes.grouped("api", "users", ":userId").grouped(JSONWebTokenAuth())
        
        //POST
        //api/users/:userId/grocery-categories
        
        api.post("grocery-categories", use: saveGroceryCategory)
        
        //GET: /api/users/:userId/grocery-categories
        api.get("grocery-categories", use: getGroceryCategoriesByUser)
        
        //DELETE: /api/users/:userId/grocery-categories/:groceryCateegoryId
        api.delete("grocery-categories", ":groceryCategoryId", use: deleteGroceryCategory)
        
        //POST: /api/users/:userId/grocer-categories/:groceryCategoryId/grocery-items
        api.post("grocery-categories", ":groceryCategoryId", "grocery-items", use: saveGroceryItems)
        
        //GET: /api/users/:userId/grocer-categories/:groceryCategoryId/grocery-items
        api.get("grocery-categories", ":groceryCategoryId", "grocery-items", use: getGroceryItemByGroceryCategory)
        
        //DELETE /api/users/:userId/grocer-categories/:groceryCategoryId/grocery-items/:groceryItemId
        api.delete("grocery-categories", ":groceryCategoryId", "grocery-items", ":groceryItemId", use: deleteGroceryItem)
    }
    
    func deleteGroceryItem(req: Request) async throws -> GroceryItemResponsetDTO{
        // get the id from the route parameters
        // Obtenemos los IDs que vienen en la URL
        guard let userId = req.parameters.get("userId", as: UUID.self),
              let groceryCategoryId = req.parameters.get("groceryCategoryId", as: UUID.self),
              let groceryItemId = req.parameters.get("groceryItemId", as: UUID.self)
        else {
            // Si alguno de los IDs no existe o no es válido, damos error 400
            throw Abort(.badRequest)
        }
        // make sure the category exists and belongs to the user
        // Buscamos la categoría de grocery
        // También verificamos que esa categoría pertenezca al usuario
        guard let groceryCategory = try await GroceryCategory.query(on: req.db)
            .filter(\.$user.$id == userId)              // La categoría pertenece a este usuario
            .filter(\.$id == groceryCategoryId)         // La categoría tiene este ID
            .first()                                    // Obtenemos la primera coincidencia
        else {
            // Si no encontramos la categoría, damos error 404
            throw Abort(.notFound)
        }
        // Buscamos el producto (item) que queremos eliminar
        guard let groceryItem = try await GroceryItem.query(on: req.db)
            .filter(\.$id == groceryItemId)                         // El producto tiene este ID
            .filter(\.$groceryCategory.$id == groceryCategory.id!)  // El producto pertenece a esta categoría
            .first()                                                // Obtenemos el producto
        else {
            // Si no encontramos el producto, damos error 404
            throw Abort(.notFound)
        }
        // Eliminamos el producto de la base de datos
        try await groceryItem.delete(on: req.db)
        // Convertimos el producto eliminado a un DTO para devolverlo como respuesta
        guard let groceryItemResponseDTO = GroceryItemResponsetDTO(groceryItem) else {
            // Si no se puede crear el DTO, damos error 500
            throw Abort(.internalServerError)
        }
        // Devolvemos como respuesta el producto que acabamos de eliminar
        return groceryItemResponseDTO
    }
    
    
    func getGroceryItemByGroceryCategory(req: Request) async throws -> [GroceryItemResponsetDTO]{
        
        guard let userId = req.parameters.get("userId", as: UUID.self),
              let groceryCategoryId = req.parameters.get("groceryCategoryId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        //validate the userId
        guard let _ = try await User.find(userId, on: req.db) else {
            throw Abort(.notFound)
        }
        
        //find the grocery category
        guard let groceryCategory = try await GroceryCategory.query(on: req.db)
            .filter(\.$user.$id == userId)
            .filter(\.$id == groceryCategoryId)
            .first() else {
            throw Abort(.notFound)
        }
        
        return try await GroceryItem.query(on: req.db)
            .filter(\.$groceryCategory.$id == groceryCategory.id!)
            .all()
            .compactMap(GroceryItemResponsetDTO.init)
    }
    
    func saveGroceryItems(req: Request) async throws -> GroceryItemResponsetDTO{
        
        guard let userId = req.parameters.get("userId", as: UUID.self),
              let groceryCategoryId = req.parameters.get("groceryCategoryId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        //find the user
        guard let _ = try await User.find(userId, on: req.db) else {
            throw Abort(.notFound)
        }
        
        //find groceryCategory
        guard let groceryCategory = try await GroceryCategory.query(on: req.db)
            .filter(\.$user.$id == userId)
            .filter(\.$id == groceryCategoryId)
            .first() else {
            throw Abort(.notFound)
        }
        
        //decoding dto //GroceryItemRequestDTO
        let groceryItemRequestDTO = try req.content.decode(GroceryItemRequestDTO.self)
        
        let groceryItem =  GroceryItem(title: groceryItemRequestDTO.title, price: groceryItemRequestDTO.price, quantity: groceryItemRequestDTO.quantity, groceryCategoryId: groceryCategory.id!)
        
        try await groceryItem.save(on: req.db)
        
        
        guard let groceryItemResponseDTO = GroceryItemResponsetDTO(groceryItem) else {
            throw Abort(.internalServerError)
        }
        
        return groceryItemResponseDTO
    
    }
    
    func deleteGroceryCategory(req: Request) async throws -> GroceryCategoryResponseDTO {
        //get the userid, groceryCategoryId
        guard let userId = req.parameters.get("userId", as: UUID.self),
              let groceryCategoryId = req.parameters.get("groceryCategoryId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        guard let groceryCategory = try await GroceryCategory.query(on: req.db)
            .filter(\.$id == groceryCategoryId)
            .first() else {
            throw Abort(.notFound)
        }
        print("Category found, belongs to user: \(groceryCategory.$user.id)")
        
        try await groceryCategory.delete(on: req.db)
        
        guard let groceryCategoryResponseDTO = GroceryCategoryResponseDTO(groceryCategory) else {
            throw Abort(.internalServerError)
        }
        
        return groceryCategoryResponseDTO
    }
    
    
    
    func getGroceryCategoriesByUser(req: Request) async throws -> [GroceryCategoryResponseDTO]{
        //get the userId
        guard let userId = req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        return try await GroceryCategory.query(on: req.db)
            .filter(\.$user.$id == userId)
            .all()
            .compactMap(GroceryCategoryResponseDTO.init)
    }
    
    func saveGroceryCategory(req: Request) async throws -> GroceryCategoryResponseDTO{
        //get the userId
        guard let userId = req.parameters.get("userId", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        //DTO to the request
        let groceryCategoryRequestDTO = try req.content.decode(GroceryCategoryRequestDTO.self)
        
        let groceryCategory = GroceryCategory(title: groceryCategoryRequestDTO.title,
                                              image: groceryCategoryRequestDTO.image,
                                              userId: userId)
        
        try await groceryCategory.save(on: req.db)
        
        guard let groceryCategoryResponseDTO = GroceryCategoryResponseDTO(groceryCategory) else {
            throw Abort(.internalServerError)
        }
        return groceryCategoryResponseDTO
    }
}
