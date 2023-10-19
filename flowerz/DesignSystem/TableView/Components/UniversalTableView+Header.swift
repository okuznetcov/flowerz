//
//  SectionHeader.swift
//  flowerz
//
//  Created by Кузнецов Олег on 15.07.2023.
//

import UIKit
import SnapKit

/// Таблица на главной приложения
extension UniversalTableView.Components {
    
    /// Header секции таблицы
    public final class Header: UITableViewHeaderFooterView {
        
        // MARK: - Nested Types
        
        /// Конфигурация header'а секции таблицы на главной приложения
        public struct Config {
            /// Стиль header'а
            let style: Style
            /// Текст
            let text: String
            
            /// Стиль header'а
            public enum Style {
                /// Large h38 Header 24 Bold -0.5 textPrimary
                case large
                /// Small h12 Paragraph 12 Medium 0.0 textSecondary
                case small
                
                /// Параметры стиля header'а
                struct StyleParameters {
                    /// Типографика
                    let typography: Typography
                    /// Высота
                    let height: CGFloat
                    /// Цвет текста
                    let textColor: UIColor
                }
                
                /// Возвращает предопределенный стиль header'а таблицы главной приложения
                func asStyleParameters() -> StyleParameters {
                    switch self {
                        case .large:
                            return .init(typography: .h1Bold, height: 38, textColor: Color.textPrimary)
                        case .small:
                            return .init(typography: .p2Medium, height: 26, textColor: Color.textSecondary)
                    }
                }
            }
        }
        
        /// Идентификатор ячейки
        public static let reuseId = String(describing: "UniversalTableView.Header.self")
        
        // MARK: - Private properties
        
        /// Размеры
        private enum Sizes {
            /// Отсупы
            static let defaultOffsets: UIEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        }
        
        /// Заголовок
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.isUserInteractionEnabled = false
            return label
        }()
        
        // MARK: - Init
        
        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            setup()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Public methods
        
        /// Конфигурирует header согласно переданной конфигурации
        /// - Parameter configuration: конфигурация header'а
        public func configure(with configuration: Config) {
            let style = configuration.style.asStyleParameters()
            titleLabel.attributedText = .styled(configuration.text, with: style.typography)
            titleLabel.textColor = style.textColor
        }
        
        // MARK: - Private methods
        
        /// Настраивает компонент
        private func setup() {
            contentView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(Sizes.defaultOffsets)
            }
        }
    }
}
