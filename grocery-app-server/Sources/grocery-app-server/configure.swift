import Vapor
import Fluent
import FluentPostgresDriver
import JWT


/// configures your application
func configure(_ app: Application) async throws {
   
    app.databases.use(.postgres(hostname: "localhost", username: "alexishortealesespinosa", password: "", database: "grocerydb"), as: .psql)
    
    app.routes.defaultMaxBodySize = "10mb"
    
    //register migrations
    app.migrations.add(CreateUsersTableMigration())
    app.migrations.add(CreateGroceryCategoryTableMigration())
    app.migrations.add(CreateGroceryItemTableMigration())
    
    //register controllers
    try app.register(collection: UserController())
    try app.register(collection: GroceryController())
    
    await app.jwt.keys.add(hmac: "secret", digestAlgorithm: .sha256)
    
    try routes(app)
}
