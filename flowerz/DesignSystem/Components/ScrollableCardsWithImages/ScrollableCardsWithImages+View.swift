//
//  DryPlantsCell.swift
//  flowerz
//
//  Created by Кузнецов Олег on 14.07.2023.
//

import UIKit
import SnapKit

// MARK: - ScrollableCardsWithImages + View

/// Карточки с изображениями и горизонтальной прокруткой
extension ScrollableCardsWithImages {
    
    /// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой
    public final class View: UIView {
        
        /// Константы
        private enum Consts {

            /// Размеры
            enum Sizes {
                /// Внешние отступы до границ компонента
                static let defaultOffsets: UIEdgeInsets = .init(top: 16, left: 16, bottom: 16, right: 16)
                /// Карточка
                enum Card {
                    /// Ширина карточки
                    static let width: CGFloat = 114
                    /// Высота карточки
                    static let height: CGFloat = 150
                }
            }

            /// ReuseIdentifier карточки
            static let cardReuseIdentifier = "card"
        }
        
        // MARK: - Public properties
        
        /// Вызывается при нажатии на карточку
        public var didTapOnCard: (() -> Void)?

        /// СollectionView, в котором лежат карточки
        private let collectionView: UICollectionView = {
            typealias Sizes = Consts.Sizes.Card
            
            // Настойки лейаута коллекции карточек
            let layout = UICollectionViewFlowLayout()
            
            // Размеры
            layout.sectionInset = Consts.Sizes.defaultOffsets
            
            // Размеры карточки
            layout.itemSize = .init(width: Sizes.width, height: Sizes.height)
            
            // Направление скролла
            layout.scrollDirection = .horizontal
            
            // UICollectionView
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            
            // Настраиваем коллекцию
            collection.backgroundColor = .clear
            collection.showsHorizontalScrollIndicator = false
            collection.showsVerticalScrollIndicator = false
            
            // Регистрируем ячейку
            collection.register(Card.self, forCellWithReuseIdentifier: Consts.cardReuseIdentifier)

            return collection
        }()
        
        /// Модель
        private var model: Model {
            didSet { collectionView.reloadData() }
        }
        
        /// /// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой
        /// - Parameter model: модель данных, на основе которой будет отрисован компонент
        public init(with model: Model) {
            self.model = model
            super.init(frame: .zero)
            collectionView.dataSource = self
            collectionView.layoutIfNeeded()
            setup(using: model)
            makeConstraints()
        }
        
        @available(*, unavailable)
        required init?(coder aDecoder: NSCoder) { return nil }
        
        /// Настраивает компонент
        /// - Parameter model: модель
        private func setup(using model: Model) {
            // Добавляем сколлвью
            addSubview(collectionView)
        }
        
        /// Настраивает констрейнты
        private func makeConstraints() {
            collectionView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}

// MARK: - View + UICollectionViewDataSource

extension ScrollableCardsWithImages.View: UICollectionViewDataSource {
    
    /// Возвращает число элементов в секции collectionView
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - section: секция
    /// - Returns: число элементов в секции collectionView
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.cards.count
    }
    
    /// Возвращает ячейку collectionView для нужного indexPath
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - indexPath: индекс, для которого будет возвращена сконфигурированная ячейка
    /// - Returns: карточка для нужного indexPath
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        // Получаем модель карточки и регистрируем ее в collectionView
        guard
            let cardModel = model.cards[safe: indexPath.row],
            let cell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: Consts.cardReuseIdentifier,
                    for: indexPath as IndexPath
                ) as? Card
        else { return UICollectionViewCell() }
        
        // Конфигурируем карточку
        cell.configure(with: cardModel)
        return cell
    }
}
