//
//  ScrollableCards.swift
//  flowerz
//
//  Created by Кузнецов Олег on 14.07.2023.
//

import UIKit
import SnapKit

// MARK: - Components + ScrollableCards
// ✅ UniversalTableView — ScrollableCardsItem
// ✅ Eureka — ScrollableCardsRow

extension Components {
    
    /// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой
    public final class ScrollableCards: UIView {
        
        /// Тег карточки
        public typealias Tag = String
        /// Индекс карточки
        public typealias Index = Int
        
        /// Группа карточек с горизональной прокруткой
        public enum Size {
            
            /// Высота компонента
            static let height: CGFloat = 223
        }

        /// Константы
        private enum Consts {

            /// Размеры
            enum Sizes {
                /// Внешние отступы до границ компонента
                static let defaultOffsets: UIEdgeInsets = .init(top: 0, left: 16, bottom: 8, right: 16)
                /// Карточка
                enum Card {
                    private typealias Size = Components.ImageWithNameCard.CollectionViewSize
                    /// Ширина одной карточки
                    static let width: CGFloat = Size.width
                    /// Высота одной карточки
                    static let height: CGFloat = Size.height
                    /// Высота одной карточки
                    static let heightToWidthRatio: CGFloat = Size.heightToWidthRatio
                }
            }

            /// ReuseIdentifier карточки
            static let cardReuseIdentifier = "card"
        }
        
        enum BarState {
            case title
            case titleAndButton
            case search
            case searchingButNothingFound
        }
        
        // MARK: - Public properties
        
        /// Вызывается при нажатии на карточку
        public var didTapOnCard: (() -> Void)?
        
        /// Модель компонента
        /// При изменении модели компонент обновляется
        public var model: Model? {
            didSet {
                //filteredModel = model
                //searchBar.searchTextField.text = nil
            }
        }
        
        /// Выбранная карточка при единичном выборе
        private var selectedItem: Index?
        
        /// Словарь выбранных карточек при множественном выборе
        private var selectedItems: [Tag: Bool] = [:]
        
        /// Вызывается при выборе карточки в режиме множественного выбора
        public var didChangedSelection: (([Tag: Bool]) -> Void)?
        
        /// Вызывается при нажатии на карточку
        public var didTapOnCardWithTag: ((Tag) -> Void)?
        
        let screenWidth = UIScreen.main.bounds.size.width
        
        // MARK: - Private properties
        
        /// Внутреняя модель компонента
        /// При изменении модели компонент НЕ обновляется. Обновление зависит от searchText и внешней модели model
        private var filteredModel: Model? {
            
            // Если исходная модель nil, то тоже возвращаем nil
            guard let model = model else { return nil }
            
            // Если searchText пуст или nil, то возвращаем модель (не фильтруем). Иначе — идем дальше
            guard let searchText = searchText, !searchText.isEmpty else { return model }
            
            // Фильтруем модель по тексту в строке поиска
            var filteredModel = model
            filteredModel.items = model.items.filter({ $0.searchableString.contains(searchText) })
            
            return filteredModel
        }

