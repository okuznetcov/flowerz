//
//  MainTabModule.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import Foundation

protocol MainTabModuleInput: AnyObject {
    func show()
}

protocol MainTabModuleOutput: AnyObject {
    var didTapButton: (() -> Void)? { get set }
}

final class MainTabModule: Module<MainTabModuleInput, MainTabModuleOutput> { }
