//
//  CustomerDetails.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 09.05.2022.
//

import Foundation

public struct CustomerDetails: Codable {
    let firstName: String
    let lastName: String
    let totalPlanValue: Double
    
    enum CodingKeys: String, CodingKey {
        case firstName = "FirstName"
        case lastName = "LastName"
        case totalPlanValue = "InvestmentTotal"
        
    }
}
