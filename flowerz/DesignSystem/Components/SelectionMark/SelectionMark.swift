//
//  SelectionMark.swift
//  flowerz
//
//  Created by Кузнецов Олег on 15.08.2023.
//

import UIKit

// MARK: - Components + SelectionMark
// Базовый компонент. Не содержит реализаций для Eureka и универсальной таблицы.

extension Components {
    
    /// Отметка выбора в приложении. Может быть чекбоксом или радиобатоном. Базовый компонент.
    public final class SelectionMark: UIView {
        
        // MARK: - Nested types
        
        /// Стиль
        public enum Style {
            /// Радиобаттон (выбор только одного варианта)
            case radiobutton
            /// Чекбокс (множественный выбор)
            case checkbox
            case checkmark
        }
        
        /// Константы
        private enum Consts {
            
            /// Изображения
            enum Images {
                
                /// Радиобаттон (выбор только одного варианта)
                enum Radiobutton {
                    /// Выбран
                    static let selected = UIImage.resolve(named: "radiobuttonSelected")
                    /// Не выбран
                    static let unselected = UIImage.resolve(named: "radiobuttonUnselected")
                    /// Форма (фон) радиобаттона
                    static let shape = UIImage.resolve(named: "radiobuttonShape")
                }
                
                /// Чекбокс (множественный выбор)
                enum Checkbox {
                    /// Выбран
                    static let selected = UIImage.resolve(named: "checkboxSelected")
                    /// Не выбран
                    static let unselected = UIImage.resolve(named: "checkboxUnselected")
                    /// Форма (фон) чекбокса
                    static let shape = UIImage.resolve(named: "checkboxShape")
                }
                
                /// Чекбокс (множественный выбор)
                enum Checkmark {
                    /// Выбран
                    static let selected = UIImage.resolve(named: "checkmark")
                }
            }
            
            /// Цвета
            enum Colors {
                /// Цвет формы (фона) компонента
                static let shape: UIColor = Color.backgroundSecondary
                /// Цвет для состояния "выбрано"
                static let selected: UIColor = .systemBlue
                /// Цвет для состояния "не выбрано"
                static let unselected: UIColor = Color.controlDefault
            }
            
            /// Размер отметки выбора
            static var size: CGFloat = 30
        }
        
        // MARK: - Public properties
        
        /// Флаг, показывающий отметку выбора. При изменении компонент обновляется.
        public var isSelected: Bool = false {
            didSet { updateImage() }
        }
        
        /// Стиль отметки выбора (чекбокс / радиобаттон). При изменении компонент обновляется.
        public var style: Style {
            didSet { updateImage() }
        }
        
        // MARK: - Private properties
        
        /// Изображение чекбокса / радиобатона
        private let image = UIImageView()
        
        /// Фоновое изображение чекбокса / радиобатона
        private let shapeImage = UIImageView()
        
        // MARK: - Init
        
        /// Отметка выбора в приложении. Может быть чекбоксом или радиобатоном. Базовый компонент.
        /// - Parameter style: стиль отметки выбора (радиобаттон / чекбокс)
        public init(style: Style) {
            self.style = style
            super.init(frame: .zero)
            setup()
        }
        
        required public init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Layout
        
        /// Размер компонента
        public override var intrinsicContentSize: CGSize {
            .init(width: Consts.size, height: Consts.size)
        }
        
        // MARK: - Methods
        
        /// Настраивает компонент
        private func setup() {
            addSubview(shapeImage)
            addSubview(image)
            
            image.snp.makeConstraints { make in
                make.edges.equalToSuperview()
                make.width.height.equalTo(Consts.size).priority(.required)
            }
            
            shapeImage.snp.makeConstraints { make in
                make.edges.equalTo(image).priority(.required)
            }
            
            updateImage()
        }
        
        /// Обновляет изображение в компоненте
        private func updateImage() {
            let image: UIImage
            let shape: UIImage
            
            // В зависимости от стиля (чекбокс / радиобатон) выбираем нужный сет изображений
            switch style {
                
                case .checkbox:
                    typealias Images = Consts.Images.Checkbox
                
                    // В зависимости от состояния (выбран / не выбран) выбираем нужное изображение чекбокса
                    image = isSelected ? Images.selected : Images.unselected
                    shape = Images.shape
                
                case .radiobutton:
                    typealias Images = Consts.Images.Radiobutton
                
                    // В зависимости от состояния (выбран / не выбран) выбираем нужное изображение радиобатона
                    image = isSelected ? Images.selected : Images.unselected
                    shape = Images.shape
                
                case .checkmark:
                    typealias Images = Consts.Images.Checkmark
                
                    image = isSelected ? Images.selected : UIImage()
                    shape = UIImage()
            }
            
            // Обновляем цвет компонента на основе отметки выбора
            typealias Color = Consts.Colors
            let color: UIColor = isSelected ? Color.selected : Color.unselected
            self.image.image = image.withTintColor(color, renderingMode: .alwaysOriginal)
            
            // Обновляем цвет фона
            self.shapeImage.image = shape.withTintColor(Color.shape)
        }
    }
}
