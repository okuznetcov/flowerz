//
//  Collection+Safe.swift
//  flowerz
//
//  Created by Кузнецов Олег on 13.07.2023.
//

import Foundation

// MARK: - Collection+Safe
/// Безопасно извлекает объект из Collection по указанному индексу

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
