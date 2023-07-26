//
//  Banner.swift
//  flowerz
//
//  Created by Кузнецов Олег on 18.07.2023.
//

import UIKit
import Foundation

/// Баннер в различных стилях.
/// Может содержать заголовок, подзаголовок и изображение.
public final class Banner: UIView {

    // MARK: - Nested Types
    
    /// Модель баннера
    public struct Model {
        /// Заголовок (необязательно)
        let title: String?
        /// Подзаголовок (обязательно)
        let subTitle: String
        /// Стиль
        let style: Style
    }
    
    /// Стиль баннера
    public enum Style {
        /// Простой (заголовок + подзаголовок)
        case plain
        /// Изображение справа. Применяется маска по границам баннера.
        case rightImage(image: UIImage)
        /// Изображение-фон баннера. Применяется маска по границам баннера.
        case backgroundImage(image: UIImage)
    }
    
    /// Размеры
    private enum Sizes {
        /// Скругление углов баннера
        static let cornerRadius: CGFloat = 25.0
        /// Внешние отступы до границ баннера
        static let defaultOffsets: UIEdgeInsets = .init(top: 0, left: 16, bottom: 0, right: 16)
        /// Вертикальные отступы текста от внутренних границ баннера
        static let textVerticalOffset: CGFloat = 16
        /// Горизонтальные отступы текста от внутренних границ баннера
        static let textHorizontalOffset: CGFloat = 20
        /// Расстояние между текстом и изображением справа
        static let spacingBetweenTextAndRightImage: CGFloat = 10
        /// Расстояние между заголовком и подзаголовком
        static let spacingBetweenTitleAndSubtitle: CGFloat = 4
        /// Минимальная высота баннера с картинкой справа
        static let rightImageBannerMinimumHeight: CGFloat = 80
        /// Рекомендуемая высота баннера с фоновым изображением
        static let backgroundImageBannerRecomendedHeight: CGFloat = 40
        /// Рекомендуемая высота простого баннера
        static let plainBannerRecomendedHeight: CGFloat = 40
        /// Высота картинки справа
        static let rightImageHeight: CGFloat = 100
    }
    
    // MARK: - Public properties
    
    /// Вызывается при нажатии на баннер
    public var didTapOnBanner: (() -> Void)?

    // MARK: - Elements
    
    /// Карточка, в которой размещается контент баннера
    private let card: BaseButton = {
        let view = BaseButton()
        view.backgroundColor = Color.backgroundSecondary
        view.layer.masksToBounds = true
        view.makeRoundCorners(radius: Sizes.cornerRadius)
        
        return view
    }()
    
    /// Заголовок баннера
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.textPrimary
        label.isUserInteractionEnabled = false
        label.numberOfLines = 0
        
        return label
    }()
    
    /// Подзаголовок баннера
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.textSecondary
        label.isUserInteractionEnabled = false
        label.numberOfLines = 0
        
        return label
    }()
    
    /// Изображение в баннере
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()

    // MARK: - Init
    
    /// Баннер в различных стилях. Может содержать заголовок, подзаголовок и изображение.
    /// - Parameter model: модель данных, на основе которой будет отрисован баннер
    public init(with model: Model) {
        super.init(frame: .zero)
        setup(using: model)
        makeConstraints(with: model.style)
        setupActions()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    // MARK: - Private methods
    
    /// Настраивает баннер
    /// - Parameter model: модель баннера
    private func setup(using model: Model) {
        
        // Обновляем текст в заголовке баннера, если текст есть.
        // Иначе — скрываем заголовок
        if let title = model.title, !title.isEmpty {
            titleLabel.attributedText = .styled(title, with: .h3Semibold)
        } else {
            titleLabel.isHidden = true
        }

        // Обновляем текст в подзаголовке баннера карточки
        subTitleLabel.attributedText = .styled(model.subTitle, with: .p2Regular)
        
        // Добавляем карточку на баннер
        addSubview(card)

        // Настраиваем изображение в баннере в зависимости от его стиля
        switch model.style {
            // Изображение в качестве фона баннера
            case .backgroundImage(let image):
                card.addSubview(imageView)
                imageView.image = image
            
            // Изображение справа
            case .rightImage(let image):
                card.addSubview(imageView)
                imageView.image = image
            
            // Простой — изображение не нужно (только заголовок + подзаголовок)
            case .plain:
                break
        }
        
        // Добавляем тексты на баннер
        card.addSubview(titleLabel)
        card.addSubview(subTitleLabel)
    }
    
    /// Настраивает констрейнты
    /// - Parameter style: стиль баннера
    private func makeConstraints(with style: Style) {
        
        // Заголовок
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(card).inset(Sizes.textVerticalOffset)
            $0.leading.equalTo(card).inset(Sizes.textHorizontalOffset)
            
            switch style {
                // Изображение в качестве фона баннера или простой баннер
                case .backgroundImage, .plain:
                    $0.trailing.equalTo(card).inset(Sizes.textHorizontalOffset)
                
                // Изображение справа
                case .rightImage:
                    $0.trailing.equalTo(imageView.snp.leading).offset(-Sizes.spacingBetweenTextAndRightImage)
            }
        }
        
        // Подзаголовок
        subTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleLabel)
            if titleLabel.isHidden {
                $0.top.equalTo(titleLabel.snp.bottom)
            } else {
                $0.top.equalTo(titleLabel.snp.bottom).offset(Sizes.spacingBetweenTitleAndSubtitle)
            }
            $0.bottom.equalTo(card).inset(Sizes.textVerticalOffset)
        }
        
        // Карточка баннера
        card.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(Sizes.defaultOffsets)
            $0.bottom.equalToSuperview().inset(Sizes.defaultOffsets).priority(.high)
            switch style {
                // Изображение справа
                case .rightImage:
                    $0.height.greaterThanOrEqualTo(Sizes.rightImageBannerMinimumHeight)

                // Изображение в качетсве фона баннера
                case .backgroundImage:
                    $0.height.equalTo(Sizes.backgroundImageBannerRecomendedHeight).priority(.high)

                // Простой баннер без изображения
                case .plain:
                    $0.height.greaterThanOrEqualTo(Sizes.plainBannerRecomendedHeight).priority(.high)
            }
        }
        
        // Изображение
        imageView.snp.makeConstraints { make in
            switch style {
                // Изображение в качетсве фона баннера
                case .backgroundImage:
                    make.edges.equalTo(card)
                
                // Изображение справа
                case .rightImage:
                    make.bottom.trailing.equalTo(card)
                    make.width.equalTo(imageView.snp.height)
                    make.height.equalTo(Sizes.rightImageHeight)
                
                // Простой баннер без изображения
                case .plain:
                    break
            }
        }
    }
    
    /// Настраивает действия
    private func setupActions() {
        card.pressUpAction = { [weak self] in self?.didTapOnBanner?() }
    }
}
