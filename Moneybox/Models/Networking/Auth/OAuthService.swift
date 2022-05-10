//
//  OAuthService.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 07.05.2022.
//

import Foundation
import Fetch

public class OAuthService: Authorising {
    
    public var delegate: AuthorisingDelegate?
    public var isLoggedIn: Bool { token != nil }
    private let tokenContext: TokenQueryable
    public private(set) var token: AuthCredential?
    public private(set) var userDetails: CustomerDetails?
    
    init(tokenContext: TokenQueryable) {
        self.tokenContext = tokenContext
    }
    
    public func login(username: String, password: String, completion: @escaping (FetchResult<Void>) -> Void) {
        let credential = LoginCredential(username: username, password: password)
        fetchToken(isLogin: true, using: credential, completion: completion)
    }
    
    public func logOut() {
        token = nil
    }
    
    public func update(with token: AuthCredential) {
        self.token = token
    }
    
    private func fetchToken(isLogin: Bool = false, using credential: TokenRequestCredential, completion: @escaping (FetchResult<Void>) -> Void) {
        tokenContext.fetchToken(credential: credential) { result in
            switch result {
            case let .success(customer):
                self.token = customer.session
                self.userDetails = customer.customerDetails
                completion(.success(()))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
}
