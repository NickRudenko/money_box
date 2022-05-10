//
//  Moneybox.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 09.05.2022.
//

import Foundation

struct Moneybox: Codable {
    let title: String
    let planValue: Double
    let moneyboxAmount: Double
    
    enum CodingKeys: String, CodingKey {
        case planValue = "PlanValue"
        case moneyboxAmount = "Moneybox"
        case assetBox = "AssetBox"
    }
    
    enum AssetBoxCodingKeys: String, CodingKey {
        case title = "Title"

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        planValue = try container.decode(Double.self, forKey: .planValue)
        moneyboxAmount = try container.decode(Double.self, forKey: .moneyboxAmount)
        let assetContainer = try container.nestedContainer(keyedBy: AssetBoxCodingKeys.self, forKey: .assetBox)
        title = try assetContainer.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        fatalError("Encoding not implemented")
    }
    
}
