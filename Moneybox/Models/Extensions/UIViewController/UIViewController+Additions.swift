//
//  UIViewController+Additions.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 07.05.2022.
//

import UIKit

extension UIViewController {
    /// Returns the presented view controller that the highest in the hierarchy
    public var topMostPresentedViewController: UIViewController? {
        var topController = presentedViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
}
