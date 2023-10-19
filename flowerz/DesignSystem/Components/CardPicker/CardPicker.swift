//
//  CardPicker.swift
//  flowerz
//
//  Created by Кузнецов Олег on 20.08.2023.
//

import UIKit
import SnapKit

// MARK: - Components + CardPicker
// ❌ UniversalTableView
// ✅ Eureka — CardPickerRow

extension Components {
    
    /// Компонент выбора единичной карточки из списка.
    /// Отображает любое количество карточек с горизонтальной прокруткой.
    /// При выборе карточки отображает детальную информацию и предоставляет возможность отмены выбора.
    /// Под капотом объединяет в себе компоненты ScrollableCards и ItemSummary
    public final class CardPicker: UIView {
        
        /// Тег карточки
        public typealias Tag = String
        
        /// Константы
        private enum Consts {
            
            /// Компонент сводка по объекту (детали)
            enum ItemSummary {
                
                /// Кнопка отмены выбора карточки
                static let button: Button.Model = .init(
                    text: "Отмена",
                    textColor: Color.textPrimary,
                    color: Color.backgroundSecondary,
                    size: .small,
                    style: .circular,
                    performsHapticFeedback: true
                )
            }
            
            /// Группа карточек с горизональной прокруткой
            enum ScrollableCards {
                
                /// Высота компонента
                static let height: CGFloat = Components.ScrollableCards.Size.height
            }
            
            /// Длительность анимации перехода от компонента ScrollableCards к ItemSummary и наоборот
            static let animationDuration: TimeInterval = 0.2
        }

        // MARK: - Public properties
        
        /// Модель
        public struct Model {
            /// Массив карточек для отображения
            public var cards: [ScrollableCards.Model.Item]
            public var selectedCard: Tag?
            public let backgroundColor: UIColor = .clear
        }
        
        /// Модель компонента выбора единичной карточки из списка.
        /// При изменении модели компонент обновляется
        public var model: Model? {
            didSet {
                guard let model = model else { return }
                update(using: model)
            }
        }
        
        /// Вызывается при изменении высоты компонента
        public var didChangedHeight: (() -> Void)?
        
        /// Вызывается при нажатии на карточку
        public var didTapOnCardWithTag: ((Tag) -> Void)?
        
        /// Вызывается при отмене выбора ранее выбранной карточки (при нажатии на кнопку "отмена")
        public var didUnselectedCard: (() -> Void)?

        // MARK: - Private properties
        
        /// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой
        private var scrollableCards: ScrollableCards?
        
        /// Компонент сводка по объекту
        /// Слева: Карточка с картинкой, заголовком, подзаголовком и опциональной тенью
        /// Справа: группа лейблов с заголовками
        private var itemSummary: ItemSummary = {
            return ItemSummary(
                with: .init(
                    fields: [],
                    card: .init(
                        image: UIImage(),
                        accessory: .text(title: "", subTitle: ""),
                        selectionStyle: .hugeCheckboxOverImage
                    ),
                    button: Consts.ItemSummary.button,
                    isSelected: true,
                    cardSize: .exact
                )
            )
        }()

        // MARK: - Init
        
        /// Компонент выбора единичной карточки из списка.
        /// Отображает любое количество карточек с горизонтальной прокруткой.
        /// При выборе карточки отображает детальную информацию и предоставляет возможность отмены выбора.
        /// Под капотом объединяет в себе компоненты ScrollableCards и ItemSummary
        /// - Parameter model: модель данных, на основе которой будет отрисован компонент
        public init(with model: Model) {
            super.init(frame: .zero)
            setup(using: model)
            update(using: model)
        }
        
        @available(*, unavailable)
        required init?(coder aDecoder: NSCoder) { return nil }
        
        // MARK: - Private methods
        
        /// Настраивает компонент
        /// - Parameter model: модель
        private func setup(using model: Model) {
            
            // Настраиваем компонент группы карточек
            let scrollableCards = ScrollableCards(
                with: .init(
                    selectionStyle: .single,
                    title: "title",
                    allowsSearching: true,
                    items: model.cards
                )
            )
            
            // Добавляем сабвью
            addSubview(scrollableCards)
            addSubview(itemSummary)
            self.scrollableCards = scrollableCards
            
            // Настраиваем действия в компонентах
            setupActions()
        }
        
        // MARK: - showCards() and showSummary()
        
