//
//  AccountViewModel.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 09.05.2022.
//

import Foundation
import Bond

class AccountViewModel {
    let context: MoneyboxListQuerible
    var model: MoneyboxList? {
        didSet {
            setupProperties()
        }
    }
    let moneyboxes = Observable<[Moneybox]>([])
    
    init(context: MoneyboxListQuerible = MoneyboxListContext()) {
        self.context = context
    }
    
    public func fetchMoneyboxes() {
        context.fetchAllMoneyboxes { result in
            switch result {
            case let .success(moneyboxList):
                self.model = moneyboxList
            default:
                return
            }
        }
    }
    
    private func setupProperties() {
        guard let list = model else { return }
        moneyboxes.value = list.moneyboxes
    }
}
