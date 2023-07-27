//
//  BaseButton.swift
//  flowerz
//
//  Created by Кузнецов Олег on 14.07.2023.
//

import UIKit

/// Базовая кнопка в приложении
open class BaseButton: UIButton {
   
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
    
    /// Подстветка кнопки
    open override var isHighlighted: Bool {
        didSet {
            // Затемняем кнопку если это необходимо
            backgroundColor = isHighlighted ? color.darker() : color
            // Апдейтим состояние isHighlighted
            super.isHighlighted = isHighlighted
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
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
        addHandler(for: .touchUpInside) { [weak self] _ in self?.touchUpAction?() }
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
