//
//  TokenRequest.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 07.05.2022.
//

import Foundation
import Fetch

struct TokenRequest: Request {
    var method: HTTPMethod = .post
    
    var body: Data?
    let url: URL
    let headers: [String : String]?

    init(credential: TokenRequestCredential) {
        url = API.users.endpoint(path: "login").url
        let postData = credential.payload.data(using: .utf8)
        body = postData
        headers = standardRequestHeaders()
        
    }
}
