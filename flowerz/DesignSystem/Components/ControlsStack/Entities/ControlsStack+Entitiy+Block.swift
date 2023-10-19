//
//  ControlsStack+Entitiy+Block.swift
//  flowerz
//
//  Created by Кузнецов Олег on 03.09.2023.
//

import UIKit
import SnapKit

extension Components.ControlsStack.Entity {
    
    /// Единичный контрол в стеке контролов ControlsStack.
    /// Содержит в себе радиобаттон (выбор только одного варианта) или чекбокс (множественный выбор),
    /// а также текст: обязательный заголовок и необязательный подзаголовок.
    ///
    /// Текст может быть любой длины — поддерживается многострочные длинные тексты.
    ///
    /// Доступен для поиска по тегу controlTag.
    /// При изменении флага isSelected компонент обновляется.
    ///
    public final class Block: UIView, ControlsStackEntity {
        
        public typealias Model = DefaultEntityModel
        
        /// Тег
        public typealias Tag = String
        
        // MARK: - Nested Types
        
        typealias Consts = ControlsConstants1.Consts
        
        // MARK: - Public propeties
        
        /// Вызывается при нажатии контрол
        public var didTapOnControl: ((any ControlsStackEntity) -> Void)?
        
        /// Тег этого контрола
        public var controlTag: Tag = ""
        
        /// Отметка выбора контрола.
        /// При изменении компонент обновляется.
        public var isSelected: Bool {
            get { selector.isSelected }
            set {
                selector.isSelected = newValue
                updateBorderBySelection()
                removeSelectionMarkIfNeeded()
            }
        }
        
        // MARK: - Private properties
        
        private var contentContainer = UIView()
        
        /// Компонент "отметка выбора".
        /// Может быть чекбоксом или радиобаттоном
        private var selector: Components.SelectionMark
        
        /// Заголовок контрола
        private var titleLabel: UILabel = {
            let label = UILabel()
            label.textColor = Consts.Colors.title
            label.numberOfLines = 0
            label.lineBreakMode = .byClipping
            label.setContentCompressionResistancePriority(.required, for: .horizontal)
            return label
        }()
        
        /// Подзаголовок контрола
        private var subtitleLabel: UILabel = {
            let label = UILabel()
            label.textColor = Consts.Colors.subtitle
            label.numberOfLines = 0
            label.setContentCompressionResistancePriority(.required, for: .horizontal)
            return label
        }()
        
        // MARK: - Init
        
        /// Единичный контрол в стеке контролов ControlsStack.
        /// Содержит в себе радиобаттон (выбор только одного варианта) или чекбокс (множественный выбор),
        /// а также текст: обязательный заголовок и необязательный подзаголовок.
        ///
        /// Текст может быть любой длины — поддерживается многострочные длинные тексты.
        ///
        /// Доступен для поиска по тегу controlTag.
        /// При изменении флага isSelected компонент обновляется.
        /// - Parameters:
        ///   - container: контейнер, в котором будет размещен контрол
        ///   - model: модель контрола
        public init(
            container: ControlsStackContainer,
            with model: Model
        ) {
            
            // Настраиваем отметку выбора согласно стилю контейнера,
            // в котором будут размещаться контролы
            self.selector = .init(style: container.selectionStyle)
            
            super.init(frame: .zero)
            
            // Настраиваем компонент согласно модели и сеттим констрейнты
            setup(using: model)
            makeConstraints(showsSubtitle: model.subtitle != nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Private methods
        
        /// Настраивает контрол согласно переданной модели
        /// - Parameter model: модель
        private func setup(using model: Model) {
            
            layer.cornerRadius = 12
            
            updateBorderBySelection()
            removeSelectionMarkIfNeeded()
            
            addSubview(contentContainer)
            
            // Сохраняем тег в переменную для доступа извне
            controlTag = model.tag
            
            // Добавляем сабвью обязательных элементов (отметка выбора + заголовок)
            contentContainer.addSubview(selector)
            contentContainer.addSubview(titleLabel)
            
            // Сеттим тексты
            titleLabel.attributedText = .styled(model.title, with: Consts.Font.title)
            if let subtitle = model.subtitle {
                subtitleLabel.attributedText = .styled(subtitle, with: Consts.Font.subtitle)
            }
            
            // Привязываем экшен на нажатие по всему вью
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapActionHandler))
            addGestureRecognizer(tap)
        }
        
