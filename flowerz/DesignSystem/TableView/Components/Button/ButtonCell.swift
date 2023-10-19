//
//  ButtonCell.swift
//  flowerz
//
//  Created by Кузнецов Олег on 02.08.2023.
//

import UIKit
import SnapKit

extension UniversalTableView.Components.Button {
    
    /// Ячейка таблицы истории ухода за растениями
    final class Cell: UITableViewCell {
        
        // MARK: - Public properties
        
        /// Идентификатор ячейки
        static let reuseId = "UniversalTableView.Button.Cell"
        
        // MARK: - Private properties
        
        /// Карточка в ячейке таблице
        private var button: Components.Button?
        
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
        func configure(with model: Components.Button.Model) {
            button?.removeFromSuperview()
            backgroundColor = .clear
            button = Components.Button(model: model)
            setupSubviews()
        }
        
        // MARK: - Private methods
        
        private func setupSubviews() {
            guard let button = button else { return }
            contentView.addSubview(button)
            button.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(8)
                make.leading.trailing.equalToSuperview().inset(16)
            }
        }
    }
}
