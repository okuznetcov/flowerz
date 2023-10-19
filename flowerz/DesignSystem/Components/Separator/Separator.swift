//
//  Separator.swift
//  flowerz
//
//  Created by Кузнецов Олег on 14.08.2023.
//

import UIKit
import SnapKit

// MARK: - Components + Separator
// ❌ UniversalTableView
// ✅ Eureka — SeparatorRow

extension Components {

    /// Серая линия-разделитель. Поддерживает разную ширину линии.
    public final class Separator: UIView {
        
        // MARK: - Nested Types
        
        /// Ширина линии-разделителя
        public enum Width {
            /// Широкий разделитель. Отступы L.16 R.16
            case wide
            /// Ультраширокий разделитель до границ вью. Отступы L.0 R.0
            case ultraWide
            /// Средний разделитель. Отступы L.96 R.96
            case medium
            /// Маленький разделитель. Отступы L.128 R.128
            case small
            /// Широкий разделитель, прилипающий к краю справа. Отступы L.16 R.0
            case wideAndStickyToRight
            /// Невидимый разделитель. Просто пустое пространство.
            case invisible
            
            /// Возвращает ширину линии разделителя
            /// - Returns: (leading+trailing)
            func asHorizontalOffsets() -> (leading: CGFloat, trailing: CGFloat) {
                switch self {
                    case .ultraWide:
                        return (0, 0)
                    case .wide:
                        return (16, 16)
                    case .medium:
                        return (96, 96)
                    case .small:
                        return (128, 128)
                    case .wideAndStickyToRight:
                        return (16, 0)
                    case .invisible:
                        return (0, 0)
                }
            }
        }

        /// Константы
        private enum Consts {
            
            /// Размеры
            enum Sizes {
                /// Горизонтальные отсупы
                static let horizontalOffset: CGFloat = 16
                /// Вертикальные отступы
                static let verticalOffset: CGFloat = 8
            }
            
            /// Цвет текста, который будет отображаться как ссылка
            static let lineColor: UIColor = Color.backgroundSecondary
            /// Высота линии
            static let lineHeight: CGFloat = 1
            /// Высота компонента
            static let height: CGFloat = 16
        }
        
        // MARK: - Private properies
        
        /// Линия
        private let separator: UIView = {
            let separator = UIView()
            separator.backgroundColor = Consts.lineColor
            return separator
        }()
        
        // MARK: - Init
        
        /// Серая линия-разделитель
        public init(width: Width) {
            super.init(frame: .zero)
            addSubview(separator)
            
            if width == .invisible { separator.isHidden = true }
            
            snp.makeConstraints { make in
                make.height.equalTo(Consts.height).priority(.required)
            }
            
            separator.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(width.asHorizontalOffsets().leading)
                $0.trailing.equalToSuperview().inset(width.asHorizontalOffsets().trailing)
                $0.centerY.equalToSuperview()
                $0.height.equalTo(Consts.lineHeight)
            }
        }
        
        @available(*, unavailable)
        required init?(coder aDecoder: NSCoder) { return nil }
    }
}