        /// СollectionView, в котором лежат карточки
        private lazy var collectionView: UICollectionView = {
            typealias Sizes = Consts.Sizes.Card
            
            // Настойки лейаута коллекции карточек
            let layout = UICollectionViewFlowLayout()
            
            // Размеры
            layout.sectionInset = Consts.Sizes.defaultOffsets
            
            let modelLayout = self.model?.layout ?? .horizontal
            let numberOfCards = self.model?.items.count
            
            // Размеры карточки
            //layout.itemSize = .init(width: Sizes.width, height: Sizes.height)
            layout.itemSize = sizeOfItem(by: modelLayout, numberOfCards: numberOfCards)
            
            // Направление скролла
            layout.scrollDirection = modelLayout.asScrollDirection()
            
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
        
        private lazy var header = Header(style: .search)
        
        var searchText: String? {
            return header.searchText
        }
        
        private let nothingFoundMessage: Title = {
            let title = Title(with: .init(title: "Ничего не нашлось", subtitle: "По запросу ничего не нашлось"))
            title.alpha = .hidden
            return title
        }()
        
        /// Генератор тактильной отдачи
        private let impactGenerator = UIImpactFeedbackGenerator(style: .soft)
        
        /// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой
        /// - Parameter model: модель данных, на основе которой будет отрисован компонент
        public init(with model: Model) {
            self.model = model
            //self.barState = .titleAndButton
            super.init(frame: .zero)
            
            //hideSearchButtonIfNeeded()
            
            collectionView.dataSource = self
            //searchBar.delegate = self
            collectionView.layoutIfNeeded()
            
            setup(using: model)
            makeConstraints()
            //applyBarStateBasedOnModel()
        }
        
        @available(*, unavailable)
        required init?(coder aDecoder: NSCoder) { return nil }
        
        /// Убирает отметки выбора со всех карточек.
        public func removeSelection() {
            selectedItem = nil
            selectedItems = [:]
            didChangedSelection?(selectedItems)
            collectionView.reloadData()
        }
        
        /// Настраивает компонент
        /// - Parameter model: модель
        private func setup(using model: Model) {
            // Добавляем сколлвью
            addSubview(header)
            addSubview(collectionView)
            addSubview(nothingFoundMessage)
            setupSearchBar()
        }
        
        private func setupSearchBar() {
            
            header.didChangeSearchText = { [weak self] in
                self?.collectionView.reloadData()
                
                if self?.filteredModel?.items.isEmpty ?? true {
                    self?.nothingFoundMessage.alpha = .visible
                } else {
                    self?.nothingFoundMessage.alpha = .hidden
                }
            }
            
            header.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(36)
            }
        }
        
        /// Настраивает констрейнты
        private func makeConstraints() {
            collectionView.snp.makeConstraints { make in
                make.top.equalTo(header.snp.bottom)
                make.leading.trailing.bottom.equalToSuperview()
            }
            
            nothingFoundMessage.snp.makeConstraints { make in
                make.center.equalTo(collectionView)
                make.leading.trailing.equalToSuperview()
            }
        }
        
        /// Обновляет внутренние состояния свойств selectedItem / selectedItems при изменении модели
        /// - Parameter model: модель
        private func setupSelection(using model: Model) {
            
            // Проверяем тип выбора в модели
            switch model.selectionStyle {
                
                // Множетсвенный выбор: заполняем словарь [Tag: isSelected] для всех моделей
                case .multiple:
                    model.items.forEach { item in
                        //selectedItems.updateValue(item.isSelected, forKey: item.tag)
                    }

                // Единичный выбор: проставляем выбранный индекс как индекс первой модели с флагом isSelected
                case .single:
                    //selectedItem = model.items.firstIndex(where: { $0.isSelected })
                    break
                
                // Без выбора: убираем отметки
                case .none:
                    selectedItems = [:]
                    selectedItem = nil
            }
        }
        
        private func changeNothingFoundText(for search: String?) {
            nothingFoundMessage.model = .init(
                title: "Ничего не нашли 😢",
                subtitle: "По запросу \"\(search ?? "")\" ничего не нашлось"
            )
        }
        
        private func resignFirstResponderIfNeeded()  {
           /* if model?.shouldResignFirstResponderAfterSelectingCard ?? true {
                searchBar.resignFirstResponder()
            }*/
        }
        
        private func performHapticFeedbackIfNeeded() {
            impactGenerator.impactOccurred()
        }
        
