//
//  MoneyboxCellViewModel.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 09.05.2022.
//

import Foundation
import Bond

final class MoneyboxCellViewModel {
    var model: Moneybox? {
        didSet {
            configureProperties()
        }
    }
    
    let generalTitleText = Observable<String>("")
    let planValueText = Observable<String>("")
    let moneyboxText = Observable<String>("")
    
    private func configureProperties() {
        guard let moneybox = model else { return }
        generalTitleText.value = moneybox.title
        planValueText.value = ["Plan value:", "£\(moneybox.planValue)"].joined(separator: " ")
        moneyboxText.value = ["Moneybox:", "£\(moneybox.moneyboxAmount)"].joined(separator: " ")
    }
}
