//
//  Initialisation.swift
//  Moneybox
//
//  Created by Mykola Rudenko on 07.05.2022.
//

import Hopoate

func register<T>(_ dependency: T, for type: T.Type) {
    DependencyContainer.shared.register(dependency, for: type)
}
