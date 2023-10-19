//
//  GenericContainer.swift
//  flowerz
//
//  Created by Кузнецов Олег on 31.08.2023.
//

import UIKit
import SnapKit

// MARK: - Components + ControlsStack
// ❌ UniversalTableView
// ✅ Eureka — ControlsStackRow

extension Components.ControlsStack {
    
    /// Generic-контейнер группы контролов в вертикальном стеке.
    /// Ячейки могут быть различными, т. к. контейнер группы принимает в себя любой ControlsStackEntity в качестве Generic.
    ///
    /// Поддерживается два три типа контролов:
    /// - radiobutton (выбор только одного варианта),
    /// - checkmark (выбор только одного варианта, как в радиобатоне, но вместо круга будет галочка)
    /// - checkbox (множественный выбор),
    ///
    /// Модель хранит тексты контролов, а словарь selectedItems — перечень контролов с отметкой выбора.
    /// При изменении моделей компонент обновляется.
    public final class GenericContainer<ControlEntity: ControlsStackEntity>: UIView, ControlsStackContainer {
        
        // MARK: - Nested types
    
        typealias Sizes = ControlsStackConstants.Sizes
        
        // MARK: - Public propeties
        
        /// Модель компонента.
        /// При изменении модели компонент обновляется
        public var model: Model? {
            didSet {
                
                // Убираем все контролы
                removeAllControls()
                
                // Добавляем контролы согласно модели
                addControls()
                
                // Заполняем массив выбранных контролов отметками выбора, если это необходимо
                fillSelectedItemsIfNeeded()
            }
        }
        
        /// Перечень контролов с отметкой выбора.
        /// При изменении компонент обновляется.
        ///
        /// ⚠️
        /// Не рекомендуется сеттить извне, т. к. свойство не содержит проверок на существование переданных тегов.
        /// Для изменения отметок выбора следует пользоваться методами
        ///
        /// - *changeSelectionForItemWith(tag: Control.Tag, isSelected: Bool)*
        ///
        /// - *changeSelectionForAllItems(isSelected: Bool)*
        /// 
        public var selectedItems: [String: Bool] = [:] {
            didSet { updateSelection() }
        }
        
        /// Вызывается при изменении выбора в компоненте
        public var didChangedSelection: (([String: Bool]) -> Void)?
        
        // MARK: - ControlsContainer protocol
        
        /// Стиль отметки выбора (радиобаттон (выбор только одного варианта) / чекбокс (множественный выбор))
        public var selectionStyle: Components.SelectionMark.Style {
            model?.selectionStyle ?? .checkbox
        }
        
        // MARK: - Private propeties
        
        /// Массив контролов
        private var controls: [ControlEntity] = []
        
        /// Вертикальный стек, в котором размещаются контролы
        private var stackView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            stack.spacing = Sizes.spacingBetweenControls
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        /// Генератор тактильной отдачи
        private let impactGenerator = UIImpactFeedbackGenerator(style: .light)
        
        // MARK: - Init

