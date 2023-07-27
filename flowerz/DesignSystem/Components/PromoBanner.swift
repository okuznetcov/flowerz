//
//  PromoBanner.swift
//  flowerz
//
//  Created by Кузнецов Олег on 27.07.2023.
//

import UIKit
import SnapKit

/// Промо-баннер с фоновым изображением и кнопкой
/// Содержит заголовок, подзаголовок, опциональную кнопку
public final class PromoBanner: UIView {

    // MARK: - Nested Types
    
    /// Модель промо-баннера
    public struct Model {
        
        /// Cтиль промо-баннера
        public struct Style {
            
            /// Расположение кнопки
            enum ButtonPlacement {
                /// Внизу
                case sticksToBottom
                /// После подзаголовка
                case sticksToSubtitle
            }
            
            /// Высота. Указывается явно. Изображение будет растянуто по высоте с сохранением пропорций.
            let height: CGFloat
            /// Цвет текста
            let textColor: UIColor
            /// Расположение кнопки
            let buttonPlacement: ButtonPlacement
            /// Флаг, анимировать ли изображение
            let animatesImage: Bool
            /// Флаг, отображать ли тень над изображением
            let showsShadow: Bool
        }
        
        /// Заголовок
        let title: String
        /// Подзаголовок
        let subTitle: String
        /// Изображение
        let image: UIImage
        /// Кнопка (необязательно)
        let button: Button.Model?
        /// Стиль
        let style: Style
    }
    
    /// Константы
    private enum Consts {
        
        /// Размеры
        enum Sizes {
            /// Скругление углов баннера
            static let cornerRadius: CGFloat = 17
            /// Внешние отступы до границ баннера
            static let defaultOffsets: UIEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
            /// Внутренние вертикальные отступы
            static let verticalInnerOffset: CGFloat = 40
            /// Внутренние горизонтальные отступы
            static let horizontalInnerOffset: CGFloat = 24
            /// Расстояние между заголовком и подзаголовком
            static let spacingBetweenTitleAndSubtitle: CGFloat = 20
        }
        
        /// Настройки анимации фонового изображения
        enum ImageAnimation {
            /// Кривая анимаций, по которой будет анимироваться зум фонового изображения
            static let curve: UIView.AnimationOptions = .curveEaseInOut
            /// Длительность анимации зумирования фонового изображения
            static let duration: TimeInterval = 10
            /// Целевое увеличение изображения
            static let scale = 1.2
        }
        
        /// Конфигурация кнопки по-умолчанию
        static let defaultButtonConfiguration = Button.Model(
            text: "Подробнее",
            textColor: Color.textWhite,
            color: Color.backgroundSecondary,
            size: .medium,
            style: .circular
        )
    }
    
    // MARK: - Public properties
    
    /// Вызывается при нажатии на кнопку в баннере
    public var didTapOnButton: (() -> Void)?

    // MARK: - Elements
    
    /// Вью, в котором размещается контент
    private let card: UIView = {
        let view = UIView()
        view.backgroundColor = Color.backgroundSecondary
        view.layer.masksToBounds = true
        view.layer.cornerRadius = Consts.Sizes.cornerRadius
        
        return view
    }()
    
    /// Заголовок
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.textWhite
        label.isUserInteractionEnabled = false
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    /// Подзаголовок
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.textWhite
        label.isUserInteractionEnabled = false
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    /// Фоновое изображение
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    /// Тень
    private let shadowView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "promoBannerShadow")!
        return image
    }()
    
    /// Кнопка
    private let button = Button(model: Consts.defaultButtonConfiguration)

    // MARK: - Init
    
    /// Промо-баннер с фоновым изображением и кнопкой. Содержит заголовок, подзаголовок, опциональную кнопку
    public init(with model: Model) {
        super.init(frame: .zero)
        setup(using: model)
        makeConstraints(with: model)
        setupActions()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: - Private methods
    
    /// Настраивает баннер
    /// - Parameter model: модель баннера
    private func setup(using model: Model) {
        
        // Добавляем основную вью
        addSubview(card)
        
        // Обновляем тексты в баннере
        titleLabel.attributedText = .styled(model.title, with: .h1PromoBold)
        subTitleLabel.attributedText = .styled(model.subTitle, with: .h3Bold)

        // Скрываем тень если это необходимо
        shadowView.isHidden = !model.style.showsShadow
        
        // Добавляем изображения (картинку и тень)
        imageView.image = model.image
        card.addSubview(imageView)
        card.addSubview(shadowView)
        
        // Если передана модель кнопки, настраиваем ее. Иначе — скрываем кнопку
        if let buttonModel = model.button {
            button.model = buttonModel
        } else {
            button.isHidden = true
        }
        
        // Добавляем кнопку на вьюху
        card.addSubview(button)
        
        // Если необходимо, анимируем изображение
        if model.style.animatesImage {
            typealias Animation = Consts.ImageAnimation
            
            UIView.animate(
                withDuration: Animation.duration,
                delay: 0.0,
                options: Animation.curve,
                animations: {
                    self.imageView.layer.transform = CATransform3DMakeScale(Animation.scale, Animation.scale, 1)
                }
            )
        }
        
        // Добавляем лейблы на баннер
        card.addSubview(titleLabel)
        card.addSubview(subTitleLabel)
    }
    
    /// Настраивает констрейнты
    /// - Parameter style: стиль баннера
    private func makeConstraints(with model: Model) {
        
        // Заголовок
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Consts.Sizes.horizontalInnerOffset)
            $0.top.equalToSuperview().inset(Consts.Sizes.verticalInnerOffset)
        }
        
        // Подзаголовок
        subTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom).offset(Consts.Sizes.spacingBetweenTitleAndSubtitle)
        }
        
        // Карточка баннера
        card.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(Consts.Sizes.defaultOffsets)
            $0.bottom.equalToSuperview().inset(Consts.Sizes.defaultOffsets).priority(.high)
            $0.height.equalTo(model.style.height).priority(.required)
        }
        
        // Изображение
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Тень
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Кнопка
        button.snp.makeConstraints { make in
            switch model.style.buttonPlacement {
                case .sticksToBottom:
                    make.bottom.equalTo(card).inset(Consts.Sizes.verticalInnerOffset)
                case .sticksToSubtitle:
                    make.top.equalTo(subTitleLabel.snp.bottom).offset(Consts.Sizes.spacingBetweenTitleAndSubtitle)
            }
            make.centerX.equalTo(card)
        }
    }
    
    /// Настраивает действия
    private func setupActions() {
        button.pressUpAction = { [weak self] in self?.didTapOnButton?() }
    }
}
