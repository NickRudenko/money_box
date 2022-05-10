//
//  MoneyboxListRequest.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 09.05.2022.
//

import Foundation
import Fetch

struct MoneyboxListRequest: Request {
    var method: HTTPMethod = .get
    var body: Data?
    let url: URL
    let headers: [String : String]?

    init() {
        url = API.investorproducts.endpoint(path: nil).url
        body = nil
        headers = standardRequestHeaders()
    }
}
