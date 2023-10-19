//
//  BadgeGroupCell.swift
//  flowerz
//
//  Created by Кузнецов Олег on 02.08.2023.
//

import UIKit
import SnapKit

extension UniversalTableView.Components.BadgeGroup {
    
    /// Ячейка таблицы истории ухода за растениями
    final class Cell: UITableViewCell {
        
        // MARK: - Public properties
        
        /// Идентификатор ячейки
        static let reuseId = "UniversalTableView.BadgeGroup.Cell"
        
        // MARK: - Private properties
        
        /// Карточка в ячейке таблице
        private var badgeGroup: Components.BadgeGroup?
        
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
        func configure(with badges: [Components.BadgeGroup.Badge]) {
            badgeGroup?.removeFromSuperview()
            backgroundColor = .clear
            badgeGroup = Components.BadgeGroup()
            badgeGroup?.badges = badges
            setupSubviews()
        }
        
        // MARK: - Private methods
        
        private func setupSubviews() {
            guard let badgeGroup = badgeGroup else { return }
            contentView.addSubview(badgeGroup)
            badgeGroup.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(8)
                make.leading.trailing.equalToSuperview().inset(16)
            }
        }
    }
}
