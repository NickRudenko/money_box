//
//  CustomerInfoViewModel.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 09.05.2022.
//

import Foundation
import Hopoate
import Bond

final class CustomerInfoViewModel {
    let auth = resolve(Authorising.self)
    
    let greatingText = Observable<String>("")
    let totalPlanText = Observable<String>("")
    
    public func setupProperties() {
        guard let details = auth.userDetails else { return }
        greatingText.value = ["Hello", details.firstName, "\(details.lastName)!"].joined(separator: " ")
        totalPlanText.value = ["Total Plan Value:", "£\(details.totalPlanValue)"].joined(separator: " ")
    }
}
