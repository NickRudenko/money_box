//
//  UserManager.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 07.05.2022.
//

import Foundation
import ReactiveKit
import Fetch
import Hopoate

public protocol UserManaging {

    /// Whether the current user account type is registered.
    var isRegisteredUser: Bool { get }

    /// Logs in a user
    ///
    /// - Parameters:
    ///   - username: The username to log in
    ///   - password: The password of the user
    ///   - completion: The completion block containing the auth credential
    func login(username: String, password: String, completion: @escaping (FetchResult<Void>) -> Void)

    /// Logs the user out
    func logOut()

    /// The receiver's delegate.
    var delegate: UserManagingDelegate? { get set }
}

public final class UserManager: UserManaging {
    private let auth = resolve(Authorising.self)
    public private(set) var isRegisteredUser = false
    public var delegate: UserManagingDelegate?
    
    public func login(username: String, password: String, completion: @escaping (FetchResult<Void>) -> Void) {
        auth.login(username: username, password: password) { result in
            if case .success(_) = result {
                self.isRegisteredUser = true
                completion(.success(()))
            } else {
                completion(.failure(FetchError.statusCodeError))
            }
        }
    }
    
    public func logOut() {
        auth.logOut()
        isRegisteredUser = false
    }
    
}
