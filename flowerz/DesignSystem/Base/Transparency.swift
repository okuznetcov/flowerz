//
//  Transparency.swift
//  flowerz
//
//  Created by Кузнецов Олег on 24.08.2023.
//

import Foundation

// MARK: - Float / CGFloat + Transparency

public extension Float {
    /// Компонент скрыт (полностью прозрачный)
    static let hidden: Float = 0.0
    /// Компонент отображается (полностью непрозрачный)
    static let visible: Float = 1.0
}

public extension CGFloat {
    /// Компонент скрыт (полностью прозрачный)
    static let hidden: CGFloat = 0.0
    /// Компонент отображается (полностью непрозрачный)
    static let visible: CGFloat = 1.0
}
