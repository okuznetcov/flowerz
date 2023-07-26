//
//  NSAttributedString+Styled.swift
//  flowerz
//
//  Created by Кузнецов Олег on 26.07.2023.
//

import UIKit

public extension NSAttributedString {
    
    /// Стилизованная строка согласно переданной типографике
    /// - Parameters:
    ///   - string: строка, к которой будет применен стиль
    ///   - typo: стиль типографики
    /// - Returns: NSAttributedString
    static func styled(_ string: String, with typo: Typography) -> NSAttributedString {
        return typo.attributedString(string)
    }
}
