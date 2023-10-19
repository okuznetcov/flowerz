//
//  MainTabViewInputOutput.swift
//  flowerz
//
//  Created by Кузнецов Олег on 10.07.2023.
//

import Foundation

protocol MainTabViewInput: AnyObject {
    func updateTableView(with model: UniversalTableView.Model)
}

protocol MainTabViewOutput: AnyObject {
    func didTapOnButton()
    func viewDidAppear()
}
