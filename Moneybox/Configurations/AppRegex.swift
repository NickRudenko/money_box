//
//  AppRegex.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 08.05.2022.
//

import Foundation

public enum AppRegex {
    public static let email: NSRegularExpression = try! NSRegularExpression(pattern: #"^(?=.{8,252}$)[\w]+[\.\-\+]?((([^\.]\.)|([^\-]\-)|([^\+]\+))|([\w])|('))*([\w]|[\-])@[A-Za-z\d][-.\w]*[A-Za-z\d]\.([A-Za-z]{2,13})$"#, options: [])
    
    public static let emailDomainContainsRepetitivePeriod: NSRegularExpression = try! NSRegularExpression(pattern: #"^.*@.*\.{2,}.*$"#, options: [])
    
    public static let allowedSymbolsInEmail: NSRegularExpression = try! NSRegularExpression(pattern: #"^[\w@.\-\+']*$"#, options: [])
}
