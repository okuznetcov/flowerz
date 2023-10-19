//
//  CaptionWrapper.swift
//  flowerz
//
//  Created by Кузнецов Олег on 11.08.2023.
//

import UIKit
import SnapKit

// MARK: - CaptionWrapper
// Базовый компонент. Не содержит реализаций для Eureka и универсальной таблицы.

/// Обертка над элементом дизайн-системы, отображающая подпись под элементом
public class CaptionWrapper<Element: UIView>: UIView {
    
    // MARK: - Public properties
    
    /// Элемент дизайн-системы
    public let element: Element
    
    /// Текст в подписи под элементом
    public var text: String? {
        get { descriptionLabel.text }
        
        set {
            if let text = newValue, !text.isEmpty {
                descriptionLabel.attributedText = .styled(text, with: .p2Regular)
            } else {
                descriptionLabel.text = nil
            }
        }
    }
    
    /// Является ли элемент в обертке FirstResponder
    public override var isFirstResponder: Bool {
        element.isFirstResponder
    }
    
    // MARK: - Private properties
    
    /// Лейбл, отображающий подпись под элементом
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.textColor = Color.textSecondary
        return label
    }()
    
    // MARK: - Init
    
    /// Обертка над элементом дизайн-системы, отображающая подпись под элементом
    /// - Parameter element: элемент дизайн-системы (UIView)
    public init(element: Element) {
        self.element = element
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    /// Настраивает сабвью
    private func setupSubviews() {
        
        // Добавляем сабвью
        addSubview(element)
        addSubview(descriptionLabel)
        
        // Настраиваем констрейнты
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(element.snp.bottom).priority(.high)
            make.leading.trailing.bottom.equalToSuperview().priority(.required)
        }
        
        element.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().priority(.high)
        }
    }
}
