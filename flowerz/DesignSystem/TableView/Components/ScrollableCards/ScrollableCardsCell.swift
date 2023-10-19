//
//  DryPlantsCell.swift
//  flowerz
//
//  Created by Кузнецов Олег on 14.07.2023.
//

import UIKit
import SnapKit

extension UniversalTableView.Components.ScrollableCards {
    
    /// Ячейка таблицы истории ухода за растениями
    final class Cell: UITableViewCell {
        
        // MARK: - Public properties
        
        let cellTag: String = "ScrollableCards1"
        
        /// Идентификатор ячейки
        static let reuseId = "UniversalTableView.DryPlants.Cell"
        
        // MARK: - Private properties
        
        /// Карточка в ячейке таблице
        private var card: Components.ScrollableCards?
        
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
        func configure(with model: Components.ScrollableCards.Model, didTapOnCardWithTag tapClosure: ((String) -> Void)?) {
            card?.removeFromSuperview()
            backgroundColor = .clear
            card = Components.ScrollableCards(with: model)
            card?.didTapOnCard = { [weak self] in
                guard let self = self else { return }
                tapClosure?(self.cellTag)
            }
            
            setupSubviews()
        }
        
        // MARK: - Private methods
        
        private func setupSubviews() {
            guard let card = card else { return }
            contentView.addSubview(card)
            card.snp.makeConstraints {
                $0.edges.equalToSuperview()
                $0.height.equalTo(166)
            }
        }
    }
}
