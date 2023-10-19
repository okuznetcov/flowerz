//
//  MainTabViewController.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import UIKit
import Eureka

final class MainTabViewController: UIViewController {
    
    private let dataSource = UniversalTableView.DataSource()
    private lazy var tableView = UniversalTableView.simple(source: dataSource)
    
    private let output: MainTabViewOutput
    
    init(output: MainTabViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.background
        title = "Главная"
        navigationController?.navigationBar.prefersLargeTitles = true
        dataSource.didTapOnItemWithTag = { tag in
            print("tap on \(tag)")
            self.output.didTapOnButton()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTableView()
        output.viewDidAppear()
    }
    
    /// Настраивает таблицу
    private func setupTableView() {
        //registerCells()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

extension MainTabViewController: MainTabViewInput {
    func updateTableView(with model: UniversalTableView.Model) {
        dataSource.model = model
        tableView.reloadData()
        tableView.layoutIfNeeded()
    }
}
