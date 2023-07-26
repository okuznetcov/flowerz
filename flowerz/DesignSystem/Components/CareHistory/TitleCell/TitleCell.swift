//
//  TitleCell.swift
//  flowerz
//
//  Created by Кузнецов Олег on 18.07.2023.
//

import UIKit
import SnapKit

// MARK: - CareHistory + TitleCell

extension CareHistory {
    
    /// Ячейка заголовок + подзаголовок на экране истории ухода за цветами
    public final class TitleCell: UIView {

        // MARK: - Nested Types
        
        /// Размеры
        private enum Sizes {
            /// Вертикальное расстояние между контентом в карточке
            static let verticalSpaceBetweenContent: CGFloat = 10
            /// Внешние отступы до границ карточки
            static let defaultOffsets: UIEdgeInsets = .init(top: 24, left: 32, bottom: 24, right: 32)
        }

        // MARK: - Elements
        
        /// Вертикальный контейнер, который лежит в карточке и в котором размещается контент
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
        
        /// Ячейка заголовок + подзаголовок на экране истории ухода за цветами
        /// - Parameter model: модель данных, на основе которой будет отрисована ячейка
        public init(with model: Model) {
            super.init(frame: .zero)
            setup(using: model)
            makeConstraints()
        }
        
        @available(*, unavailable)
        required init?(coder aDecoder: NSCoder) { return nil }
        
        // MARK: - Private methods
        
        /// Настраивает карточку
        /// - Parameter model: модель карточки
        private func setup(using model: Model) {
            
            // Добавляем карточку а в нее помещаем контейнер
            addSubview(contentContainer)
            
            // В контейнер помещаем заголовок и разделитель
            contentContainer.addArrangedSubview(titleLabel)
            contentContainer.addArrangedSubview(subtitleLabel)
            
            let title = model.title ?? ""
            let subtitle = model.subtitle ?? ""
            
            if !title.isEmpty {
                // Обновляем текст в заголовке карточки
                titleLabel.attributedText = .styled(title, with: .h3Semibold)
            } else {
                titleLabel.isHidden = true
            }
            
            if !subtitle.isEmpty {
                // Обновляем текст в подзаголовке карточки
                subtitleLabel.attributedText = .styled(subtitle, with: .p2Regular)
            } else {
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
