//
//  StandardHeaders.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 07.05.2022.
//

import Foundation
import Hopoate
import Fetch

func standardRequestHeaders() -> [String: String] {
    var headers = ["AppId": "8cb2237d0679ca88db6464",
                 "Content-Type": "application/json",
                 "appVersion": "8.10.0",
                 "apiVersion": "3.0.0",
                 "Host": "api-test02.moneyboxapp.com"]
    if let token = resolve(Authorising.self).token?.token {
        headers["Authorization"] = "Bearer \(token)"
    }
    return headers
}

public enum FetchError: Error {
    case statusCodeError
    case parseError
  }
