//
//  Title.swift
//  flowerz
//
//  Created by Кузнецов Олег on 18.07.2023.
//

import UIKit
import SnapKit

// MARK: - Components + Title
// ✅ UniversalTableView — TitleItem
// ✅ Eureka — TitleRow

extension Components {
    
    /// Компонент заголовок + подзаголовок
    public final class Title: UIView {

        // MARK: - Nested Types
        
        /// Размеры
        private enum Sizes {
            /// Вертикальное расстояние между контентом
            static let verticalSpaceBetweenContent: CGFloat = 10
            /// Внешние отступы до границ компонента
            static let defaultOffsets: UIEdgeInsets = .init(top: 24, left: 32, bottom: 24, right: 32)
        }
        
        /// Модель данных, на основе которой будет отрисован компонент
        /// При изменении модели компонент обновляется
        public var model: Model? {
            didSet {
                guard let model = model else { return }
                setup(using: model)
            }
        }

        // MARK: - Elements
        
        /// Вертикальный контейнер, в котором размещается контент
        private let contentContainer: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = Sizes.verticalSpaceBetweenContent
            stack.isUserInteractionEnabled = false
            
            return stack
        }()
        
        /// Заголовок
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = Color.textPrimary
            label.isUserInteractionEnabled = false
            label.textAlignment = .center
            label.numberOfLines = 0
            
            return label
        }()
        
        /// Подзаголовок
        private let subtitleLabel: UILabel = {
            let label = UILabel()
            label.textColor = Color.textSecondary
            label.isUserInteractionEnabled = false
            label.textAlignment = .center
            label.numberOfLines = 0
            
            return label
        }()

        // MARK: - Init
        
        /// Компонент заголовок + подзаголовок
        /// - Parameter model: модель данных, на основе которой будет отрисован компонент
        public init(with model: Model) {
            super.init(frame: .zero)
            
            // Добавляем контейнер
            addSubview(contentContainer)
            
            setup(using: model)
            makeConstraints()
        }
        
        @available(*, unavailable)
        required init?(coder aDecoder: NSCoder) { return nil }
        
        // MARK: - Private methods
        
        /// Настраивает компонент
        /// - Parameter model: модель
        private func setup(using model: Model) {
            
            // Убираем все текущие сабвью в контейнере
            contentContainer.subviews.forEach { label in
                label.removeFromSuperview()
            }
            
            // В контейнер помещаем заголовок и подзаголовок
            contentContainer.addArrangedSubview(titleLabel)
            contentContainer.addArrangedSubview(subtitleLabel)
            
            let title = model.title ?? ""
            let subtitle = model.subtitle ?? ""
            
            if !title.isEmpty {
                // Обновляем текст в заголовке
                titleLabel.attributedText = .styled(title, with: .h3Semibold)
            } else {
                // Если текст пустой или не пришел вовсе, скрываем заголовок
                titleLabel.isHidden = true
            }
            
            if !subtitle.isEmpty {
                // Обновляем текст в подзаголовке карточки
                subtitleLabel.attributedText = .styled(subtitle, with: .p2Regular)
            } else {
                // Если текст пустой или не пришел вовсе, скрываем подзаголовок
                subtitleLabel.isHidden = true
            }
        }
        
        /// Настраивает констрейнты
        private func makeConstraints() {
            contentContainer.snp.makeConstraints {
                $0.leading.trailing.top.equalToSuperview().inset(Sizes.defaultOffsets)
                $0.bottom.equalToSuperview().inset(Sizes.defaultOffsets).priority(.high)
            }
        }
    }
}
