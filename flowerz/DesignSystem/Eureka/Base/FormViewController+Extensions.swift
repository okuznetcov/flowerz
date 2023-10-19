//
//  FormViewController+Extensions.swift
//  flowerz
//
//  Created by Кузнецов Олег on 31.07.2023.
//

import UIKit
import Eureka

public extension FormViewController {
    
    // MARK: - Components
    
    /// Баннер в различных стилях. Компонент Eureka.
    /// Может содержать заголовок, подзаголовок и изображение.
    typealias BannerRow = EurekaComponents.Banner.BannerRow
    
    /// Лейбл с названием (заголовком). Компонент Eureka
    typealias LabelWithNameRow = EurekaComponents.LabelWithName.LabelWithNameRow
    
    /// Сводка по объекту. Компонент Eureka.
    /// Слева: Карточка с картинкой, заголовком, подзаголовком и опциональной тенью
    /// Справа: группа лейблов с заголовками
    typealias ItemSummaryRow = EurekaComponents.ItemSummary.ItemSummaryRow
    
    /// Кнопка в разных стилях и размерах. Компонент Eureka
    typealias ButtonRow = EurekaComponents.Button.ButtonRow
    
    /// Промо-баннер с фоновым изображением и кнопкой. Компонент Eureka.
    /// Содержит заголовок, подзаголовок, опциональную кнопку
    typealias PromoBannerRow = EurekaComponents.PromoBanner.PromoBannerRow
    
    /// Карточка истории ухода. Компонент Eureka.
    typealias HistoryRow = EurekaComponents.History.HistoryRow
    
    /// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой. Компонент Eureka.
    typealias ScrollableCardsRow = EurekaComponents.ScrollableCards.ScrollableCardsRow
    
    /// Заголовок + подзаголовок. Компонент Eureka.
    typealias TitleRow = EurekaComponents.Title.TitleRow
    
    /// Группа бейджей. Компонент Eureka.
    /// Отображает любое количество бейджей с различными цветами и текстом
    typealias BadgeGroupRow = EurekaComponents.BadgeGroup.BadgeGroupRow
    
    /// Поле ввода текста в одну строку с подписью под полем ввода. Компонент Eureka.
    /// Поддерживает разные типы клавиатур.
    /// Введенный текст содержится в row.value. При изменении величин компонент обновляется.
    typealias InputRow = EurekaComponents.Input.InputRow
    
    /// Переключатель с текстом. Компонент Eureka.
    /// Может быть два текста для включенного и выключенного состояний.
    /// Статус переключателя содержится в row.value. При изменении величин компонент обновляется.
    typealias SwitchRow = EurekaComponents.Switch.SwitchRow
    
    /// Лейбл без заголовка (простой текст). Компонент Eureka.
    /// Поддерживает подсветку части текста как ссылку.
    /// На нажатие реагирует весь компонент целиком.
    /// Поддержка предопределенных стилей.
    typealias LabelRow = EurekaComponents.Label.LabelRow
    
    /// Серая линия-разделитель. Компонент Eureka. Поддерживает разную ширину линии.
    typealias SeparatorRow = EurekaComponents.Separator.SeparatorRow
    
    /// Компонент выбора единичной карточки из списка. Компонент Eureka.
    /// Отображает любое количество карточек с горизонтальной прокруткой.
    /// При выборе карточки отображает детальную информацию и предоставляет возможность отмены выбора.
    typealias CardPickerRow = EurekaComponents.CardPicker.CardPickerRow
    
    /// Группа контролов в вертикальном стеке. Компонент Eureka.
    /// Поддерживается два типа контролов: радиобаттон (выбор только одного варианта) или чекбокс (множественный выбор)
    ///
    /// Модель хранит тексты контролов, а словарь selectedItems — перечень контролов с отметкой выбора.
    /// При изменении моделей компонент обновляется.
    typealias ControlsStackRow = EurekaComponents.ControlsStack.ControlsStackRow
    
    typealias ControlsStackEntities = Components.ControlsStack.Entity
    
    // MARK: - Predefined settings
    
    func setupSimpleTable() {
        view.backgroundColor = Color.background
        tableView.backgroundColor = Color.background
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.separatorStyle = .none
    }
}
