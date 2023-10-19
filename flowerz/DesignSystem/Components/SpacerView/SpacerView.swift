//
//  SpacerView.swift
//  flowerz
//
//  Created by Кузнецов Олег on 12.07.2023.
//

import UIKit
import SnapKit

// MARK: - Components + SpacerView
// ❌ UniversalTableView
// ❌ Eureka

extension Components {
    
    /// Разделитель с указанной осью и высотой / шириной
    public final class SpacerView: UIView {
        
        // MARK: - Nested Types
        
        /// Ось разделителя
        public enum Axis {
            /// Вертикальная
            case vertical
            /// Горизонтальная
            case horizontal
        }
        
        // MARK: - Init
        
        /// Разделитель с указанной осью и высотой / шириной
        /// - Parameters:
        ///   - size: высота / ширина CGFloat
        ///   - axis: ось (горизонтальный / вертикальный разделитель)
        public init(size: CGFloat, axis: Axis) {
            super.init(frame: .zero)
            
            snp.makeConstraints { make in
                switch axis {
                    case .horizontal:
                        make.width.equalTo(size)
                    case .vertical:
                        make.height.equalTo(size)
                }
            }
            invalidateIntrinsicContentSize()
        }
        
        @available(*, unavailable)
        required init?(coder aDecoder: NSCoder) { return nil }
    }
}
