//
//  Property+StringValue.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 07.05.2022.
//

import Foundation
import ReactiveKit

extension Property where Value == String? {
    public var valueIfNotEmpty: String? {
        guard let value = value, !value.isEmpty else {
            return nil
        }
        return value
    }
}
