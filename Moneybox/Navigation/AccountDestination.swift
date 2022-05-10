//
//  AccountDestination.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 09.05.2022.
//

import Foundation
import UIKit
import Router

struct AccountDestination: Destination {
    var presentationHint: PresentationHint = .navigate
    var destination: UIViewController { AccountViewController() }
}
