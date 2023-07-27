//
//  DryPlantsCell+Card.swift
//  flowerz
//
//  Created by Кузнецов Олег on 26.07.2023.
//

import UIKit
import SnapKit

// MARK: - ScrollableCardsWithImages.View + Card

/// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой
extension ScrollableCardsWithImages.View {
    
    /// Ячейка-карточка с картинкой, заголовком и подзаголовком
    /// Группа карточек образует компонент с изображениями и горизонтальной прокруткой
    /// Является экземпляром коллекции UICollectionView
    public final class Card: UICollectionViewCell {
        
        /// Модель карточки
        public struct Model {
            /// Заголовок
            public let title: String
            /// Подзаголовок
            public let subTitle: String
            /// Изображение
            public let image: UIImage
        }
        
        /// Размеры
        enum Sizes {
            /// Скругление углов карточки
            static let cornerRadius: CGFloat = 11
            /// Внутренние отступы от границ карточки
            static let innerOffsets = 8
            /// Расстояние между картинкой и текстом
            static let spacingBetweenImageAndText = 8
            /// Высота теста
            static let textHeight = 16
        }

        /// Карточка, в которой отображается заголовок, подзаголовок и картика
        public private(set) var card: BaseButton = {
            let view = BaseButton()
            view.backgroundColor = Color.backgroundSecondary
            view.layer.cornerRadius = Sizes.cornerRadius
            view.layer.masksToBounds = true
            return view
        }()
        
        /// Изображение в карточке
        private let image: UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFill
            image.layer.cornerRadius = Sizes.cornerRadius
            image.clipsToBounds = true
            return image
        }()

        /// Заголовок карточки
        public private(set) var titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 1
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            return label
        }()

        /// Подзаголовок карточки
        public private(set) var subTitleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 1
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            label.textColor = Color.textSecondary
            
            return label
        }()

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError()
        }
        
        /// Ячейка-карточка с картинкой, заголовком и подзаголовком
        /// Группа карточек образует компонент с изображениями и горизонтальной прокруткой
        /// Является экземпляром коллекции UICollectionView
        /// - Parameter model: модель данных, на основе которой будет отрисована карточка
        public func configure(with model: Model) {
            setup(using: model)
            makeConstraints()
        }

        /// Ячейка-карточка с картинкой, заголовком и подзаголовком
        /// Группа карточек образует компонент с изображениями и горизонтальной прокруткой
        /// Является экземпляром коллекции UICollectionView
        /// - Parameter frame: область
        public override init(frame: CGRect) {
            super.init(frame: frame)
        }

        /// Настраивает карточку согласно переданной модели
        /// - Parameter model: модель карточки
        private func setup(using model: Model) {
            titleLabel.attributedText = .styled(model.title, with: .p2Medium)
            subTitleLabel.attributedText = .styled(model.subTitle, with: .p3Compact)
            image.image = model.image
            
            contentView.addSubview(card)
            card.addSubview(image)
            card.addSubview(titleLabel)
            card.addSubview(subTitleLabel)
        }

        /// Настраивает констрейнты
        private func makeConstraints() {
            card.snp.makeConstraints { $0.edges.equalToSuperview() }
            image.snp.makeConstraints { make in
                make.width.equalTo(image.snp.height)
                make.leading.trailing.top.equalTo(card).inset(Sizes.innerOffsets)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(image.snp.bottom).offset(Sizes.spacingBetweenImageAndText)
                make.leading.trailing.equalToSuperview().inset(Sizes.innerOffsets)
                make.height.equalTo(Sizes.textHeight)
            }
            
            subTitleLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom)
                make.leading.trailing.equalTo(titleLabel)
                make.bottom.equalToSuperview().inset(Sizes.innerOffsets)
                make.height.equalTo(titleLabel)
            }
        }
    }
}