        private func sizeOfItem(
            by layout: Model.Layout,
            numberOfCards: Int?
        ) -> CGSize {
            
            typealias Card = Consts.Sizes.Card
            
            switch layout {
                case .horizontal:
                    return .init(width: Card.width, height: Card.height)
                
                case .verticalTwoCardsInRow:
                    let widthWhenTwoInRow = screenWidth / 2.0
                    let cardWidth = widthWhenTwoInRow - 22.0
                    return .init(width: cardWidth, height: cardWidth * Card.heightToWidthRatio)
                
                case .verticalThreeCardsInRow:
                    let widthWhenThreeInRow = screenWidth / 3.0
                    let cardWidth = widthWhenThreeInRow - 18.0
                    return .init(width: cardWidth, height: cardWidth * Card.heightToWidthRatio)
                
                case .verticalAuto:
                    guard let numberOfCards = numberOfCards else {
                        return sizeOfItem(by: .verticalTwoCardsInRow, numberOfCards: nil)
                    }
                
                    if numberOfCards < 5 {
                        return sizeOfItem(by: .verticalTwoCardsInRow, numberOfCards: numberOfCards)
                    } else {
                        return sizeOfItem(by: .verticalThreeCardsInRow, numberOfCards: numberOfCards)
                    }
            }
        }
    }
}

// MARK: - Components.ScrollableCards + UICollectionViewDataSource

extension Components.ScrollableCards: UICollectionViewDataSource {
    
    /// Возвращает число элементов в секции collectionView
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - section: секция
    /// - Returns: число элементов в секции collectionView
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredModel?.items.count ?? 0
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
            let item = filteredModel?.items[safe: indexPath.row],
            let cell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: Consts.cardReuseIdentifier,
                    for: indexPath as IndexPath
                ) as? Card
        else { return UICollectionViewCell() }
        
        // Получаем индекс и информацию о карточке
        let index = indexPath.row
        
        // Добавляем обработчик действия карточки
        cell.didTapOnCard = { [weak self] in
            guard let self = self else { return }
            
            resignFirstResponderIfNeeded()
            
            performHapticFeedbackIfNeeded()
            
            // Проверяем тип выбора в модели
            switch self.filteredModel?.selectionStyle {
                
                // Единичный выбор: проставляем отметку выбора в selectedItem
                case .single:
                    let previouslySelectedCard = self.selectedItem
                    self.selectedItem = index
                    if let previouslySelectedCard = previouslySelectedCard, previouslySelectedCard != index {
                        collectionView.reloadItems(at: [IndexPath(item: previouslySelectedCard, section: 0)])
                    }
                    cell.card.isSelected = true
                    didTapOnCardWithTag?(item.tag)
                
                // Множетсвенный выбор: проставляем отметку в словарь selectedItems
                case .multiple:
                    cell.card.isSelected.toggle()
                    self.selectedItems.updateValue(cell.card.isSelected, forKey: item.tag)
                    didChangedSelection?(selectedItems)
                
                // Без выбора: только отправляем колбэк выбора
                case .none:
                    didTapOnCardWithTag?(item.tag)
            }
        }
        
        // Конфигурируем карточку
        cell.configure(with: item.asCardModel(isSelectable: self.filteredModel?.selectionStyle != nil))
        
        // Проставляем отметку выбора в карточке
        switch filteredModel?.selectionStyle {
            
            // Единичный выбор: если индексы совпадают, проставляем выбор
            case .single:
                cell.card.isSelected = selectedItem == index
            
            // Множетсвенный выбор: получаем отметку выбора по тегу элемента
            case .multiple:
                cell.card.isSelected = selectedItems[item.tag] ?? false
            
            // Без выбора: убираем отметку выбора
            case .none:
                cell.card.isSelected = false
        }
        
        return cell
    }
}

extension Components.ScrollableCards {
    
    public final class Header: UIView {
        
        enum BarState {
            case title
            case titleAndButton
            case search
        }
        
        public enum Style {
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
            
            func title() -> String {
                switch self {
                    case .titleWithSearchOption(let title):
                        return title
                    
                    case .search:
                        return ""
                    
                    case .title(let title):
                        return title
                }
            }
        }
        
