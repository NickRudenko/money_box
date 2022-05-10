//
//  Customer.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 09.05.2022.
//

import Foundation
import Fetch

struct Customer: Codable {
    let session: AuthCredential
    let customerDetails: CustomerDetails
    
    enum CodingKeys: String, CodingKey {
        case session = "Session"
        case customerDetails = "User"
    }
}

extension Customer: Parsable {
    public static func parse(response: Response, errorParser: ErrorParsing.Type?) -> FetchResult<Customer> {
        guard response.status == 200 else {
            if let error = errorParser?.parseError(from: response.data, statusCode: response.status) {
                return .failure(error)
              }
            return .failure(FetchError.statusCodeError)
            }
        guard let data = response.data,
              let customer = try? JSONDecoder().decode(Customer.self, from: data)
        else {
                  return .failure(FetchError.parseError)
              }
        return .success(customer)
    }
    
}
