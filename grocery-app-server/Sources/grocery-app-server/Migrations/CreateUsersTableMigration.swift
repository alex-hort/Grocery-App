//
//  CreateUsersTableMigration.swift
//  grocery-app-server
//
//  Created by Alexis Horteales Espinosa on 25/08/26.
//

import Foundation
import Vapor
import Fluent

struct CreateUsersTableMigration: AsyncMigration{
  
    func prepare(on database: any Database) async throws {
        try await database.schema("users")
            .id()
            .field("name", .string, .required)
            .field("username", .string, .required).unique(on: "username")
            .field("password", .string, .required)
            .create()
    }
    
    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema("users")
            .delete()
    }
    
    
}
