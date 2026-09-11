//
//  AuthPayyload.swift
//  grocery-app-server
//
//  Created by Alexis Horteales Espinosa on 28/08/26.
//

import JWT
import Foundation

struct AuthPayload: JWTPayload{
    
    typealias Payload = AuthPayload
    
    enum CodingKeys: String, CodingKey {
         case expiration = "exp"
         case userId = "uid"
     }
    
    var expiration: ExpirationClaim
    var userId: UUID
    
    func verify(using algorithm: some JWTKit.JWTAlgorithm) async throws {
        try self.expiration.verifyNotExpired()
    }

}

