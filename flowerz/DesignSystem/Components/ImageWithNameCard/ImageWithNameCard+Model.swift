//
//  ImageWithNameCard+Model.swift
//  flowerz
//
//  Created by Кузнецов Олег on 01.08.2023.
//

import UIKit

// MARK: - Components.ImageWithNameCard + Model

extension Components.ImageWithNameCard {
    
    /// Модель карточки
    public struct Model {
        
        public enum SelectionStyle {
            case checkboxAtCorner
            case hugeCheckboxOverImage
            case radiobuttonAtCorner
        }
        
        public enum Accessory {
            case button(title: String, didTapOnButton: (() -> Void)?)
            case text(title: String, subTitle: String)
        }
        
        /// Изображение
        public var image: UIImage
        public var accessory: Accessory
        public var selectionStyle: SelectionStyle?
    }
}
