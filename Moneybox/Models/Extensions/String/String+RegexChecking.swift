//
//  String+RegexChecking.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 08.05.2022.
//

import Foundation

extension String {
    public func hasValidEmail() -> Bool {
        return AppRegex.email.hasMatches(for: self) &&
            !AppRegex.emailDomainContainsRepetitivePeriod.hasMatches(for: self) &&
            AppRegex.allowedSymbolsInEmail.hasMatches(for: self)
    }
}
