//
//  HistoryCell + InlineOperationView.swift
//  flowerz
//
//  Created by Кузнецов Олег on 12.07.2023.
//

import UIKit
import SnapKit

// MARK: - CareHistory.HistoryCell + InlineOperationView

extension CareHistory.HistoryCell {
    
    /// View одной операции ухода
    /// В строчку: цветная точка + название + количество
    public final class InlineOperationView: UIView {
        
        /// Размеры
        private enum Sizes {
            /// Расстояние от точки до названия операции
            static let spacingBetweenDotAndName: CGFloat = 10
            /// Горизонтальное расстояние
            static let horizontalSpacing: CGFloat = 8
            /// Размер точки
            static let dotSize: CGFloat = 8
        }
        
        /// Горизонтальный контейнер, в котором лежат элементы
        private let horizontalContainer: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.distribution = .fillProportionally
            stack.alignment = .leading
            stack.spacing = Sizes.horizontalSpacing
            
            return stack
        }()
        
        /// Название операции
        private let nameLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 1
            label.textColor = Color.textPrimary
            label.textAlignment = .left
            
            return label
        }()
        
        /// Счетчик количества
        private let quantityLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 1
            label.textColor = Color.textSecondary
            label.textAlignment = .right
            
            return label
        }()
        
        /// Точка
        private let dot: UIImageView = {
            let image = UIImageView(image: UIImage(named: "dot")!.withRenderingMode(.alwaysTemplate))
            image.contentMode = .scaleAspectFit
            return image
        }()
        
        /// View одной операции ухода
        /// В строчку: цветная точка + название + количество
        /// - Parameters:
        ///   - name: Название операции
        ///   - quantity: Количество
        ///   - dotColor: Цвет точки
        public init(name: String, quantity: String, dotColor: UIColor) {
            super.init(frame: .zero)
            setupLayout()
            setupContent(name: name, quantity: quantity, dotColor: dotColor)
        }
        
        @available(*, unavailable)
        required init?(coder aDecoder: NSCoder) { return nil }
        
        /// Настраивает отображение
        private func setupLayout() {
            
            // Добавляем сабвью
            addSubview(dot)
            addSubview(horizontalContainer)
            horizontalContainer.addArrangedSubview(nameLabel)
            horizontalContainer.addArrangedSubview(quantityLabel)
            
            // Настраиваем констрейнты
            horizontalContainer.snp.makeConstraints { make in
                make.trailing.top.bottom.equalToSuperview()
                make.leading.equalTo(dot.snp.trailing).offset(Sizes.spacingBetweenDotAndName)
                make.height.equalTo(nameLabel.snp.height)
            }
            
            dot.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.height.width.equalTo(Sizes.dotSize)
                make.centerY.equalTo(nameLabel.snp.centerY)
            }
        
            quantityLabel.snp.makeConstraints { make in
                make.height.equalTo(nameLabel)
            }
        }
        
        /// Обновляет контент в элементах
        /// - Parameters:
        ///   - name: Название операции
        ///   - quantity: Количество
        ///   - dotColor: Цвет точки
        private func setupContent(name: String, quantity: String, dotColor: UIColor) {
            nameLabel.attributedText = .styled(name, with: .p1Regular)
            quantityLabel.attributedText = .styled(quantity, with: .p2Regular)
            dot.tintColor = dotColor
        }
    }
}
