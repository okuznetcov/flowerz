//
//  ImageWithNameCard.swift
//  flowerz
//
//  Created by Кузнецов Олег on 30.07.2023.
//

import UIKit
import SnapKit

// MARK: - Components + ImageWithNameCard

extension Components {
    
    /// Карточка с картинкой, заголовком, подзаголовком и опциональной тенью.
    /// Не является частью коллекции карточек с горизонтальной прокруткой. Это — отдельный компонент.
    public final class ImageWithNameCard: UIView {
        
        // MARK: - Nested Types
        
        /// Размеры
        private enum Sizes {
            /// Скругление углов карточки
            static let cornerRadius: CGFloat = 11
            /// Внутренние отступы от границ карточки
            static let innerOffsets = 8
            /// Расстояние между картинкой и текстом
            static let spacingBetweenImageAndText = 8
        }
        
        public enum CollectionViewSize {
            static let width: CGFloat = 120
            static let height: CGFloat = 150
            static let heightToWidthRatio: CGFloat = 1.25
        }
        
        // MARK: - Public properties
        
        /// Модель данных, на основе которой будет отрисован компонент
        /// При изменении модели компонент обновляется
        public var model: Model? {
            didSet {
                guard let model = model else { return }
                setup(using: model)
                setupAccessory(using: model)
                setupSelectionStyle(using: model)
                updateSelection()
            }
        }
        
        public var isSelected: Bool = false {
            didSet { updateSelection() }
        }
        
        // MARK: - Private properties

        /// Карточка, в которой отображается заголовок, подзаголовок и картика
        private let card: UIView = {
            let view = UIView()
            view.backgroundColor = Color.backgroundSecondary
            view.layer.cornerRadius = Sizes.cornerRadius
            view.layer.masksToBounds = true
            return view
        }()
        
        /// Тень вокруг карточки, в которой размещается контент
        private var shadowView = RoundShadowView(
            //shadow: .init(color: .green, offset: .init(width: 0, height: 5), opacity: 0.5, radius: 50),
            shadow: .init(color: .clear, offset: .zero, opacity: 0, radius: 0),
            containerCornerRadius: Sizes.cornerRadius
        )
        
        /// Изображение в карточке
        private let hugeCheckmarkOverImage: UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFill
            image.layer.cornerRadius = Sizes.cornerRadius
            image.image = UIImage.resolve(named: "hugeCheckmarkOverlay")
            image.clipsToBounds = true
            image.isHidden = true
            return image
        }()
        
        /// Изображение в карточке
        private let image: UIImageView = {
            let image = UIImageView()
            image.contentMode = .scaleAspectFill
            image.layer.cornerRadius = Sizes.cornerRadius
            image.clipsToBounds = true
            return image
        }()
        
        private var accessory: UIView?
        
        private let accessoryContainer = UIView()
        
        private let selectionMark = SelectionMark(style: .radiobutton)
        
        private var selectionStyle: Model.SelectionStyle?
        
        // MARK: - Init

        /// Ячейка-карточка с картинкой, заголовком, подзаголовком и опциональной тенью.
        /// Не является частью коллекции карточек с горизонтальной прокруткой. Это — отдельный компонент.
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError()
        }
        
        /// Ячейка-карточка с картинкой, заголовком, подзаголовком и опциональной тенью.
        /// Не является частью коллекции карточек с горизонтальной прокруткой. Это — отдельный компонент.
        /// - Parameter frame: область
        public override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        // MARK: - Public methods
        
        /// Ячейка-карточка с картинкой, заголовком, подзаголовком и опциональной тенью.
        /// Не является частью коллекции карточек с горизонтальной прокруткой. Это — отдельный компонент.
        /// - Parameter model: модель данных, на основе которой будет отрисована карточка
        public func configure(with model: Model) {
            setup(using: model)
            addSubviews()
            makeConstraints()
            setupAccessory(using: model)
            setupSelectionStyle(using: model)
            updateSelection()
        }
        
        // MARK: - Private methods

        /// Настраивает карточку согласно переданной модели
        /// - Parameter model: модель карточки
        private func setup(using model: Model) {
            // Обновляем изображение
            image.image = model.image
        }
        
        private func setupAccessory(using model: Model) {
            accessory?.removeFromSuperview()
            accessoryContainer.removeFromSuperview()
            
            accessoryContainer.snp.removeConstraints()
            accessory?.snp.removeConstraints()
            
            switch model.accessory {
                case .button(let title, let tapClosure):
                    let accessory = ButtonAccessory()
                    accessory.configure(with: .init(title: title))
                    accessory.didTapOnButton = tapClosure
                    self.accessory = accessory
                
                case .text(let title, let subTitle):
                    let accessory = TitleAndSubtitleAccessory()
                    accessory.configure(with: .init(title: title, subTitle: subTitle))
                    self.accessory = accessory
            }
            
            guard let accessory = accessory else { return }
            
            card.addSubview(accessoryContainer)
            accessoryContainer.addSubview(accessory)
            
            accessoryContainer.snp.makeConstraints { make in
                make.leading.trailing.bottom.equalToSuperview().inset(Sizes.innerOffsets)
                make.top.equalTo(image.snp.bottom).offset(Sizes.spacingBetweenImageAndText)
                make.height.equalTo(accessoryContainer.snp.width).dividedBy(4.5)
            }
            
            accessory.snp.makeConstraints { make in
                make.centerY.equalTo(accessoryContainer)
                make.leading.trailing.equalToSuperview()
            }
        }
        
        private func setupSelectionStyle(using model: Model) {
            selectionStyle = model.selectionStyle
            
            switch selectionStyle {
                case .checkboxAtCorner:
                    selectionMark.isHidden = false
                    selectionMark.style = .checkbox
                    hugeCheckmarkOverImage.isHidden = true
                
                case .radiobuttonAtCorner:
                    selectionMark.isHidden = false
                    selectionMark.style = .radiobutton
                    hugeCheckmarkOverImage.isHidden = true
                
                case .none:
                    selectionMark.isHidden = true
                    hugeCheckmarkOverImage.isHidden = true
                
                case .hugeCheckboxOverImage:
                    selectionMark.isHidden = true
            }
        }
        
        private func updateSelection() {
            switch selectionStyle {
                case .checkboxAtCorner, .radiobuttonAtCorner:
                    selectionMark.isSelected = isSelected
                
                case .hugeCheckboxOverImage:
                    hugeCheckmarkOverImage.isHidden = !isSelected
                
                case .none:
                    break
            }
        }
        
        /// Добавляет сабвью
        private func addSubviews() {
            addSubview(shadowView)
            shadowView.containerView.addSubview(card)
            card.addSubview(image)
            card.addSubview(hugeCheckmarkOverImage)
            card.addSubview(selectionMark)
        }

        /// Настраивает констрейнты
        private func makeConstraints() {
            
            // Тень
            shadowView.snp.makeConstraints { $0.edges.equalToSuperview() }
            
            // Карточка
            card.snp.makeConstraints { $0.edges.equalToSuperview() }
            
            // Изображение
            image.snp.makeConstraints { make in
                make.width.equalTo(image.snp.height).priority(.required)
                make.leading.trailing.top.equalTo(card).inset(Sizes.innerOffsets)
            }
            
            // Изображение
            hugeCheckmarkOverImage.snp.makeConstraints { make in
                make.edges.equalTo(image).priority(.required)
            }
            
            selectionMark.snp.makeConstraints { make in
                make.top.trailing.equalTo(image).inset(10)
            }
        }
    }
}
