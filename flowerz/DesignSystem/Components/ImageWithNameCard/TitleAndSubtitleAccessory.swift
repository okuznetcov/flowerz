//
//  TitleAndSubtitleAccessory.swift
//  flowerz
//
//  Created by Кузнецов Олег on 15.08.2023.
//

import UIKit

extension Components.ImageWithNameCard {
    
    public final class TitleAndSubtitleAccessory: UIView {
        
        // MARK: - Nested Types

        public struct Model {
            let title: String
            let subTitle: String
        }
        
        // MARK: - Public properties
        
        /// Модель данных, на основе которой будет отрисован компонент
        /// При изменении модели компонент обновляется
        public var model: Model? {
            didSet {
                guard let model = model else { return }
                setup(using: model)
            }
        }
        
        /// Заголовок карточки
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 1
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            return label
        }()

        /// Подзаголовок карточки
        private let subTitleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 1
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            label.textColor = Color.textSecondary
            
            return label
        }()
        
        // MARK: - Init

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError()
        }
        
        /// - Parameter frame: область
        public override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        // MARK: - Public methods
    
        /// - Parameter model: модель данных, на основе которой будет отрисована карточка
        public func configure(with model: Model) {
            setup(using: model)
            addSubviews()
            makeConstraints()
        }
        
        // MARK: - Private methods

        /// - Parameter model: модель карточки
        private func setup(using model: Model) {
            
            // Обновляем тексты
            titleLabel.attributedText = .styled(model.title, with: .p2Medium)
            subTitleLabel.attributedText = .styled(model.subTitle, with: .p2Regular)
        }
        
        /// Добавляет сабвью
        private func addSubviews() {
            addSubview(titleLabel)
            addSubview(subTitleLabel)
        }

        /// Настраивает констрейнты
        private func makeConstraints() {
            
            // Тексты
            titleLabel.snp.makeConstraints { make in
                make.leading.trailing.top.equalToSuperview()
            }
            
            subTitleLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom)
                make.leading.trailing.bottom.equalToSuperview()
            }
        }
    }
}
