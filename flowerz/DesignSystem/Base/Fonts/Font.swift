//
//  Font.swift
//  flowerz
//
//  Created by Кузнецов Олег on 12.07.2023.
//

import UIKit

// MARK: - Font

/// Шрифт в приложении
public enum Font {

    enum Weight {
        case thin
        case extraLight
        case light
        case regular
        case medium
        case semibold
        case bold
        case extraBold
        case black
        
        func asFontPostfix() -> String {
            switch self {
                case .thin:
                    return "Thin"
                case .extraLight:
                    return "ExtraLight"
                case .light:
                    return "Light"
                case .regular:
                    return "Regular"
                case .medium:
                    return "Medium"
                case .semibold:
                    return "SemiBold"
                case .bold:
                    return "Bold"
                case .extraBold:
                    return "ExtraBold"
                case .black:
                    return "Black"
            }
        }
    }
    
    /// Возвращает шрифт типа UIFont для заданного размера и веса
    /// - Parameters:
    ///   - size: размер
    ///   - weight: вес
    /// - Returns: шрифт UIFont
    static func get(size: CGFloat, weight: Weight) -> UIFont {
        return UIFont(name: "Inter-\(weight.asFontPostfix())", size: size) ?? UIFont()
    }
}
