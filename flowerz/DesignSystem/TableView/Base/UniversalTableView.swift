//
//  TableView.swift
//  flowerz
//
//  Created by Кузнецов Олег on 29.07.2023.
//

import UIKit

public enum UniversalTableView {
    //typealias Source = UITableViewDataSource & UITableViewDelegate
    
    static func simple(source dataSourceAndDelegate: DataSource) -> UITableView {
        let table = UITableView(frame: .zero, style: .grouped)
        table.separatorStyle = .none
        table.dataSource = dataSourceAndDelegate
        table.delegate = dataSourceAndDelegate
        table.backgroundColor = .clear
        table.rowHeight = UITableView.automaticDimension
        table.showsVerticalScrollIndicator = false
        table.showsHorizontalScrollIndicator = false
        table.sectionHeaderHeight = 0
        table.sectionFooterHeight = 0
        
        typealias Main = UniversalTableView.Components
        
        table.register(Main.History.Cell.self, forCellReuseIdentifier: Main.History.Cell.reuseId)
        table.register(Main.ScrollableCards.Cell.self, forCellReuseIdentifier: Main.ScrollableCards.Cell.reuseId)
        table.register(Main.Header.self, forHeaderFooterViewReuseIdentifier: Main.Header.reuseId)
        table.register(Main.Title.Cell.self, forCellReuseIdentifier: Main.Title.Cell.reuseId)
        table.register(Main.Banner.Cell.self, forCellReuseIdentifier: Main.Banner.Cell.reuseId)
        table.register(Main.PromoBanner.Cell.self, forCellReuseIdentifier: Main.PromoBanner.Cell.reuseId)
        table.register(Main.LabelWithName.Cell.self, forCellReuseIdentifier: Main.LabelWithName.Cell.reuseId)
        table.register(Main.Button.Cell.self, forCellReuseIdentifier: Main.Button.Cell.reuseId)
        
        return table
    }
}
