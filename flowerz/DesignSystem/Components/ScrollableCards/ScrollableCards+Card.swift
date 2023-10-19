//
//  ScrollableCardsWithImages+Card.swift
//  flowerz
//
//  Created by Кузнецов Олег on 26.07.2023.
//

import UIKit
import SnapKit

// MARK: - Components.ScrollableCards + Card

extension Components.ScrollableCards {
    
    /// Одна (единичная — экземпляр) карточка в коллекции карточек с горизонтальной прокруткой
    public final class Card: UICollectionViewCell {
        
        // MARK: - Public Properties

        /// Кнопка, в которой размещается карточка
        public private(set) var button = UIButton()
        
        /// Карточка
        public private(set) var card = Components.ImageWithNameCard()
        
        /// Вызывается при нажатии на карточку
        public var didTapOnCard: (() -> Void)?
        
        // MARK: - Public methods
        
        /// Настраивает экземпляр карточки
        /// - Parameter model: модель
        public func configure(with model: Components.ImageWithNameCard.Model) {
            
            // Добавляем кнопку, в нее помещаем карточку
            addSubview(button)
            button.addSubview(card)
            
            // Настраиваем анимацию нажатия
            button.addTouchAnimation()
            card.isUserInteractionEnabled = false
            
            // Конфигурируем контент в карточке
            card.configure(with: model)
            
            // Настраиваем констрейнты
            card.snp.makeConstraints { $0.edges.equalToSuperview() }
            button.snp.makeConstraints { $0.edges.equalToSuperview() }
            
            // Сеттим действие при нажатии
            button.addHandler(for: .touchUpInside) { [weak self] _ in
                self?.didTapOnCard?()
            }
        }
    }
}