        /// Настраивает констрейнты
        /// - Parameter showsSubtitle: флаг, отображается ли подзаголовок контрола
        private func makeConstraints(showsSubtitle: Bool) {
            
            contentContainer.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
            }
            
            // Отметка выбора
            selector.snp.makeConstraints { make in
                make.trailing.top.equalToSuperview()
                make.bottom.lessThanOrEqualToSuperview()
            }
            
            // Заголовок
            titleLabel.snp.makeConstraints { make in
                make.trailing.equalTo(selector.snp.leading).offset(Consts.Sizes.spacingBetweenControlAndTexts)
                make.leading.equalToSuperview()
                make.firstBaseline.equalTo(selector.snp.centerY)
                //if !showsSubtitle { make.bottom.lessThanOrEqualToSuperview() }
            }
            
            
            
            // Проверяем, нужны ли констрейнты для подзаголовка
            guard showsSubtitle else { return }
            
            // Добавляем сабвью подзаголовка
            contentContainer.addSubview(subtitleLabel)
            
            // Подзаголовок
            subtitleLabel.snp.makeConstraints { make in
                make.leading.equalTo(titleLabel)
                make.trailing.equalTo(titleLabel).inset(Consts.Sizes.rightOffsetForSubtitleToMakeItLookGood)
                make.top.equalTo(titleLabel.snp.bottom).offset(Consts.Sizes.spacingBetweenTitleAndSubtitle)
                make.bottom.lessThanOrEqualToSuperview()
            }
            
            /*let badge = Components.BadgeGroup()
            addSubview(badge)
            badge.badges = [.init(text: "Экономия 50%", color: .lightGray)]*/
        }
        
        private func updateBorderBySelection() {
            
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self = self else { return }
                if self.isSelected {
                    backgroundColor = .clear
                    layer.borderWidth = 2
                    layer.borderColor = UIColor.systemBlue.cgColor
                } else {
                    backgroundColor = Color.backgroundSecondary
                    layer.borderWidth = 0
                    layer.borderColor = UIColor.clear.cgColor
                }
            }
        }
        
        private func removeSelectionMarkIfNeeded() {
            selector.isHidden = !isSelected
        }
        
        // MARK: - Actions
        
        /// Вызывается при нажатии на все вью
        @objc private func tapActionHandler() {
            didTapOnControl?(self)
        }
    }
}

struct ControlsConstants1 {
    
    /// Константы
    enum Consts {
        
        /// Типографика
        enum Font {
            
            /// Заголовок. Paragraph 15 Medium -0.5
            static let title: Typography = .p1Medium
            
            /// Подзаголовок. Paragraph 12 Regular 0.0
            static let subtitle: Typography = .p2Regular
        }
        
        /// Цвета
        enum Colors {
            
            /// Цвет текста заголовка
            static let title: UIColor = Color.textPrimary
            
            /// Цвет текста подзаголовка
            static let subtitle: UIColor = Color.textSecondary
        }
        
        /// Размеры
        enum Sizes {
            
            /// Горизонтальное расстояние от отметки выбора до текстов
            static let spacingBetweenControlAndTexts: CGFloat = -16.0
            
            /// Сдвиг от baseline заголовка до середины контрола
            static let offsetOfTitleBaselineAndControl: CGFloat = 5.0
            
            /// Отступ справа для подзаголовка чтобы подзаголовок смотрелся визуально лучше
            static let rightOffsetForSubtitleToMakeItLookGood: CGFloat = 4.0
            
            /// Вертикальное расстояние между заголовком и подзаголовком
            static let spacingBetweenTitleAndSubtitle: CGFloat = 8.0
        }
    }
}