        /// Группа контролов в вертикальном стеке.
        /// Ячейки могут быть различными, т. к. контейнер группы принимает в себя любой ControlsStackEntity в качестве Generic.
        ///
        /// Поддерживается два три типа контролов:
        /// - radiobutton (выбор только одного варианта),
        /// - checkmark (выбор только одного варианта, как в радиобатоне, но вместо круга будет галочка)
        /// - checkbox (множественный выбор),
        ///
        /// Модель хранит тексты контролов, а словарь selectedItems — перечень контролов с отметкой выбора.
        /// При изменении моделей компонент обновляется.
        /// - Parameter model: модель компонента
        init(model: Model) {
            self.model = model
            super.init(frame: .zero)
            setupStackView()
            addControls()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Public methods
        
        /// Обновляет отметку выбора для контрола с переданным тегом
        /// - Parameters:
        ///   - tag: тег контрола, для которого необходимо обновить отметку выбора
        ///   - isSelected: новая отметка выбора
        public func changeSelectionForItemWith(tag: String, isSelected: Bool) {
            
            // Проверяем есть ли контрол с переданным тегом
            guard selectedItems.keys.contains(where: { $0 == tag }) else { return }
            
            // Апдейтим отметку выбора контрола
            selectedItems.updateValue(isSelected, forKey: tag)
        }
        
        /// Обновляет отметки выбора во всех контролах
        /// - Parameter isSelected: новая отметка выбора всех контролов
        public func changeSelectionForAllItems(isSelected: Bool) {
            var newSelectedItems = selectedItems
            
            selectedItems.forEach { (key: String, _: Bool) in
                newSelectedItems.updateValue(isSelected, forKey: key)
            }
            
            selectedItems = newSelectedItems
        }
        
        // MARK: - Private methods
        
        /// Добавляет контролы в стек и настраивает действия при нажатии
        private func addControls() {
            guard let model = model else { return }
            
            // Проходимся по всем контролам
            model.controls.forEach { model in
                
                // Инициализируем контрол и добавляем действие при нажатии
                let control = ControlEntity(container: self, with: model)
                control.didTapOnControl = { [weak self] control in
                    self?.handleTapAction(for: control)
                }
                
                // Добавляем контролы в массив для доступа к ним и помещаем в стек как ArrangedSubview
                controls.append(control)
                stackView.addArrangedSubview(control)
            }
        }
        
        /// Убирает все контролы из стека
        private func removeAllControls() {
            controls.removeAll()
            stackView.subviews.forEach { $0.removeFromSuperview() }
        }
        
        /// Обновляет контролы согласно новому словарю отметок выбора
        private func updateSelection() {
            
            // Создаем пустой словарь filteredItems
            var filteredItems: [String: Bool] = [:]
            
            // Проверяем тип отметки выбора
            switch selectionStyle {
                
                // Если работаем с чекбоксами (множественный выбор), то копируем
                // selectedItems в filteredItems
                case .checkbox:
                    filteredItems = selectedItems
                
                // Если работаем с радиобаттонами (выбор одного единственного элемента), то
                // добавляем в filteredItems только первый элемент из selectedItems, чтобы исключить
                // выбор нескольких радиобаттонов
                case .radiobutton, .checkmark:
                    guard let firstItem = selectedItems.first else { return }
                    controls.forEach { $0.isSelected = false }
                    filteredItems.updateValue(firstItem.value, forKey: firstItem.key)
            }
            
            // Для всех filteredItems обновляем контролы
            filteredItems.forEach { (tag: String, isSelected: Bool) in
                updateControlState(for: tag, isSelected: isSelected)
            }
            
            didChangedSelection?(selectedItems)
        }
        
        /// Обрабатывает действия при нажатии на определенный контрол
        /// - Parameter control: контрол, на который нажали
        private func handleTapAction(for control: any ControlsStackEntity) {
            
            // Если нужно, делаем тактильный отклик
            if model?.performsHapticFeedback ?? true { impactGenerator.impactOccurred() }
            
            // Проверяем тип отметки выбора
            switch selectionStyle {
                
                // Если работаем с радиобаттонами (выбор одного единственного элемента), то
                // убираем все отметки выбора и отмечаем нажатый контрол как единственно выбранный
                case .radiobutton, .checkmark:
                    var newSelectedItems = selectedItems
                    newSelectedItems.removeAll()
                    newSelectedItems.updateValue(true, forKey: control.controlTag)
                    selectedItems = newSelectedItems
                
                // Если работаем с чекбоксами (множественный выбор), то обновляем отметку выбора
                // для чекбокса, который нажали
                case .checkbox:
                    selectedItems.updateValue(!control.isSelected, forKey: control.controlTag)
            }
        }
        
        /// Обновляет состояние контрола по его тегу
        /// - Parameters:
        ///   - tag: тег контрола, для которого надо обновить состояние
        ///   - isSelected: состояние контрола (выбран / не выбран)
        private func updateControlState(for tag: String, isSelected: Bool) {
            
            // Ищем в массиве контролов нужный по переданному тегу
            guard let control = controls.first(where: { $0.controlTag == tag }) else { return }
            
            // Задаем новое состояние для найденного контрола
            control.isSelected = isSelected
        }
        
        /// Заполняет словарь выбранных контролов SelectedItems значениями false при добавлении нового контрола,
        /// если это необходимо
        private func fillSelectedItemsIfNeeded() {
            
            // Получаем модель
            guard let model = model else { return }
            
            // Выгружаем selectedItems в переменную чтобы не спамить в didSet { }
            var newSelectedItems = selectedItems
            
            // Проверяем тип отметки выбора
            switch selectionStyle {
            
                // Если работаем с радиобаттонами или галочками (выбор одного единственного элемента), то
                // убираем все отметки выбора и отмечаем нажатый контрол как единственно выбранный
                case .radiobutton, .checkmark:
                    guard let firstSelectedItem = selectedItems.first(where: { $0.value }) else { return }
                    newSelectedItems.removeAll()
                    newSelectedItems.updateValue(firstSelectedItem.value, forKey: firstSelectedItem.key)

                // Если работаем с чекбоксами (множественный выбор), то для новых элементов
                // устанавливаем отметку "не выбрано"
                case .checkbox:
                
                    // Проходимся по всем контролам в модели
                    model.controls.forEach { control in
                    
                        // Проверяем есть ли статус контрола из модели в словаре selectedItems
                        let hasItem = selectedItems.first(where: { $0.key == control.tag }) != nil
                    
                        // Если такого контрола нет, добавляем его со статусом не выбрано (false)
                        if !hasItem { newSelectedItems.updateValue(false, forKey: control.tag) }
                    }
            }
            
            // Обновляем selectedItems
            selectedItems = newSelectedItems
        }
        
        /// Добавляет стеквью в компонент и настраивает констрейнты
        private func setupStackView() {
            addSubview(stackView)
            stackView.snp.makeConstraints { $0.edges.equalToSuperview().inset(Sizes.defaultOffsets) }
        }
    }
}

enum ControlsStackConstants {
    
    /// Размеры
    enum Sizes {
        /// Внешние отступы контейнера контролов
        static let defaultOffsets: UIEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
        /// Расстояние между контролами
        static let spacingBetweenControls: CGFloat = 12.0
    }
}
