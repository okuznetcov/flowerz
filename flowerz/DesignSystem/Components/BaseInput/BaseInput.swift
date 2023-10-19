//
//  BaseInput.swift
//  flowerz
//
//  Created by Кузнецов Олег on 03.08.2023.
//

import UIKit
import SnapKit

// MARK: - Components + BaseInput
// Базовый компонент. Реализацию для Eureka смотри в Input (не Base)

extension Components {
    
    /// Поле ввода текста в одну строку.
    /// Поддерживает разные типы клавиатур.
    public class BaseInput: UIView {
        
        // MARK: - Nested Types
        
        /// Константы
        private enum Consts {
            
            /// Размеры
            enum Sizes {
                
                /// Высота компонента
                static let height: CGFloat = 68
                
                /// Поле ввода
                enum TextField {
                    /// Расстояние между полем ввода и кнопкой стирания
                    static let spacingBetweenTextFieldAndEraseButton: CGFloat = 12
                }
                
                /// Кнопка стереть
                enum EraseButton {
                    /// Высота кнопки
                    static let height: CGFloat = 20
                }
                
                /// Заголовок поля ввода
                enum Title {
                    /// Расстояние по-умолчанию от верхней границы компонента
                    static let spacingFromTop: CGFloat = 24
                    /// Расстояние с правого бока до границы компонента
                    static let trailing: CGFloat = 20
                }
                
                /// Линия под полем ввода
                enum Line {
                    /// Расстояние от нижней границы компонента
                    static let spacingFromBottom: CGFloat = 12
                    /// Высота линии
                    static let height: CGFloat = 1
                }
                
                /// Хэлпер (текст в поле ввода, скрываемый при вводе первого символа)
                enum Helper {
                    /// Расстояние от верхней границы компонента
                    static let spacingFromTop: CGFloat = 20
                    /// Расстояние от нижней границы компонента
                    static let spacingFromBottom: CGFloat = 20
                }
                
                /// Тулбар клавиатуры
                enum KeyboardToolbar {
                    /// Высота тулбара
                    static let height: CGFloat = 50
                }
            }
            
            /// Длительность анимаций
            static let AnimationDuration: TimeInterval = 0.2
            
            /// Палитра компонента
            enum Colors {
                
                /// Кнопка стереть
                enum EraseButton {
                    /// Tint кнопки стереть
                    static let tint: UIColor = .lightGray
                }
                
                /// Линия под полем ввода
                enum Line {
                    /// Цвет в неактивном состоянии
                    static let inactive: UIColor = .lightGray
                }
            }
            
            /// Шрифты
            enum Fonts {
                /// Шрифт хэлпера (будет скрыт после ввода 1-го символа)
                static let helper: Typography = .p1Regular
                /// Шрифт в поле ввода
                static let textField = Font.get(size: 15, weight: .medium)
            }
        }
        
        // MARK: - Public properties

        /// Модель поля ввода.
        /// При изменении модели компонент обновляется.
        public var model: Model? {
            didSet {
                guard let model = model else { return }
                titleLabel.text = model.title
                if let helperText = model.helper {
                    helperLabel.attributedText = .styled(helperText, with: Consts.Fonts.helper)
                } else {
                    helperLabel.text = nil
                }
                textField.keyboardType = model.keyboard
                updateLayout()
            }
        }
        
        /// Флаг, пусто ли поля ввода
        public var isEmpty: Bool {
            guard let text = text, !text.isEmpty else { return true }
            return false
        }
        
        /// Текст в поле ввода.
        /// При изменении компонент обновляется
        public var text: String? {
            get { textField.text }
            
            set {
                textField.text = newValue
                updateLayout()
                didChangedText?(self)
            }
        }
        
        /// Вызывается, когда текст в поле ввода был изменен
        public var didChangedText: ((Components.BaseInput) -> Void)?
        
        /// Вызывается при старте взаимодействия с полем (компонент становится firstResponder)
        public var didStartEditing: ((Components.BaseInput) -> Void)?
        
        /// Вызывается при окончании взаимодействия с полем (компонент прекращает быть firstResponder)
        public var didFinishEditing: ((Components.BaseInput) -> Void)?
        
        // MARK: - State
        
