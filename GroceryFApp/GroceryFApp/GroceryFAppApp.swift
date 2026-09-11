//
//  GroceryFAppApp.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 28/08/26.
//

import SwiftUI

@main
struct GroceryFAppApp: App {
    
    @StateObject private var appState = AppState()
    
    
    var body: some Scene {
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "authToken")
        
        WindowGroup {
            NavigationStack(path: $appState.routes){
                
                Group{
                    if token == nil {
                        RegistrationScreen()
                    } else {
                        GroceryCategoriesListScreen()
                    }
                }.navigationDestination(for: Route.self) { route in
                        switch route{
                        case .register:
                            RegistrationScreen()
                        case .login:
                            LoginScreen()
                        case .groceryCategoryList:
                           GroceryCategoriesListScreen()
                        case .groceryCategoryDetail(let groceryCategory):
                            GroceryDetailScreen(groceryCategory: groceryCategory)
                        }
                    }
            }.environmentObject(GroceryModel())
                .environmentObject(appState)
        }
    }
}
