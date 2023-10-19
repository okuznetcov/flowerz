//
//  BaseButton.swift
//  flowerz
//
//  Created by Кузнецов Олег on 14.07.2023.
//

import UIKit
import SnapKit

// MARK: - Components + BaseButton
// ❌ UniversalTableView
// ❌ Eureka

extension Components {
    
    /// Базовая кнопка в приложении. Для кастомных сценариев и карточек. В остальных случаях используйте Button
    open class BaseButton: UIButton {
        
        // MARK: - Public properties
        
        /// Вызывается при событии UIControl touchUpInside
        public var touchUpAction: (() -> Void)?
        
        /// Вызывается после завершения анимации нажатия
        public var pressUpAction: (() -> Void)?
        
        /// Цвет кнопки
        public var color: UIColor = Color.backgroundSecondary {
            didSet {
                
                // Сбрасываем состояние isHighlighted
                isHighlighted = false
                
                // Апдейтим цвет кнопки
                backgroundColor = color
            }
        }
        
        /// Тактильный отклик при нажатии (опционально)
        public var hapticFeedback: UIImpactFeedbackGenerator.FeedbackStyle?
        
        /// Подстветка кнопки
        open override var isHighlighted: Bool {
            didSet {
                
                // Затемняем кнопку если это необходимо
                backgroundColor = isHighlighted ? color.darker() : color
                
                // Апдейтим состояние isHighlighted
                super.isHighlighted = isHighlighted
            }
        }
        
        // MARK: - Init
        
        /// Базовая кнопка в приложении. Для кастомных сценариев и карточек. В остальных случаях используйте Button
        public override init(frame: CGRect) {
            super.init(frame: frame)
            setupButton()
        }
        
        /// Базовая кнопка в приложении. Для кастомных сценариев и карточек. В остальных случаях используйте Button
        public required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupButton()
        }
        
        // MARK: - Override
        
        /// Метод, вызываемый при завершении анимации нажатия
        override func upAnimationCompleted() {
            guard let touchLocation = lastTouch?.location(in: self) else { return }
            if bounds.contains(touchLocation) { pressUpAction?() }
        }
        
        // MARK: - Private properties
        
        private var lastTouch: UITouch?
        
        /// Настраивает кнопку
        private func setupButton() {
            addTouchAnimation()
            addHandler(for: .touchUpInside) { [weak self] _ in
                guard let self = self else { return }
                if let hapticFeedback = self.hapticFeedback {
                    let generator = UIImpactFeedbackGenerator(style: hapticFeedback)
                    generator.impactOccurred()
                }
                
                self.touchUpAction?()
            }
        }
        
        // MARK: - UIControl
        
        open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
            lastTouch = nil
            return super.beginTracking(touch, with: event)
        }
        
        open override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
            lastTouch = touch
            super.endTracking(touch, with: event)
        }
    }
}