        var didChangeSearchText: (() -> Void)?
        
        private let toolBar: UIView = {
            let toolBar = UIView()
            toolBar.alpha = .visible
            return toolBar
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 1
            label.textAlignment = .left
            label.textColor = Color.textSecondary
            return label
        }()
        
        private let searchButton = Components.Button(
            model: .init(
                text: "🔍  Поиск",
                textColor: Color.textPrimary,
                color: Color.backgroundSecondary,
                size: .extraSmall,
                style: .circular,
                performsHapticFeedback: false
            )
        )
        
        private lazy var searchBar: UISearchBar = {
            let bar = UISearchBar()
            bar.placeholder = "Поиск"
            bar.showsCancelButton = style.searchBarShowsCancelButton()
            bar.searchBarStyle = .minimal
            bar.autocorrectionType = .no
            bar.directionalLayoutMargins = .zero
            bar.layoutMargins = .zero
            bar.alpha = .hidden
            return bar
        }()
        
        var barState: BarState {
            didSet { updateLayout() }
        }
        
        /// Текст, введенный в строку поиска
        /// При изменении модели компонент обновляется
        public private(set) var searchText: String? {
            didSet {
                
                // Обновляем collectionView
                didChangeSearchText?()
                
                // Если текст не nil, то проходим дальше, иначе — скрываем строку поиска и показываем заголовок
                guard searchText != nil else {
                    searchBar.resignFirstResponder()
                    barState = .titleAndButton
                    return
                }

                // Иначе показываем строку поиска
                barState = .search
            }
        }
        
        let style: Style
        
        init(
            style: Style
        ) {
            self.style = style
            self.barState = style.initialBarState()
            super.init(frame: .zero)
            
            self.searchBar.delegate = self
            
            setupToolbar()
            setupSearchbar()
            updateLayout()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupToolbar() {
            addSubview(toolBar)

            toolBar.addSubview(titleLabel)
            toolBar.addSubview(searchButton)
            
            titleLabel.attributedText = .styled(style.title(), with: .p1Medium)
            
            searchButton.touchUpAction = { [weak self] in
                self?.searchBar.becomeFirstResponder()
                self?.barState = .search
            }
            
            titleLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            searchButton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview()
            }
            
            toolBar.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        private func setupSearchbar() {
            addSubview(searchBar)
            
            searchBar.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(-8)
            }
        }
        
        private func updateLayout() {
            var searchVisibility: CGFloat = .zero
            var toolbarVisibility: CGFloat = .zero
            var searchButtonVisibility: CGFloat = .zero
            
            switch barState {
                
                case .search:
                    searchVisibility = .visible
                    toolbarVisibility = .hidden
                    searchButtonVisibility = .visible
                
                case .titleAndButton:
                    searchVisibility = .hidden
                    toolbarVisibility = .visible
                    searchButtonVisibility = .visible
                
                case .title:
                    searchVisibility = .hidden
                    toolbarVisibility = .visible
                    searchButtonVisibility = .hidden
            }
            
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self = self else { return }
                self.searchBar.alpha = searchVisibility
                self.toolBar.alpha = toolbarVisibility
                self.searchButton.alpha = searchButtonVisibility
            }
        }
    }
}

extension Components.ScrollableCards.Header: UISearchBarDelegate {
    
    /// Вызывается при вводе очередного символа в строку поиска пользователем с клавиатуры
    /// - Parameter searchBar: searchBar
    /// - Parameter text: текст в поле ввода
    public func searchBar(_ searchBar: UISearchBar, textDidChange text: String) {
        //changeNothingFoundText(for: text)
        searchText = text.prepareForSearching() // заполняем значение searchText текстом, подготовленным для поиска
    }
    
    /// Вызывается при нажатии кнопки "отмена" справа от строки поиска
    /// - Parameter searchBar: searchBar
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = nil    // очищаем поле ввода
        searchText = nil                        // очищаем значение searchText
    }
}
