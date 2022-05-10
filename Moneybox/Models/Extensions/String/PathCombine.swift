//
//  PathCombine.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 08.05.2022.
//

import Foundation

extension Sequence where Iterator.Element == PathComponent {
    var combinedPaths: String {
        return compactMap { $0.description.isEmpty ? nil : $0.description }
            .joined(separator: "/")
    }
}

extension Sequence where Iterator.Element == PathComponent? {
    var combinedPaths: String {
        return compactMap { $0 }.combinedPaths
    }
}

protocol PathComponent: CustomStringConvertible {}
extension String: PathComponent {}
