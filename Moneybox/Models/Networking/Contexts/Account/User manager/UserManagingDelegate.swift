//
//  UserManagingDelegate.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 07.05.2022.
//

import Foundation

public protocol UserManagingDelegate: AnyObject {
    /// The message sent when user authorisation fails due to an invalid OAuth
    /// grant.
    ///
    /// - Parameter userManager: The user manager sending the message.
    func userManagerRequestingUserLoginPrompt(_ userManager: UserManaging)

    /// The message sent when the user has been logged out
    ///
    /// - Parameter userManager: The user manager sending the message.
    func userManagerHasLoggedCurrentUserOut(_ userManager: UserManaging)
}
