//
//  LabelWithName.swift
//  flowerz
//
//  Created by Кузнецов Олег on 30.07.2023.
//

import UIKit
import SnapKit

// MARK: - Components + LabelWithName

extension Components {
    
    /// Лейбл с названием (заголовком)
    public final class LabelWithName: UIView {
        
        // MARK: - Nested Types

        /// Размеры
        private enum Sizes {
            /// Горизонтальные отсупы
            static let horizontalOffset: CGFloat = 16
            /// Вертикальные отступы
            static let verticalOffset: CGFloat = 8
            /// Расстояние между названием и основным текстом
            static let spacingBetweenNameAndText: CGFloat = 4
        }
        
        // MARK: - Public properies
        
        /// Модель лейбла.
        /// При изменении модели компонент обновляется
        public var model: Model? {
            didSet {
                guard let model = model else { return }
                setup(using: model)
            }
        }
        
        // MARK: - Private properies
        
        /// Название
        private let nameLabel: UILabel = {
            let label = UILabel()
            label.textColor = Color.textSecondary
            label.isUserInteractionEnabled = false
            label.numberOfLines = 1
            
            return label
        }()
        
        /// Основной текст
        private let textLabel: UILabel = {
            let label = UILabel()
            label.textColor = Color.textPrimary
            label.isUserInteractionEnabled = false
            label.numberOfLines = 0
            
            return label
        }()
        
        // MARK: - Init
        
        /// Лейбл с названием (заголовком)
        /// - Parameter model: модель лейбла
        public init(with model: Model) {
            super.init(frame: .zero)
            addSubviews()
            setup(using: model)
            makeConstraints()
        }
        
        @available(*, unavailable)
        required init?(coder aDecoder: NSCoder) { return nil }
        
        // MARK: - Private methods
        
        /// Добавляет сабвью
        private func addSubviews() {
            addSubview(nameLabel)
            addSubview(textLabel)
        }
        
        /// Обновляет текст в лейблах
        /// - Parameter model: модель лейбла
        private func setup(using model: Model) {
            nameLabel.attributedText = .styled(model.name, with: .p2Regular)
            textLabel.attributedText = .styled(model.text, with: .p2Medium)
        }
        
        /// Настраивает констрейнты
        private func makeConstraints() {
            
            // Убираем все констрейнты
            nameLabel.snp.removeConstraints()
            textLabel.snp.removeConstraints()
            
            // Настраиваем новые констрейнты
            nameLabel.snp.makeConstraints {
                $0.top.equalToSuperview().inset(Sizes.verticalOffset)
                $0.leading.equalToSuperview().inset(Sizes.horizontalOffset)
                $0.trailing.equalToSuperview().inset(Sizes.horizontalOffset)
            }
            
            textLabel.snp.makeConstraints {
                $0.leading.trailing.equalTo(nameLabel)
                $0.top.equalTo(nameLabel.snp.bottom).offset(Sizes.spacingBetweenNameAndText)
                $0.bottom.lessThanOrEqualToSuperview().inset(Sizes.verticalOffset)
            }
        }
    }
}
