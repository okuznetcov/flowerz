//
//  Header.swift
//  flowerz
//
//  Created by Кузнецов Олег on 15.07.2023.
//

import UIKit

// MARK: - CareHistory + Header

extension CareHistory {
    
    /// Заголовок секции в истории ухода
    public final class Header: UITableViewHeaderFooterView {
        
        /// Лейбл
        let title = UILabel()
        
        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            setup()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        /// Настраивает заголовок секции
        func setup() {
            contentView.addSubview(title)
            title.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}
