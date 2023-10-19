//
//  ScrollableCards+Model.swift
//  flowerz
//
//  Created by Кузнецов Олег on 14.07.2023.
//

import UIKit

// MARK: - Components.ScrollableCards + Model

/// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой
extension Components.ScrollableCards {
    
    /// Модель карточек
    public struct Model {
        
        /// Тип выбора
        public enum SelectionStyle {
            /// Единичный выбор: можно выбрать только одну карточку, при повторном нажатии выбор не сбрасывается
            case single
            /// Множетсвенный выбор: можно выбрать любое количество карточек, при повторном нажатии карточка перестает быть выбранной
            case multiple
        }
        
        public enum Layout {
            case horizontal
            case verticalThreeCardsInRow
            case verticalTwoCardsInRow
            case verticalAuto
            
            func asScrollDirection() -> UICollectionView.ScrollDirection {
                switch self {
                    case .horizontal:
                        return .horizontal
                    case .verticalAuto, .verticalThreeCardsInRow, .verticalTwoCardsInRow:
                        return .vertical
                }
            }
        }
        
        public enum Header {
            case title(String)
            case search
            case titleWithSearchOption(String)
            
            func searchBarShowsCancelButton() -> Bool {
                switch self {
                    case .titleWithSearchOption:
                        return true
                    
                    case .search, .title:
                        return false
                }
            }
            
            func initialBarState() -> BarState {
                switch self {
                    case .titleWithSearchOption:
                        return .titleAndButton
                    
                    case .search:
                        return .search
                    
                    case .title:
                        return .title
                }
            }
        }
        
        /// Карточка
        public struct Item {
            /// Изображение
            let image: UIImage
            /// Заголовок
            let title: String
            /// Подзаголовок
            let subtitle: String
            /// Тег карточки. Будет передан в колбэке элемента
            let tag: String
            /// Массив полей для отображения деталей в ItemSummary. Необязательно.
            let fields: [Components.LabelWithName.Model]
            /// Строка, которая будет сравниваться для поиска нужной карточки
            var searchableString: String { "\(title)\(subtitle)".prepareForSearching() }
            
            /// Карточка
            /// - Parameters:
            ///   - image: Изображение
            ///   - title: Заголовок
            ///   - subtitle: Подзаголовок
            ///   - isSelected: Отметка выбора (выбрана ли карточка)
            ///   - tag: Тег карточки. Будет передан в колбэке элемента
            ///   - fields: Массив полей для отображения деталей в ItemSummary. Необязательно.
            init(
                image: UIImage,
                title: String,
                subtitle: String,
                tag: String,
                fields: [Components.LabelWithName.Model]? = nil
            ) {
                self.image = image
                self.title = title
                self.subtitle = subtitle
                //self.isSelected = isSelected
                self.tag = tag
                self.fields = fields ?? []
            }
            
            /// Мапит карточку в модель для компонента
            /// - Parameter isSelectable: карточка может быть интерактивной (доступной для выбора)
            /// - Returns: модель карточки для отрисовки
            func asCardModel(isSelectable: Bool) -> Components.ImageWithNameCard.Model {
                return .init(
                    image: image,
                    accessory: .text(title: title, subTitle: subtitle),
                    selectionStyle: isSelectable ? .hugeCheckboxOverImage : nil
                )
            }
        }
        
        /// Тип выбора (необязательно). Если не передан, карточки нельзя выбрать — только нажимать для выполнения действия.
        let selectionStyle: SelectionStyle?
        /// Заголовок компонента. Необязательно.
        let title: String?
        /// Доступна ли пользователю кнопка поиска
        let allowsSearching: Bool
        /// Массив карточек
        var items: [Item]
        var layout: Layout = .horizontal
        let header: Header = .search
        var shouldResignFirstResponderAfterSelectingCard: Bool = true
    }
}

public extension String {
    func prepareForSearching() -> String {
        return self
            .replacingOccurrences(of: " ", with: "")
            .lowercased()
    }
}
