//
//  Input.swift
//  flowerz
//
//  Created by Кузнецов Олег on 03.08.2023.
//

import UIKit
import SnapKit

// MARK: - Components + Input
// ❌ UniversalTableView
// ✅ Eureka — InputRow

extension Components {
    
    /// Поле ввода текста в одну строку с подписью под полем ввода.
    /// Поддерживает разные типы клавиатур.
    public class Input: UIView {
        
        // MARK: - Nested types
        
        /// Размеры
        private enum Sizes {
            /// Вертикальные отсупы от границ элемента
            static let verticalOffsets: CGFloat = 8
            /// Горизонтальные отсупы от границ элемента
            static let horizontalOffsets: CGFloat = 16
        }
        
        // MARK: - Public properties (Proxy)

        /// Модель поля ввода.
        /// При изменении модели компонент обновляется.
        public var model: BaseInput.Model? {
            get { wrappedInput.element.model }
            set { wrappedInput.element.model = newValue }
        }
        
        /// Текст под полем ввода.
        /// При изменении компонент обновляется.
        public var bottomCaption: String? {
            get { wrappedInput.text }
            set { wrappedInput.text = newValue }
        }
        
        /// Флаг, пусто ли поля ввода
        public var isEmpty: Bool {
            wrappedInput.element.isEmpty
        }
        
        /// Текст в поле ввода.
        /// При изменении компонент обновляется
        public var text: String? {
            get { wrappedInput.element.text }
            set { wrappedInput.element.text = newValue }
        }
        
        /// Вызывается, когда текст в поле ввода был изменен
        public var didChangedText: ((Components.BaseInput) -> Void)? {
            get { wrappedInput.element.didChangedText }
            set { wrappedInput.element.didChangedText = newValue }
        }
        
        /// Вызывается при старте взаимодействия с полем (компонент становится firstResponder)
        public var didStartEditing: ((Components.BaseInput) -> Void)? {
            get { wrappedInput.element.didStartEditing }
            set { wrappedInput.element.didStartEditing = newValue }
        }
        
        /// Вызывается при окончании взаимодействия с полем (компонент прекращает быть firstResponder)
        public var didFinishEditing: ((Components.BaseInput) -> Void)? {
            get { wrappedInput.element.didFinishEditing }
            set { wrappedInput.element.didFinishEditing = newValue }
        }
        
        // MARK: - Private properties
        
        /// Поле ввода
        private let wrappedInput: CaptionWrapper<BaseInput> = {
            let input = BaseInput()
            let wrapper = CaptionWrapper(element: input)
            return wrapper
        }()
        
        // MARK: - Init
        
        /// Поле ввода текста в одну строку с подписью под полем ввода.
        /// Поддерживает разные типы клавиатур.
        public init() {
            super.init(frame: .zero)
            addSubview(wrappedInput)
            wrappedInput.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(Sizes.verticalOffsets)
                make.leading.trailing.equalToSuperview().inset(Sizes.horizontalOffsets)
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
