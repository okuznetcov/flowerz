//
//  RoundShadowView.swift
//  flowerz
//
//  Created by Кузнецов Олег on 01.08.2023.
//

import UIKit
import SnapKit

/// Контейнер, рисующий тень вокруг вью со скругленными углами
public final class RoundShadowView: UIView {
    
    // MARK: - Nested Types
    
    /// Тень
    public struct Shadow {
        
        /// Цвет тени
        public let color: UIColor
        /// Смещение тени по осям X и Y относительно центра контейнера
        public let offset: CGSize
        /// Прозрачность тени (где 1 — непрозрачная; 0 — полностью прозрачная)
        public let opacity: Float
        /// Радиус тени
        public let radius: CGFloat
    }
    
    // MARK: - Private Properties
    
    /// Контейнер, вокруг которого должна быть тень
    public private(set) var containerView = UIView()
    
    /// Модель тени
    private var shadow: Shadow?
    
    /// Скругление углов контейнера
    private var cornerRadius: CGFloat?
    
    // MARK: - Init
    
    /// Контейнер, рисующий тень вокруг вью со скругленными углами
    /// - Parameters:
    ///   - shadow: тень
    ///   - containerCornerRadius: скругление углов контейнера
    public init(shadow: Shadow, containerCornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.shadow = shadow
        self.cornerRadius = containerCornerRadius
        layoutView()
    }
    
    // MARK: - Layout
    
    public override func layoutSubviews() {
        makeShadow()
    }
    
    // MARK: - Required Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    /// Настраивает тень
    private func makeShadow() {
        guard let shadow = shadow, let cornerRadius = cornerRadius else { return }
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = shadow.color.cgColor
        layer.shadowOffset = shadow.offset
        layer.shadowOpacity = shadow.opacity
        layer.shadowRadius = shadow.radius
    }
    
    /// Настраивает вид контейнера
    private func layoutView() {
        guard let cornerRadius = cornerRadius else { return }
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.masksToBounds = true
        addSubview(containerView)

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
