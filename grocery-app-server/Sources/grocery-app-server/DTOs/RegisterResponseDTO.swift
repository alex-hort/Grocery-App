//
//  RegisterResponseDTO.swift
//  grocery-app-server
//
//  Created by Alexis Horteales Espinosa on 30/08/26.
//

import Foundation
import Vapor

struct RegisterResponseDTO: Content{
    let error: Bool
    var reason: String? = nil
}
