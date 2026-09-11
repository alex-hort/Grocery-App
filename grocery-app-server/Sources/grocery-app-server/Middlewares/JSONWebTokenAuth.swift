//
//  JSONWebTokenAuth.swift
//  grocery-app-server
//
//  Created by Alexis Horteales Espinosa on 09/09/26.
//

import Foundation
import Vapor
import JWT

struct JSONWebTokenAuth: AsyncRequestAuthenticator{
    func authenticate(request: Request) async throws {
       try await request.jwt.verify(as: AuthPayload.self)
    }
}
