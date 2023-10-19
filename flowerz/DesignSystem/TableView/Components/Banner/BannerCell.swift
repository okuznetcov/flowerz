//
//  TableViewBannerCell.swift
//  flowerz
//
//  Created by Кузнецов Олег on 18.07.2023.
//

import UIKit
import SnapKit

extension UniversalTableView.Components.Banner {
    
    /// Ячейка таблицы истории ухода за растениями
    final class Cell: UITableViewCell {
        
        // MARK: - Public properties
        
        /// Идентификатор ячейки
        static let reuseId = "UniversalTableView.Banner.Cell"
        
        // MARK: - Private properties
        
        /// Карточка в ячейке таблице
        private var banner: Components.Banner?
        
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
        func configure(with model: Components.Banner.Model, didTapOnElement tapClosure: (() -> Void)?) {
            banner?.removeFromSuperview()
            banner = Components.Banner(with: model)
            banner?.didTapOnBanner = tapClosure
            
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
