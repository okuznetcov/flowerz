//
//  BadgeGroup.swift
//  flowerz
//
//  Created by Кузнецов Олег on 12.07.2023.
//

import UIKit
import SnapKit

// MARK: - Components + BadgeGroup

extension Components {
    
    /// Группа бейджей
    /// Отображает любое количество бейджей с различными цветами и текстом
    public final class BadgeGroup: UIView {
        
        // MARK: - Nested Types

        /// Константы
        private enum Consts {
            
            /// Шрифт в бейдже
            static let typography: Typography = .p2Regular
            /// Цвет текста в бейдже
            static let textColor: UIColor = Color.textWhite
            
            /// Размеры
            enum Sizes {
                /// Горизонтальное расстояние между бейджами
                static let horizontalSpacing: CGFloat = 8
                /// Вертикальное расстояние между бейджами
                static let verticalSpacing: CGFloat = 8
                
                enum Badge {
                    /// Высота бейджа
                    static let height: CGFloat = 22
                    /// Паддинг бейджа
                    static let padding: CGFloat = 16
                }
            }
        }
        
        // MARK: - Public properties
        
        /// Массив моделей бейджей
        /// При изменении модели компонент обновляется
        public var badges: [Badge] = [] {
            didSet { updateBadges() }
        }
        
        // MARK: - Private properties
        
        /// Высота view
        private var intrinsicHeight: CGFloat = 0
        
        // MARK: - Init
        
        /// Группа бейджей
        /// - Отображает любое количество бейджей с различными цветами и текстом
        public init() {
            super.init(frame: .zero)
        }
        
        @available(*, unavailable)
        required init?(coder aDecoder: NSCoder) {
            return nil
        }
        
        // MARK: - Public methods
        
        /// Размер View
        public override var intrinsicContentSize: CGSize {
            var contentSize = super.intrinsicContentSize
            contentSize.height = intrinsicHeight
            return contentSize
        }
        
        public override func layoutSubviews() {
            super.layoutSubviews()
            showBadges()
        }
        
        // MARK: - Private methods
        
        /// Обновляет бэйджы в компоненте при изменении массива моделей
        private func updateBadges() {
            
            // Удаляем бэйджы если subview больше, чем моделей
            while self.subviews.count > badges.count {
                //self.subviews[0].removeFromSuperview()
                self.subviews.first?.removeFromSuperview()
            }
            
            // Создаем бейджы если subview меньше, чем моделей
            while self.subviews.count < badges.count {
                
                // Создаем бейдж
                let badge = UILabel()
                badge.textAlignment = .center
                badge.layer.masksToBounds = true
                badge.makeRoundCorners(radius: Consts.Sizes.Badge.height / 2)
                addSubview(badge)
            }
            
            // Проходимся по всем бейджам и настраиваем их согласно моделям
            for (model, view) in zip(badges, self.subviews) {
                guard let label = view as? UILabel else { return }
                label.attributedText = .styled(model.text, with: Consts.typography)
                label.textColor = Consts.textColor
                label.backgroundColor = model.color
                label.frame.size.width = label.intrinsicContentSize.width + Consts.Sizes.Badge.padding
                label.frame.size.height = Consts.Sizes.Badge.height
            }
        }
        
        /// Отображает бэйджи на View
        private func showBadges() {
            
            // Задаем начальные координаты
            var currentOriginX: CGFloat = 0
            var currentOriginY: CGFloat = 0
            
            // Проходимся по всем subviews (бэйджам)
            self.subviews.forEach { badge in
                guard let badge = badge as? UILabel else { return }
                
                // Если бэйдж не влезает в ширину контейнера, двигаем его ниже на новую строку
                if currentOriginX + badge.frame.width > bounds.width {
                    currentOriginX = 0
                    currentOriginY += Consts.Sizes.Badge.height + Consts.Sizes.verticalSpacing  // Перенос координаты Y
                }
                
                // Задаем координаты бейджа
                badge.frame.origin.x = currentOriginX
                badge.frame.origin.y = currentOriginY
                
                // Переносим координату X на конец текущего бейджа + отсуп
                currentOriginX += badge.frame.width + Consts.Sizes.horizontalSpacing
            }
            
            // Обновляем величину высоты view
            intrinsicHeight = currentOriginY + Consts.Sizes.Badge.height
            invalidateIntrinsicContentSize()
        }
    }
}
