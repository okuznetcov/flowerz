//
//  MainTabPresenter.swift
//  flowerz
//
//  Created by Кузнецов Олег on 10.07.2023.
//

import UIKit

final class MainTabPresenter: MainTabModuleInput & MainTabModuleOutput {
    
    weak var viewInput: MainTabViewInput?
    
    private typealias Components = UniversalTableView.Components
    private typealias Gallery = UniversalTableView.FlowsGallery
    
    var didTapButton: (() -> Void)?
    
    init() {
    }
    
    public func show() {
        let model = UniversalTableView.Model(
            items: Gallery.Onboarding.items
        )
        viewInput?.updateTableView(with: model)
    }
}

extension MainTabPresenter: MainTabViewOutput {
    func didTapOnButton() {
        didTapButton?()
        
        let tag = Gallery.Onboarding.Tags(rawValue: "startButton")
        switch tag {
            case .startButton:
                print("dsf")
            case .none:
                break
        }
    }
    
    func viewDidAppear() {
        show()
    }
}

extension UniversalTableView {
    enum FlowsGallery {}
}

extension UniversalTableView.FlowsGallery {
    private typealias Components = UniversalTableView.Components
    
    enum Onboarding {
        
        enum Tags: String {
            case startButton
        }
        
        static var items: [UniversalTableViewItem] {
            return [
                Components.Title(model: .init(title: "Кнопки", subtitle: "Кнопки в различных стилях")),
                Components.Button(model: .init(text: "1132", textColor: .white, color: .black, size: .medium, style: .rounded, performsHapticFeedback: true), tag: Tags.startButton.rawValue),
                Components.Banner(model: .init(title: "баннер", subTitle: "баннер!", style: .plain), tag: Tags.startButton.rawValue),
            ]
        }
    }
}
