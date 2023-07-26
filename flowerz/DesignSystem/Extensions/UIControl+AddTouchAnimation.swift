//
//  UIControl+AddTouchAnimation.swift
//  flowerz
//
//  Created by Кузнецов Олег on 11.07.2023.
//

import UIKit

// MARK: - UIControl + AddTouchAnimation

/// Extension для UIControl реализующий анимацию "вдавливания" объекта при нажатии
extension UIControl {
    
    /// Анимации
    private enum Animations {
        
        /// Анимация "вдавливания" вниз
        enum Down {
            /// Размер объекта при вдавливании (%)
            static let scale: CGFloat = 0.95
            /// Время анимации (сек.)
            static let duration = 0.1
            /// Кривая, по которой будет выполняться анимация
            static let curve: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseIn]
            /// Триггеры (UIControl.Event) которые запустят анимацию
            static let triggers: UIControl.Event = [.touchDown]
        }
        
        /// Анимация "подъема" наверх
        enum Up { // swiftlint:disable:this type_name
            /// Время анимации (сек.)
            static let duration = 0.1
            /// Кривая, по которой будет выполняться анимация
            static let curve: UIView.AnimationOptions = [.allowUserInteraction, .curveEaseOut]
            /// Триггеры (UIControl.Event) которые запустят анимацию
            static let triggers: UIControl.Event = [.touchDragExit, .touchUpInside, .touchUpOutside, .touchCancel]
        }
    }
    
    /// Добавляет анимацию "вдавливания" объекта при нажатии. Может быть применено для любого UIControl
    public func addTouchAnimation() {
        addTarget(self, action: #selector(downAnimation), for: Animations.Down.triggers)
        addTarget(self, action: #selector(upAnimation), for: Animations.Up.triggers)
    }
    
    /// Выполняет анимацию "вдавливания" вниз
    @objc private func downAnimation() {
        typealias Animation = Animations.Down
        
        UIView.animate(
            withDuration: Animation.duration,
            delay: 0.0,
            options: Animation.curve,
            animations: {
                self.layer.transform = CATransform3DMakeScale(Animation.scale, Animation.scale, 1)
            },
            completion: { _ in
                self.upAnimation()
            }
        )
    }
    
    /// Выполняет анимацию "подъема" наверх
    @objc private func upAnimation() {
        typealias Animation = Animations.Up
        
        if !isTracking && layer.animation(forKey: "transform") == nil {
            UIView.animate(
                withDuration: Animation.duration,
                delay: 0.0,
                options: Animation.curve,
                animations: {
                    self.layer.transform = CATransform3DIdentity
                },
                completion: { _ in
                    self.upAnimationCompleted()
                }
            )
        }
    }
    
    @objc func upAnimationCompleted() {}
}
