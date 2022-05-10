//
//  TokenContext.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 07.05.2022.
//

import Foundation
import Fetch

protocol TokenQueryable {
    /// Requests a new token using the supplied credential.
    ///
    /// - Parameters:
    ///   - credential: The credential to use to  request a new token.
    ///   - configuration: The configuration to use for the request.
    ///   - completion: The callback to use on completion
    func fetchToken(credential: TokenRequestCredential, completion: @escaping (FetchResult<Customer>) -> Void)
}

class TokenContext: TokenQueryable {
    let session = Session()

    func fetchToken(credential: TokenRequestCredential, completion: @escaping (FetchResult<Customer>) -> Void) {
        let request = TokenRequest(credential: credential)
        session.perform(request, completion: completion)
    }
}
