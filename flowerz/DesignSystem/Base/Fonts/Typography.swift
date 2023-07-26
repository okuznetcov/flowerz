//
//  Typography.swift
//  flowerz
//
//  Created by Кузнецов Олег on 26.07.2023.
//

import UIKit

/// Типографика приложения
public enum Typography {
    
    /// Header 24 Bold -0.5
    case h1Bold
    /// Header 20 Bold -0.5
    case h2Bold
    
    func attributedString(_ string: String) -> NSAttributedString {
        let font: UIFont
        let tracking: CGFloat
        
        switch self {
            
            case .h1Bold:
                font = Font.get(size: 24, weight: .bold)
                tracking = -0.5
            
            case .h2Bold:
                font = Font.get(size: 20, weight: .bold)
                tracking = -0.5
        }
        
        typealias Attribute = NSAttributedString.Key
        let attributes: [Attribute: Any] = [
            Attribute.font: font,
            Attribute.tracking: tracking
        ]
        
        return NSAttributedString(string: string, attributes: attributes)
    }
}