        /// Предыдущее состояние компонента.
        /// Хранится, чтобы не обновлять компонент каждый раз когда был введен очередной символ, а состояние инпута не меняется
        private var previousState: State?
        
        /// Текущее состояние компонента. Смотри подробнее в **Components.BaseInput.State**
        private var currentState: State {
            if textField.isFirstResponder {
                return isEmpty ? .editingEmpty : .editing
            } else {
                return isEmpty ? .empty : .filled
            }
        }
        
        // MARK: - Private properties
        
        /// Поле ввода
        private let textField: UITextField = {
            let textField = UITextField()
            textField.autocorrectionType = .no
            textField.keyboardType = .default
            textField.returnKeyType = .done
            textField.font = Consts.Fonts.textField
            textField.textColor = Color.textPrimary
            return textField
        }()
        
        /// Заголовок поля ввода (уедет наверх при вводе 1-го символа)
        private let titleLabel: UILabel = {
            let title = UILabel()
            title.numberOfLines = 1
            title.textAlignment = .left
            title.lineBreakMode = .byTruncatingTail
            title.textColor = Color.textSecondary
            return title
        }()
        
        /// Хэлпер. Будет отображаться до ввода 1-го символа, затем будет скрыт. Подробнее в **Components.BaseInput.State**
        private let helperLabel: UILabel = {
            let helper = UILabel()
            helper.numberOfLines = 1
            helper.textAlignment = .left
            helper.lineBreakMode = .byTruncatingTail
            helper.textColor = Color.textSecondary
            return helper
        }()
        
