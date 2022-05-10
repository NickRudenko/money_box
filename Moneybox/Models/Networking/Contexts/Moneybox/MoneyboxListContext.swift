//
//  MoneyboxListContext.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 09.05.2022.
//

import Foundation
import Fetch

public protocol MoneyboxListQuerible {
    /// perform fetching all event categories
    func fetchAllMoneyboxes(completion: @escaping (FetchResult<MoneyboxList>) -> Void)
}

public final class MoneyboxListContext: MoneyboxListQuerible {
    let session = Session()
    
    public func fetchAllMoneyboxes(completion: @escaping (FetchResult<MoneyboxList>) -> Void) {
        let request = MoneyboxListRequest()
        session.perform(request, completion: completion)
    }

}
