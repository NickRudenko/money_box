//
//  AppRouter.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 07.05.2022.
//

import Foundation
import Hopoate
import Router
import UIKit

/// Router for our current app
final class AppRouter: Router {
    
    /// added for protocol conforming. implementation is not required currently.
    func routeFromExternalSource(to url: URL) -> Bool {
        return false
    }
    
    let rootViewController: UIViewController

    let routes: [Route.Type]
    private(set) var routesBeingFollowed = [Route]()

    init(rootViewController: UIViewController, routes: [Route.Type] = []) {
        self.routes = routes
        self.rootViewController = rootViewController
    }

    /// The view controller we should attempt to present from
    private var currentViewController: UIViewController? {
        guard let tabBar = tabBarController else {
            return rootViewController
        }
        return tabBar.topMostPresentedViewController ?? tabBar.selectedViewController
    }

    private var tabBarController: UITabBarController? {
        return rootViewController as? UITabBarController
    }

    /// Shows a view controller using an appropriate presentation mechanism.
    ///
    /// - Parameters:
    ///   - viewController: The view controller to show.
    private func show(viewController: UIViewController) {
        guard currentViewController != viewController else { return }
        currentViewController?.show(viewController, sender: self)
    }

    @discardableResult
    func route(to destination: Destination) -> UIViewController? {
        let viewController = destination.destination

        switch destination.presentationHint {
        case .navigate:
            show(viewController: viewController)
        case let .modal(metrics):
            let presentingViewController = rootViewController.topMostPresentedViewController ?? rootViewController
            if let presentationStyle = metrics.style {
                viewController.modalPresentationStyle = presentationStyle
            }
            presentingViewController.present(viewController, animated: metrics.animated, completion: nil)
        default:
            return nil
        }
        return viewController
    }

    @discardableResult
    func route(to target: RouteTarget) -> Bool {
        return route(to: target, completion: nil)
    }

    @discardableResult
    func route(to target: RouteTarget, completion: (() -> Void)?) -> Bool {
        return route(to: target, overrideDestinationHint: false, completion: completion)
    }

    private func route(to target: RouteTarget, overrideDestinationHint: Bool, completion: (() -> Void)?) -> Bool {
        let routeType: Route.Type?
        guard case let .model(model) = target else {
            completion?()
            return false
        }
        
        routeType = routes.first(where: { route in
            (route as? ObjectRoute.Type)?.canHandle(object: model) ?? false
        })

        guard let route: Route = routeType?.init() else {
            completion?()
            return false
        }
        routesBeingFollowed.append(route)
        route.destination(for: target) { [unowned self, unowned route] result in
            defer {
                if let index = self.routesBeingFollowed.firstIndex(where: { $0 === route }) {
                    self.routesBeingFollowed.remove(at: index)
                }
                completion?()
            }
            switch result {
            case var .success(destination):
                if overrideDestinationHint, let newHint = route.presentationHint {
                    destination.presentationHint = newHint
                    self.dismissCurrentlyPresentedViewControllerIfNeeded {
                        self.route(to: destination)
                    }
                    return
                }
                self.route(to: destination)
            case let .failure(error):
                print("erroe is \(error)")
//                self.route(to: ErrorDestination())
            }
        }
        return true
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        let controller = currentViewController ?? rootViewController
        controller.dismiss(animated: animated, completion: completion)
    }

    /// Dismisses the currently presented view controller without animation, if
    /// there is one present. If not, then the completion handler is called
    /// immediately. If there is a presented view controller then the completion
    /// handler is called when the dismissal completes.
    ///
    /// - Parameter completion: The handler to call when the presented view
    /// controller has been dismissed.
    private func dismissCurrentlyPresentedViewControllerIfNeeded(completion: @escaping () -> Void) {
        guard rootViewController.presentedViewController != nil else {
            completion()
            return
        }
        rootViewController.dismiss(animated: false, completion: completion)
    }

}

private extension Route {
    func destination(for target: RouteTarget, callback: @escaping (DestinationResult) -> Void) {
        
        guard case let .model(object) = target, let route = self as? ObjectRoute else {
            callback(.failure(RouteTargetError.invalidRouteType))
            return
        }
        route.destination(for: object, callback: callback)
    }
}
