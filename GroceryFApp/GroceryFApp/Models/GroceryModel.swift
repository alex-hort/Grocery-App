//
//  GroceryModel.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 29/08/26.
//

import Foundation
import Combine
import GroceryAppSharedDTO

@MainActor
//bussiness logic
class GroceryModel: ObservableObject{
    
    let httpClient = HTTPClient()
    
    @Published var groceryCategories: [GroceryCategoryResponseDTO] = []
    @Published var groceryItems: [GroceryItemResponsetDTO] = []
    @Published var groceryCategory: GroceryCategoryResponseDTO?
    
    func register(name: String, username: String, password: String) async throws -> RegisterResponseDTO{
        let registerData = ["name": name, "username": username, "password": password]
        
        //resource
        let resource = try Resource(url:
                                        Contants.Urls.register,
                                        method: .post(JSONEncoder().encode(registerData)),
                                        modelType: RegisterResponseDTO.self)
        
        let registerResponseDTO = try await httpClient.load(resource)
        return registerResponseDTO
    }
    
    func populateGroceryItemsBy(groceryCategoryId: UUID) async throws {
        guard let userId = UserDefaults.standard.userId else {
            return
        }
        
        let resource = Resource(url: Contants.Urls.groceryItemsBy(userId: userId, groceryCategoryId: groceryCategoryId), modelType: [GroceryItemResponsetDTO].self)
        
        groceryItems = try await httpClient.load(resource)
    }
    
    func deleteGroceryItem(groceryCategoryId: UUID, groceryItemId: UUID) async throws{
        // Intentamos obtener el ID del usuario que tenemos guardado en UserDefaults
        guard let userId = UserDefaults.standard.userId else {
            // Si no existe un userId, simplemente salimos de la función
            return
        }


        // Creamos el Resource que representa la petición DELETE al servidor
        let resource = Resource(
            url: Contants.Urls.deleteGroceryItem(
                userId: userId,
                groceryCategoryId: groceryCategoryId,
                groceryItemId: groceryItemId
            ),
            method: .delete,                         // Indicamos que queremos ELIMINAR
            modelType: GroceryItemResponsetDTO.self  // Tipo de objeto que esperamos recibir
        )


        // Enviamos la petición al servidor
        // El servidor elimina el producto y nos devuelve el producto eliminado
        let deletedGroceryItem = try await httpClient.load(resource)

        groceryItems = groceryItems.filter { $0.id != deletedGroceryItem.id }
    }
 
    
    
    func login(username: String, password: String) async throws -> LoginResponseDTO{
        let loginPostData = ["username": username, "password": password]
        
        //resource
        let resource = try Resource(url:
                                        Contants.Urls.login,
                                        method: .post(JSONEncoder().encode(loginPostData)),
                                        modelType: LoginResponseDTO.self)
        let loginResponseDTO = try await httpClient.load(resource)
        
        if !loginResponseDTO.error && loginResponseDTO.token != nil && loginResponseDTO.userId != nil {
            //save ethee token in the user defaults
            let defaults = UserDefaults.standard
            defaults.set(loginResponseDTO.token!, forKey: "authToken")
            defaults.set(loginResponseDTO.userId!.uuidString
                         , forKey: "userId")
        }
        return loginResponseDTO
    }
    
    
    func populateGroceryCategories() async throws{
        guard let userId = UserDefaults.standard.userId else {
            return
        }
        let resource = Resource(url: Contants.Urls.groceryCategoriesBy(userId: userId), modelType: [GroceryCategoryResponseDTO].self)
        
        
        groceryCategories = try await httpClient.load(resource)
        
        
    }
    
    func saveGroceryCategory(_ groceryCategoryRequestDTO: GroceryCategoryRequestDTO) async throws {
        guard let userId = UserDefaults.standard.userId else {
            return 
        }
        
        let resource = try Resource(url: Contants.Urls.saveGroceryCategoryBy(userId: userId), method: .post(JSONEncoder().encode(groceryCategoryRequestDTO)), modelType: GroceryCategoryResponseDTO.self)
        
        
        let groceryCategory = try await httpClient.load(resource)
        
        //add new grocry to the list
        groceryCategories.append(groceryCategory)
        
    
    }
    
    func saveGroceryItem(_ groceryItemRequestDTO: GroceryItemRequestDTO, groceryCategoryId: UUID) async throws {
        guard let userId = UserDefaults.standard.userId else {
            return
        }
        let resource = try Resource(url: Contants.Urls.saveGroceryItem(userId: userId, groceryCategoryId: groceryCategoryId), method: .post(JSONEncoder().encode(groceryItemRequestDTO)), modelType: GroceryItemResponsetDTO.self)
        
        let newGroceryItem = try await httpClient.load(resource)
        groceryItems.append(newGroceryItem)
    }
    
    func deleteGroceryCategory(groceryCategoryId: UUID) async throws {
        guard let userId = UserDefaults.standard.userId else {
            return
        }
        
        let resource = Resource(url: Contants.Urls.deleteGroceryCategory(userId: userId, groceryCategoryId: groceryCategoryId), method: .delete, modelType: GroceryCategoryResponseDTO.self)
        
        let deletedGroceryCategory = try await httpClient.load(resource)
        
        //remove the deleted category from the list
        groceryCategories = groceryCategories.filter{$0.id != deletedGroceryCategory.id}
        
    }
    
    
    func logout(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "userId")
        defaults.removeObject(forKey: "authToken")
    }
}