        /// Отображает вью, когда пользователю предлагается сделать выбор карточки.
        /// Отображается группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой
        private func showCards() {
            
            // Сеттим констрейнты нужного компонента
            scrollableCards?.snp.makeConstraints { make in
                make.leading.trailing.top.equalToSuperview()
                make.bottom.lessThanOrEqualToSuperview().priority(.medium)
                make.height.equalTo(Consts.ScrollableCards.height)
            }
            
            // Анимированно скрываем itemSummary и показываем scrollableCards
            UIView.animate(
                withDuration: Consts.animationDuration,
                delay: .zero,
                animations: { [weak self] in
                    self?.itemSummary.layer.opacity = .hidden
                },
                completion: { [weak self] _ in
    
                    // После завершения анимации убираем констренты для itemSummary
                    // и уведомляем об изменении высоты компонента
                    
                    guard let self = self else { return }
                    self.itemSummary.snp.removeConstraints()
                    self.didChangedHeight?()
                    
                    UIView.animate(withDuration: Consts.animationDuration) { [weak self] in
                        self?.scrollableCards?.layer.opacity = .visible
                    }
                }
            )
        }
        
        /// Отображает вью, когда выбрана конкретная карточка.
        /// Отображается детальная информация о карточке и отметка выбора. Доступна возможность отмены выбора
        /// - Parameters:
        ///   - card: карточка, для которой будут отображаться детали
        ///   - tag: тег карточки
        private func showSummary(of card: ScrollableCards.Model.Item) {
            
            // Собираем модель для компонента детальной информации
            itemSummary.model = ItemSummary.Model(
                fields: card.fields,
                card: card.asCardModel(isSelectable: true),
                button: Consts.ItemSummary.button,
                isSelected: true,
                cardSize: .exact
            )
        
            // Сеттим констренты нужного компонента
            itemSummary.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            // Анимированно скрываем scrollableCards и показываем itemSummary
            UIView.animate(
                withDuration: Consts.animationDuration,
                delay: .zero,
                animations: { [weak self] in
                    self?.scrollableCards?.layer.opacity = .hidden
                },
                completion: { [weak self] _ in
                    
                    // После завершения анимации убираем констренты для scrollableCards
                    // и уведомляем об изменении высоты компонента
                    
                    guard let self = self else { return }
                    self.scrollableCards?.snp.removeConstraints()
                    self.didChangedHeight?()
                    
                    UIView.animate(withDuration: Consts.animationDuration) { [weak self] in
                        self?.itemSummary.layer.opacity = .visible
                    }
                }
            )
        }
        
        // MARK: - Private methods
        
        /// Обновляет компонент в соответсвии с переданной моделью
        /// - Parameter model: модель
        private func update(using model: Model) {
            
            backgroundColor = model.backgroundColor
            
            // Обновляем модель компонента группы карточек
            scrollableCards?.model = .init(
                selectionStyle: .single,
                title: "title",
                allowsSearching: true,
                items: model.cards
            )
            
            // Если в модели нашли карточку с отметкой выбора
            //if let selectedCard = model.cards.first(where: { $0.isSelected }) {
            if
                let selectedCardTag = model.selectedCard,
                let selectedCard = model.cards.first(where: { $0.tag == selectedCardTag })
            {
                
                // Отображаем вью деталей для карточки
                showSummary(of: selectedCard)
                
                // Прокидываем колбэк о нажатии на карточку с тегом.
                // Хоть нажатия и не было, это необходимо чтобы зависимые компоненты узнали о том что выбор был.
                didTapOnCardWithTag?(selectedCard.tag)
                
            } else {
                
                // Отображаем все доступные для выбора карточки
                showCards()
            }
        }
        
        /// Настраивает действия в компонентах
        private func setupActions() {
            
            // Нажатие на карточку в списке
            scrollableCards?.didTapOnCardWithTag = { [weak self] tag in
                guard
                    let self = self,
                    let items = self.model?.cards,
                    let item = items.first(where: { $0.tag == tag })
                else { return }
                
                // Отображаем вью деталей карточки
                self.showSummary(of: item)
                
                // Отправляем колбэк о нажатии на карточку с тегом
                self.didTapOnCardWithTag?(tag)
            }
            
            // Нажатие на кнопку "отменить" во вью деталей карточки
            itemSummary.didTapOnButton = { [weak self] in
        
                // Убираем отметку выбора в компоненте списка
                // и заново отображаем компонент группы карточек
                
                guard let self = self else { return }
                self.scrollableCards?.removeSelection()
                self.showCards()
                
                // Отправляем колбэк об отмене выбора
                self.didUnselectedCard?()
            }
        }
    }
}
