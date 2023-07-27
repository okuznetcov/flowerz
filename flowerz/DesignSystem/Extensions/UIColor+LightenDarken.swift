//
//  UIColor+LightenDarken.swift
//  flowerz
//
//  Created by Кузнецов Олег on 27.07.2023.
//

import UIKit

// MARK: - UIColor + LightenDarken

/// Затемнения и осветления цветов
public extension UIColor {
    
    /// Делает цвет светлее
    /// - Parameter by: коэфициент, насколько светлее нужно сделать цвет (по-умолчанию 0.05)
    /// - Returns: новый, более светлый цвет
    func lighter(by delta: CGFloat = 0.05) -> UIColor {
        return makeColor(componentDelta: delta)
    }
    
    /// Делает цвет темнее
    /// - Parameter by: коэфициент, насколько темнее нужно сделать цвет (по-умолчанию 0.05)
    /// - Returns: новый, более темный цвет
    func darker(by delta: CGFloat = 0.05) -> UIColor {
        return makeColor(componentDelta: -1 * delta)
    }
    
    /// Добавляет величину к текущему CGFloat придерживаясь ограничений цветого представления r,g,b,a каналов
    private func add(_ value: CGFloat, toComponent: CGFloat) -> CGFloat {
        return max(0, min(1, toComponent + value))
    }
    
    private func makeColor(componentDelta: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Получаем r,g,b,a значения текущего цвета UIColor
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Создаем новый цвет, добавляя дельту к каждому компоненту, кроме alpha
        return UIColor(
            red: add(componentDelta, toComponent: red),
            green: add(componentDelta, toComponent: green),
            blue: add(componentDelta, toComponent: blue),
            alpha: alpha
        )
    }
}
