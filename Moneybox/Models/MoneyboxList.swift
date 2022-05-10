//
//  MoneyboxList.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 09.05.2022.
//

import Foundation
import Fetch

public struct MoneyboxList: Codable {
    let moneyboxes: [Moneybox]
    
    enum CodingKeys: String, CodingKey {
        case moneyboxes = "ProductResponses"
    }

}

extension MoneyboxList: Parsable {
    public static func parse(response: Response, errorParser: ErrorParsing.Type?) -> FetchResult<MoneyboxList> {
        guard response.status == 200 else {
            if let error = errorParser?.parseError(from: response.data, statusCode: response.status) {
                return .failure(error)
              }
            return .failure(FetchError.statusCodeError)
            }
        guard let data = response.data,
              let moneyboxes = try? JSONDecoder().decode(MoneyboxList.self, from: data)
        else {
                  return .failure(FetchError.parseError)
              }
        return .success(moneyboxes)
    }
    
}

