//
//  TokenRequestCredential.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 07.05.2022.
//

import Foundation

// A credential that can be used to request a new token.
protocol TokenRequestCredential {
//    var type: String { get }
    var payload: String { get }
}

/// A username & password credential passed from the user.
struct LoginCredential {
    let username: String
    let password: String
}

extension LoginCredential: TokenRequestCredential {
//    var type: String {
//        return "password"
//    }

    var payload: String {
        "{\n  \"Email\": \"\(username)\",\n  \"Password\": \"\(password)\",\n  \"Idfa\": \"ANYTHING\"\n}"
    }
}
