//
//  Authorising.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 07.05.2022.
//

import Foundation
import Fetch

/// Object that can log a user in and out
public protocol Authorising: AnyObject {

    var delegate: AuthorisingDelegate? { get set }
    var token: AuthCredential? { get }
    var userDetails: CustomerDetails? { get }

    /// Log a user in wiht email and password
    ///
    /// - Parameters:
    ///   - username: The username used for login
    ///   - password: Password
    ///   - completion: Completion block to call
    func login(username: String, password: String, completion: @escaping (FetchResult<Void>) -> Void)

    /// Logs the user out, removing stored tokens
    func logOut()
}

public protocol AuthorisingDelegate: AnyObject {
    /// A message sent when the authorising service logged the user out
    ///
    /// - Parameter service: The service that logged the user out.
    /// - Parameter error: The error that caused the user to be logged out.
    func userWasLoggedOutFromAuthService(_ service: Authorising, from error: Error)
}
