//
//  AuthCredential.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 07.05.2022.
//

import Foundation
import Fetch

public typealias AuthCredentialFetchCompletion = (FetchResult<AuthCredential>) -> Void

public struct AuthCredential: Codable {
    public let token: String

    private enum CodingKeys: String, CodingKey {
        case token = "BearerToken"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        token = try container.decode(String.self, forKey: .token)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(token, forKey: .token)
    }

    public init(accessToken: String) {
        token = accessToken
    }
}

extension AuthCredential: Parsable {
    public static func parse(response: Response, errorParser: ErrorParsing.Type?) -> FetchResult<AuthCredential> {
        guard let data = response.data else {
            return .failure(FetchError.parseError)
        }

        guard response.status < 400 else {
            if let error = errorParser?.parseError(from: response.data, statusCode: response.status) {
                return .failure(error)
            } else {
                let failure = Fetch.ResponseError.response(statusCode: response.status,
                                                           headers: response.headers ?? [:])
                return .failure(failure)
            }
        }

        let decoder = JSONDecoder()
        do {
            let token = try decoder.decode(AuthCredential.self, from: data)
            return .success(token)
        } catch {
            return .failure(error)
        }
    }
}
