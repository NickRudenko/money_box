//
//  AppEnvironment.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 08.05.2022.
//

import Foundation

public enum AppEnvironment {
    public enum Endpoint {
        /// API host
        public static let host: String = #"api-test02.moneyboxapp.com"#
        
        /// URL scheme for API requests
        public static let scheme: String = #"https"#
        
    }
}
