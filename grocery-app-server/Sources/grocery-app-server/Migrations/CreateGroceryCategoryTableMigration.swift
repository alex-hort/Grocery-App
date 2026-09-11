//
//  CreateGroceryCategoryTableMigration.swift
//  grocery-app-server
//
//  Created by Alexis Horteales Espinosa on 01/09/26.
//

import Foundation
import Vapor
import Fluent

struct CreateGroceryCategoryTableMigration: AsyncMigration{
    
    func prepare(on database: any Database) async throws {
        try await database.schema("grocery_categories")
            .id()
            .field("title", .string, .required)
            .field("image_url", .string)
            .field("user_id", .uuid, .required, .references("users", "id"))
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("grocery_categories")
            .delete()
    }
}
