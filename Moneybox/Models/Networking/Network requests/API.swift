//
//  API.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 08.05.2022.
//

import Foundation

public enum API: String {
    public struct Endpoint {
        let api: API
        let path: String?
        public var url: URL {
            var components = URLComponents()
            components.scheme = AppEnvironment.Endpoint.scheme
            components.host = AppEnvironment.Endpoint.host
            let pathComponents: [PathComponent?] = [
                api,
                path
            ]
            components.path = "/" + pathComponents.combinedPaths
            guard let url = components.url else {
                fatalError("Failed to create URL")
            }
            return url
        }
    }
    
    case users
    case investorproducts
    case oneoffpayments
    
    public func endpoint(path: String? = nil) -> Endpoint {
        return Endpoint(api: self, path: path)
    }
}

extension API: PathComponent {
    public var description: String { return rawValue }
}
