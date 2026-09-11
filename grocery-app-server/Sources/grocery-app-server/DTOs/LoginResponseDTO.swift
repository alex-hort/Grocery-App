//
//  LoginResponseDTO.swift
//  grocery-app-server
//
//  Created by Alexis Horteales Espinosa on 30/08/26.
//

import Foundation
import Vapor

struct LoginResponseDTO: Content{
    let error: Bool
    var reason: String? = nil
    var token: String? = nil
    var userId: UUID? = nil
}


struct LoginRequestDTO: Content {
    let username: String
    let password: String
}

