//
//  NSRegularExpression+Matches.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 08.05.2022.
//

import Foundation

extension NSRegularExpression {
    /// Returns the contents of the first capture group.
    ///
    /// - Parameter string: The string to match in.
    /// - Returns: The contents of the capture group.
    public func firstCaptureGroup(for string: String) -> String? {
        let matches = self.matches(for: string)
        guard let match = matches.first, match.numberOfRanges > 1 else { return nil }
        let range = match.range(at: 1)
        guard range.location != NSNotFound else { return nil }
        return string.ns.substring(with: range)
    }

    public func hasMatches(for string: String) -> Bool {
        let matches = self.matches(for: string)
        return matches.isEmpty == false
    }

    public func matches(for string: String) -> [NSTextCheckingResult] {
        return matches(in: string, options: [], range: NSRange(location: 0, length: string.count))
    }
}

private extension String {
    var ns: NSString {
        return self as NSString
    }
}

