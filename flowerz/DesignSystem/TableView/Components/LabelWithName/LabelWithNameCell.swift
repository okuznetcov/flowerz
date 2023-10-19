//
//  LabelWithNameCell.swift
//  flowerz
//
//  Created by Кузнецов Олег on 02.08.2023.
//

import UIKit
import SnapKit

extension UniversalTableView.Components.LabelWithName {
    
    /// Ячейка таблицы истории ухода за растениями
    final class Cell: UITableViewCell {
        
        // MARK: - Public properties
        
        let cellTag: String = "ScrollableCards1"
        
        /// Идентификатор ячейки
        static let reuseId = "UniversalTableView.LabelWithName.Cell"
        
        // MARK: - Private properties
        
        /// Карточка в ячейке таблице
        private var label: Components.LabelWithName?
        
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
        func configure(with model: Components.LabelWithName.Model) {
            label?.removeFromSuperview()
            backgroundColor = .clear
            label = Components.LabelWithName(with: model)
            setupSubviews()
        }
        
        // MARK: - Private methods
        
        private func setupSubviews() {
            guard let label = label else { return }
            contentView.addSubview(label)
            label.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
}
