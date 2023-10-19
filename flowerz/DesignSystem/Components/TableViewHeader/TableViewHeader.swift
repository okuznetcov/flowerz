//
//  TableViewHeader.swift
//  flowerz
//
//  Created by Кузнецов Олег on 15.07.2023.
//

import UIKit
import SnapKit

// MARK: - Components + TableViewHeader
// ✅ UniversalTableView — Header
// ❌ Eureka

extension Components {
    
    /// Header таблицы TableView
    public final class TableViewHeader: UITableViewHeaderFooterView {
        
        // MARK: - Public properties

        /// Лейбл в хэдере
        public let title = UILabel()
        
        // MARK: - Init
        
        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            setup()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Private methods
        
        /// Настраивает хэдер
        private func setup() {
            contentView.addSubview(title)
            title.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}