        /// Кнопка очистки поля. Показывается когда поле активно и введен хотя-бы один символ. Подробнее в **Components.BaseInput.State**
        private let eraseButton: UIButton = {
            let button = UIButton(type: .custom)
            button.imageView?.contentMode = .scaleAspectFit
            let image = UIImage.resolve(named: "delete-left-solid").withTintColor(Consts.Colors.EraseButton.tint)
            button.setImage(image, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.alpha = 0.0
            return button
        }()
        
        /// Линия. Находится под полем ввода и меняет цвет в зависимости от того, является ли поле firstResponder.
        private let line: UIView = {
            let line = UIView()
            line.clipsToBounds = true
            line.backgroundColor = Consts.Colors.Line.inactive
            return line
        }()
        
        // MARK: - Constraints
        
        /// Констрейнт вертикального отступа заголовка от границ компонента (анимируется)
        private var titleTopConstraint: Constraint?
        
        // MARK: - Init
        
        /// Поле ввода текста в одну строку.
        /// Поддерживает разные типы клавиатур.
        public init() {
            super.init(frame: .zero)
            
            // Добавляем сабвью
            addSubview(textField)
            addSubview(helperLabel)
            addSubview(titleLabel)
            addSubview(line)
            addSubview(eraseButton)
            
            // Добавляем экшены
            textField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
            textField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
            textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
            eraseButton.addTarget(self, action: #selector(eraseButtonTap), for: .touchUpInside)
            textField.delegate = self
            
            // Настраиваем высоту компонента
            snp.makeConstraints { make in
                make.height.equalTo(Consts.Sizes.height)
            }
            
            // Поле ввода
            textField.snp.makeConstraints { make in
                make.leading.top.bottom.equalToSuperview()
                make.trailing.equalTo(eraseButton.snp.leading)
                    .inset(-Consts.Sizes.TextField.spacingBetweenTextFieldAndEraseButton)
            }
            
            // Кнопка очистки
            eraseButton.snp.makeConstraints { make in
                make.trailing.equalToSuperview().priority(.required)
                make.height.width.equalTo(Consts.Sizes.EraseButton.height)
                make.centerY.equalToSuperview()
            }
            
            // Заголовок
            titleLabel.snp.makeConstraints { [weak self] make in
                self?.titleTopConstraint =
                    make.top.equalToSuperview().inset(Consts.Sizes.Title.spacingFromTop).priority(.high).constraint
                make.trailing.lessThanOrEqualToSuperview().inset(Consts.Sizes.Title.trailing).priority(.high)
                make.leading.equalToSuperview().priority(.high)
            }
            
            // Линия
            line.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().priority(.high)
                make.bottom.equalToSuperview().inset(Consts.Sizes.Line.spacingFromBottom).priority(.high)
                make.height.equalTo(Consts.Sizes.Line.height).priority(.high)
            }
            
            // Хэлпер
            helperLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(Consts.Sizes.Helper.spacingFromTop)
                make.bottom.equalToSuperview().inset(Consts.Sizes.Helper.spacingFromBottom)
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        
            addDoneButtonOnKeyboardToolbar()
            updateLayout()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Private methods
        
        /// Обновляет вид компонента в зависимости от его состояния
        private func updateLayout() {
            
            // Если текущее состояние не совпадает со старым, то выполняем действия
            guard currentState != previousState else { return }
            
            // Получаем параметры отображения для текущего стейта компонента (смотри Components.BaseInput.State*)
            let parameters = currentState.parameters()
            
            // Если предыдущее состояние было пустым, то сохраняем его
            // (нужно для ситуаций когда компонент только отрисовался и предыдущего состояния мы не знаем)
            if previousState == nil { previousState = currentState }
            
            // Анимируем изменение состояния
            UIView.animate(
                withDuration: Consts.AnimationDuration,
                delay: 0,
                options: [.beginFromCurrentState, .curveEaseInOut],
                animations: {
                    self.line.backgroundColor = parameters.lineColor
                    self.titleTopConstraint?.update(inset: parameters.titleTopOffset)
                    self.titleLabel.font = parameters.titleFont
                    self.helperLabel.isHidden = parameters.helperIsHidden
                    self.layoutIfNeeded()
                }
            )
            
            // Если сейчас кнопка очистки отображается, а новое состояние хочет ее скрыть,
            // то выполняем действие без анимации
            if previousState?.parameters().eraseButtonIsHidden == false && parameters.eraseButtonIsHidden == true {
                self.eraseButton.alpha = .hidden
            } else {
                // Иначе, если наоборот необходимо отобразить кнопку (которая ранее была скрыта),
                // выполняем показ с анимацией
                UIView.animate(
                    withDuration: Consts.AnimationDuration,
                    delay: 0,
                    options: [.beginFromCurrentState, .curveEaseInOut],
                    animations: {
                        let alpha: CGFloat = parameters.eraseButtonIsHidden ? .hidden : .visible
                        self.eraseButton.alpha = alpha
                        self.layoutIfNeeded()
                    }
                )
            }
            
            // Сохрянем текущее состояние как предыдущее
            previousState = currentState
        }
        
        // MARK: - Actions
        
        /// Вызывается когда поле становится firstResponder
        @objc
        private func editingDidBegin() {
            updateLayout()
            didStartEditing?(self)
        }
        
        /// Вызывается когда поле прекращает быть firstResponder
        @objc
        private func editingDidEnd() {
            if let textFieldText = text, textFieldText.trimmingCharacters(in: .whitespaces).isEmpty { text = nil }
            updateLayout()
            didFinishEditing?(self)
        }
        
        /// Вызывается, когда значение поля изменилось (был осуществлен ввод очередного символа с клавиатуры)
        @objc
        private func editingChanged() {
            /// сюда нужно и editingDidEnd
            updateLayout()
            didChangedText?(self)
        }
        
        /// Вызывается при нажатии на кнопку очистки
        @objc
        private func eraseButtonTap() {
            text = nil
            didChangedText?(self)
        }
    }
}

// MARK: - Components.BaseInput + UITextFieldDelegate

extension Components.BaseInput: UITextFieldDelegate {
    
    /// Вызывается при нажатии кнопки Return на клавиатуре
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // дисмиссим поле ввода
        return true
    }
}

// MARK: - Components.BaseInput + DoneButton

extension Components.BaseInput {
     
    /// Добавляет кнопку "Готово" на тулбар клавиатуры
    private func addDoneButtonOnKeyboardToolbar() {
        let doneToolbar: UIToolbar = UIToolbar(
            frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: Consts.Sizes.KeyboardToolbar.height)
        )
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(
            title: "Готово",
            style: .done,
            target: self,
            action: #selector(self.doneButtonAction)
        )
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.textField.inputAccessoryView = doneToolbar
    }
    
    /// Действие по кнопке "Готово" в тулбаре клавиатуры
    @objc private func doneButtonAction() {
        self.textField.resignFirstResponder() // дисмиссим поле ввода
    }
}
