//
//  TableViewTitleCell.swift
//  flowerz
//
//  Created by Кузнецов Олег on 18.07.2023.
//

import UIKit
import SnapKit

extension UniversalTableView.Components.Title {
    
    /// Ячейка таблицы истории ухода за растениями
    final class Cell: UITableViewCell {
        
        // MARK: - Public properties
        
        /// Идентификатор ячейки
        static let reuseId = "UniversalTableView.Title.Cell"
        
        // MARK: - Private properties
        
        /// Карточка в ячейке таблице
        private var title: Components.Title?
        
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
        func configure(with model: Components.Title.Model) {
            title?.removeFromSuperview()
            title = Components.Title(with: model)
            
            setupSubviews()
            layoutIfNeeded()
        }
        
        // MARK: - Private methods
        
        private func setupSubviews() {
            guard let title = title else { return }
            contentView.addSubview(title)
            backgroundColor = .clear
            title.snp.makeConstraints { $0.edges.equalToSuperview() }
        }
    }
}
