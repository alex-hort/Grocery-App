//
//  AppState.swift
//  GroceryFApp
//
//  Created by Alexis Horteales Espinosa on 29/08/26.
//
import Foundation
import Combine


enum GroceryError: Error{
    case login
}


enum Route: Hashable{
    case login
    case register
    case groceryCategoryList
    case groceryCategoryDetail(GroceryCategoryResponseDTO)
}


class AppState: ObservableObject{
    @Published var routes: [Route] = []
    @Published var errorWrapper: ErrorWrapper?
}
