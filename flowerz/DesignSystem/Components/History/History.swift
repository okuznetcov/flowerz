//
//  History.swift
//  flowerz
//
//  Created by Кузнецов Олег on 11.07.2023.
//

import UIKit
import SnapKit

// MARK: - Components + History
// ✅ UniversalTableView — HistoryItem
// ✅ Eureka — HistoryRow

extension Components {
    
    /// Карточка истории ухода
    public final class History: UIView {

        // MARK: - Nested Types
        
        /// Размеры
        private enum Sizes {
            /// Скругление углов карточки
            static let cornerRadius: CGFloat = 25.0
            /// Вертикальное расстояние между контентом в карточке
            static let verticalSpaceBetweenContent: CGFloat = 2
            /// Внутренние отсупы от границ карточки до контента внутри карточки
            static let innerOffsets: UIEdgeInsets = .init(top: 16, left: 20, bottom: 16, right: 20)
            /// Внешние отступы до границ карточки
            static let defaultOffsets: UIEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
            /// Вертикальное расстояние между названием карточки и "светофором"
            static let verticalSpaceBetweenTitleAndTraficLight: CGFloat = 4
            /// Вертикальное расстояние между "светофором" и бейджами
            static let verticalSpaceBetweenTraficLightAndBadges: CGFloat = 6
        }
        
        // MARK: - Public properties
        
        /// Вызывается при нажатии на карточку
        public var didTapOnCard: (() -> Void)?
        
        /// Модель данных, на основе которой будет отрисована карточка
        /// При изменении модели компонент обновляется
        public var model: Model? {
            didSet {
                guard let model = model else { return }
                setup(using: model)
                makeConstraints()
            }
        }

        // MARK: - Elements
        
        /// Карточка, в которой размещается контент
        private let card: BaseButton = {
            let view = BaseButton()
            view.color = Color.backgroundSecondary
            view.layer.masksToBounds = true
            view.makeRoundCorners(radius: Sizes.cornerRadius)
            
            return view
        }()
        
        /// Вертикальный контейнер, который лежит в карточке и в котором размещается контент
        private let contentContainer: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = Sizes.verticalSpaceBetweenContent
            stack.isUserInteractionEnabled = false
            
            return stack
        }()
        
        /// Название карточки
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = Color.textPrimary
            label.isUserInteractionEnabled = false
            label.setContentHuggingPriority(.required, for: .vertical)
            
            return label
        }()
        
        /// Список бейджей
        private let badgeGroup: BadgeGroup = {
            let badgeGroup = BadgeGroup()
            badgeGroup.isUserInteractionEnabled = false
            
            return badgeGroup
        }()

        // MARK: - Init
        
        /// Карточка истории ухода
        /// - Parameter model: модель данных, на основе которой будет отрисована карточка
        public init(with model: Model) {
            super.init(frame: .zero)
            setup(using: model)
            makeConstraints()
            setupActions()
        }
        
        @available(*, unavailable)
        required init?(coder aDecoder: NSCoder) { return nil }
        
        // MARK: - Private methods
        
        /// Настраивает карточку
        /// - Parameter model: модель карточки
        private func setup(using model: Model) {
            
            // Убираем все сабвью
            card.removeFromSuperview()
            contentContainer.subviews.forEach { containerItem in
                containerItem.removeFromSuperview()
            }
            contentContainer.removeFromSuperview()
            
            // Добавляем карточку а в нее помещаем контейнер
            addSubview(card)
            card.addSubview(contentContainer)
            
            // В контейнер помещаем заголовок и разделитель
            contentContainer.addArrangedSubview(titleLabel)
            contentContainer.addArrangedSubview(
                SpacerView(size: Sizes.verticalSpaceBetweenTitleAndTraficLight, axis: .vertical)
            )
            
            // Сортируем операции по их типу
            var operations = model.operations
            operations.sort { $0.kind.rawValue < $1.kind.rawValue }
            
            // Создаем массив бейджей для карточки
            var badges: [BadgeGroup.Badge] = []
            
            // Для каждой операции формируем View и настраиваем бейджи
            operations.forEach { operation in
                let operationView = InlineOperationView(
                    name: operation.name,
                    quantity: "\(operation.quantity) из \(model.totalQuantity)",
                    dotColor: operation.kind.color(for: .traficLight)
                )
                contentContainer.addArrangedSubview(operationView)
                
                let operationBadges = operation.facilities.compactMap { facility in
                    return BadgeGroup.Badge(text: facility, color: operation.kind.color(for: .badge))
                }
                
                badges.append(contentsOf: operationBadges)
            }
            
            // Добавляем разделитель
            contentContainer.addArrangedSubview(
                SpacerView(size: Sizes.verticalSpaceBetweenTraficLightAndBadges, axis: .vertical)
            )

            badgeGroup.badges = badges
            contentContainer.addArrangedSubview(badgeGroup)
            
            // Обновляем текст в заголовке карточки
            titleLabel.attributedText = .styled(model.title, with: .h2Bold)
        }
        
        /// Настраивает констрейнты
        private func makeConstraints() {
            
            // Убираем все констрейнты
            card.snp.removeConstraints()
            contentContainer.snp.removeConstraints()
            
            card.snp.makeConstraints {
                $0.leading.trailing.top.equalToSuperview().inset(Sizes.defaultOffsets)
                $0.bottom.equalToSuperview().inset(Sizes.defaultOffsets).priority(.medium)
            }
            contentContainer.snp.makeConstraints { $0.edges.equalTo(card).inset(Sizes.innerOffsets) }
            
            invalidateIntrinsicContentSize()
            layoutIfNeeded()
        }
        
        /// Настраивает действия
        private func setupActions() {
            card.pressUpAction = { [weak self] in self?.didTapOnCard?() }
        }
    }
}
