//
//  Typography.swift
//  flowerz
//
//  Created by Кузнецов Олег on 26.07.2023.
//

import UIKit

/// Типографика приложения
public enum Typography {
    
    /// Header 28 Bold -1.0
    case h1PromoBold
    
    /// Header 24 Bold -0.5
    case h1Bold
    
    /// Header 20 Bold -0.5
    case h2Bold
    
    /// Header 15 Bold -0.5
    case h3Bold
    
    /// Header 15 Semibold -0.5
    case h3Semibold
    
    /// Paragraph 15 Regular -0.5
    case p1Regular
    
    /// Paragraph 15 Medium -0.5
    case p1Medium
    
    /// Paragraph 12 Regular 0.0
    case p2Regular
    
    /// Paragraph 12 Medium 0.0
    case p2Medium
    
    /// Paragraph 10 Compact -0.5
    case p3Compact
    
    /*func font() -> UIFont {
        switch self {
            
        case .h1PromoBold:
            return Font.get(size: 28, weight: .bold)
            tracking = -1.0
            
        case .h1Bold:
            return Font.get(size: 24, weight: .bold)
            tracking = -0.5
            
        case .h2Bold:
            return Font.get(size: 20, weight: .bold)
            tracking = -0.5
            
        case .h3Bold:
            return Font.get(size: 15, weight: .bold)
            tracking = -0.5
            
        case .h3Semibold:
            return Font.get(size: 15, weight: .semibold)
            tracking = -0.5
            
        case .p1Regular:
            font = Font.get(size: 15, weight: .regular)
            tracking = -0.5
            
        case .p2Regular:
            font = Font.get(size: 12, weight: .regular)
            
        case .p2Medium:
            font = Font.get(size: 12, weight: .medium)
            
        case .p3Compact:
            font = Font.get(size: 10, weight: .regular)
            tracking = -0.5
        }
    }*/
    
    func attributedString(_ string: String) -> NSAttributedString {
        let font: UIFont
        var tracking: CGFloat = 0
        
        switch self {
            
        case .h1PromoBold:
            font = Font.get(size: 28, weight: .bold)
            tracking = -1.0
            
        case .h1Bold:
            font = Font.get(size: 24, weight: .bold)
            tracking = -0.5
            
        case .h2Bold:
            font = Font.get(size: 20, weight: .bold)
            tracking = -0.5
            
        case .h3Bold:
            font = Font.get(size: 15, weight: .bold)
            tracking = -0.5
            
        case .h3Semibold:
            font = Font.get(size: 15, weight: .semibold)
            tracking = -0.5
            
        case .p1Regular:
            font = Font.get(size: 15, weight: .regular)
            tracking = -0.5
            
        case .p1Medium:
            font = Font.get(size: 15, weight: .medium)
            
        case .p2Regular:
            font = Font.get(size: 12, weight: .regular)
            
        case .p2Medium:
            font = Font.get(size: 12, weight: .medium)
            
        case .p3Compact:
            font = Font.get(size: 10, weight: .regular)
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
