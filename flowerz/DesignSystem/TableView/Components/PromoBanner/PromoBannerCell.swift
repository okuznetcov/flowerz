//
//  MainScreenPromoBannerCell.swift
//  flowerz
//
//  Created by Кузнецов Олег on 27.07.2023.
//

import UIKit
import SnapKit

protocol CellWithId {
    static var reuseId: String { get }
}

extension UniversalTableView.Components.PromoBanner {
    
    /// Ячейка таблицы истории ухода за растениями
    final class Cell: UITableViewCell, CellWithId {
        
        var didTapOnCell: (() -> Void)?

        // MARK: - Public properties
        
        /// Идентификатор ячейки
        static let reuseId = "UniversalTableView.PromoBanner.Cell"
        
        let cellTag: String = "tag"
        
        // MARK: - Private properties
        
        /// Карточка в ячейке таблице
        private var banner: Components.PromoBanner?
        
        // MARK: - Init
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            selectionStyle = .none
            
            setupSubviews()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) { nil }
        
        // MARK: - Public methods
        
        /// Настраивает ячейку таблицы истории ухода за растениями
        /// - Parameters:
        ///   - model: модель данных
        ///   - tapClosure: замыкание, вызываемое при нажатии на карточку
        func configure(with model: Components.PromoBanner.Model, didTapOnButton tapClosure: ((String) -> Void)?) {
            banner?.removeFromSuperview()
            banner = Components.PromoBanner(with: model)
            banner?.didTapOnButton = { [weak self] in
                guard let self = self else { return }
                tapClosure?(self.cellTag)
            }
            
            setupSubviews()
            layoutIfNeeded()
        }
        
        // MARK: - Private methods
        
        private func setupSubviews() {
            guard let banner = banner else { return }
            contentView.addSubview(banner)
            backgroundColor = .clear
            banner.snp.makeConstraints { $0.edges.equalToSuperview() }
        }
    }
}
