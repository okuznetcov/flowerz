//
//  TableViewCell.swift
//  flowerz
//
//  Created by Кузнецов Олег on 12.07.2023.
//

import UIKit
import SnapKit

extension UniversalTableView.Components.History {
    
    /// Ячейка таблицы истории ухода за растениями
    final class Cell: UITableViewCell {
        
        // MARK: - Public properties
        
        /// Идентификатор ячейки
        static let reuseId = "UniversalTableView.History.Cell"
        
        // MARK: - Private properties
        
        /// Карточка в ячейке таблице
        private var card: Components.History?
        
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
        func configure(with model: Components.History.Model, didTapOnCard tapClosure: (() -> Void)?) {
            card?.removeFromSuperview()
            card = Components.History(with: model)
            card?.didTapOnCard = tapClosure
            
            setupSubviews()
            layoutIfNeeded()
        }
        
        // MARK: - Private methods
        
        private func setupSubviews() {
            guard let card = card else { return }
            contentView.addSubview(card)
            backgroundColor = .clear
            card.snp.makeConstraints { $0.edges.equalToSuperview() }
        }
    }
}
