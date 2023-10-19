//
//  MainScreenTableViewDataSource.swift
//  flowerz
//
//  Created by Кузнецов Олег on 15.07.2023.
//

import UIKit

extension UniversalTableView {
    
    /// DataSource таблицы главного экрана приложения
    /// Размещает ячейки в таблице.
    final class DataSource: NSObject {
        
        typealias Components = UniversalTableView.Components
        
        /// Модель главного экрана приложения
        public var model: Model? {
            didSet { update() }
        }
        
        /// Массив элементов в таблице
        private var items = [Components.Item]()
        
        public var didTapOnItemWithTag: ((_ tag: String?) -> Void)?
        
        /// Обновляет массив элементов в таблице при изменении модели главного экрана
        private func update() {
            guard let model = model else { return }
            items = model.items
        }
    }
}

// MARK: - UniversalTableViewDataSource + UITableViewDataSource

extension UniversalTableView.DataSource: UITableViewDataSource {
    
    /// Возвращает число секций в таблице
    /// - Parameter tableView: таблица
    /// - Returns: число секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    /// Возвращает число строк в указанной секции таблицы
    /// - Parameters:
    ///   - tableView: таблица
    ///   - section: секция
    /// - Returns: число строк в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[safe: section]?.rowCount ?? 0
    }
    
    /// Возвращает ячейку для переданного indexPath
    /// - Parameters:
    ///   - tableView: таблица
    ///   - indexPath: индекс
    /// - Returns: ячейка таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Получаем элемент главного экрана по нужному indexPath
        guard let item = items[safe: indexPath.section] else { return UITableViewCell() }
        
        // Определяем тип элемента
        switch item.type {
            
            // Засыхающие цветы.
            // Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой
            case .scrollableCards:
                typealias CellType = Components.ScrollableCards.Cell
                typealias ItemType = Components.ScrollableCards
                let cell = tableView.dequeueReusableCell(withIdentifier: CellType.reuseId, for: indexPath)
                
                if let typedCell = cell as? CellType, let typedItem = item as? ItemType {
                    typedCell.configure(with: typedItem.model, didTapOnCardWithTag: didTapOnItemWithTag)
                    return typedCell
                }

            // История ухода за растениями.
            // Карточка с записью о дате полива, опрыскивании и пересадке
            case .history:
                typealias CellType = Components.History.Cell
                typealias ItemType = Components.History
                let cell = tableView.dequeueReusableCell(withIdentifier: CellType.reuseId, for: indexPath)
            
                if
                    let typedCell = cell as? CellType,
                    let typedItem = item as? ItemType,
                    let model = typedItem.models[safe: indexPath.row]
                {
                    typedCell.configure(with: model, didTapOnCard: nil)
                    return typedCell
                }
            
            // Заголовок
            // Ячейка с заголовоком и подзаголовком с выравниванием по центру
            case .title:
                typealias CellType = Components.Title.Cell
                typealias ItemType = Components.Title
                let cell = tableView.dequeueReusableCell(withIdentifier: CellType.reuseId, for: indexPath)
            
                if let typedCell = cell as? CellType, let typedItem = item as? ItemType {
                    typedCell.configure(with: typedItem.model)
                    return typedCell
                }
            
            // Баннер в различных стилях
            case .banner:
                typealias CellType = Components.Banner.Cell
                typealias ItemType = Components.Banner
                let cell = tableView.dequeueReusableCell(withIdentifier: CellType.reuseId, for: indexPath)
        
                if let typedCell = cell as? CellType, let typedItem = item as? ItemType {
                    typedCell.configure(with: typedItem.model, didTapOnElement: { [weak self] in
                        guard let self = self else { return }
                        didTapOnItemWithTag?(typedItem.tag)
                    })
                    return typedCell
                }
            
            // Промо-баннер с фоновым изображением и кнопкой. Большой и анимированный.
            // Содержит заголовок, подзаголовок, опциональную кнопку
            case .promoBanner:
                typealias CellType = Components.PromoBanner.Cell
                typealias ItemType = Components.PromoBanner
                let cell = tableView.dequeueReusableCell(withIdentifier: CellType.reuseId, for: indexPath)
    
                if let typedCell = cell as? CellType, let typedItem = item as? ItemType {
                    typedCell.configure(with: typedItem.model, didTapOnButton: didTapOnItemWithTag)
                    return typedCell
                }
            
            case .labelWithName:
                typealias CellType = Components.LabelWithName.Cell
                typealias ItemType = Components.LabelWithName
                let cell = tableView.dequeueReusableCell(withIdentifier: CellType.reuseId, for: indexPath)

                if let typedCell = cell as? CellType, let typedItem = item as? ItemType {
                    typedCell.configure(with: typedItem.model)
                    return typedCell
                }
            
            case .button:
                typealias CellType = Components.Button.Cell
                typealias ItemType = Components.Button
                let cell = tableView.dequeueReusableCell(withIdentifier: CellType.reuseId, for: indexPath)

                if let typedCell = cell as? CellType, let typedItem = item as? ItemType {
                    typedCell.configure(with: typedItem.model)
                    return typedCell
                }
            
            case .badgeGroup:
                typealias CellType = Components.BadgeGroup.Cell
                typealias ItemType = Components.BadgeGroup
                let cell = tableView.dequeueReusableCell(withIdentifier: CellType.reuseId, for: indexPath)

                if let typedCell = cell as? CellType, let typedItem = item as? ItemType {
                    typedCell.configure(with: typedItem.model)
                    return typedCell
                }
            case .itemSummary:
                break
        }
        return UITableViewCell()
    }
}

// MARK: - UniversalTableViewDataSource + UITableViewDelegate

extension UniversalTableView.DataSource: UITableViewDelegate {
    
    //typealias Components = UniversalTableView.Components
    
    /// Возвращает вью хэадера/футера для секции с переданным идентификатором
    /// - Parameters:
    ///   - tableView: таблица
    ///   - section: идентификатор (номер) секции таблицы
    /// - Returns: вью хэадера/футера
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerConfig = items[safe: section]?.header else { return nil }
        
        typealias CellType = Components.Header
        guard
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellType.reuseId) as? CellType
        else { return nil }
        view.configure(with: headerConfig)
        
        return view
    }
    
    /// Возвращает значение высоты хэадера/футера для секции с переданным идентификатором
    /// - Parameters:
    ///   - tableView: таблица
    ///   - section: идентификатор (номер) секции таблицы
    /// - Returns: высота CGFloat
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let headerConfig = items[safe: section]?.header else { return 0 }
        return headerConfig.style.asStyleParameters().height
    }
}
