//
//  NavigationCoordinator.swift
//  flowerz
//
//  Created by Кузнецов Олег on 10.07.2023.
//

import Swinject

/// Основной координатор для флоу.
/// Поддерживает переход с помощью Transition.
/// Содержит собственный NavigationController и инициализирует его если это необходимо
open class NavigationCoordinator<ResultType>: Coordinator<ResultType> {
    
    // MARK: Nested Types
    
    /// Виды переходов в координатор
    enum Transition {
        
        /// Открывает флоу внутри текущего NavigationController — слайд вправо
        /// - Parameters:
        /// - navigation: NavigationController в котором будет открыт новый флоу
        /// - hideTabBar: Скрывать ли таббар при открытии флоу
        case push(navigation: UINavigationController, hideTabBar: Bool)
        
        /// Открывает флоу в всплывающем экране, который можно смахнуть жестом вниз.
        /// Создает новый child-NavigationController.
        /// - Parameter source: ViewController c которого будет осущетсвлен переход
        case popOver(source: UIViewController)
        
        /// Открывает флоу выезжающем снизу экране, который полностью перекрывает предыдущий.
        /// Нельзя закрыть смахиванием. Создает новый child-NavigationController.
        /// - Parameter source: ViewController c которого будет осущетсвлен переход
        case slideFromBottomToFullScreen(source: UIViewController)
    }
    
    /// Упрощенные переходы в координатор
    enum SimpleTransition {
        
        /// Открывает флоу внутри текущего NavigationController — слайд вправо
        /// - Parameter hideTabBar: Скрывать ли таббар при открытии флоу
        case push(hideTabBar: Bool)
        
        /// Открывает флоу в всплывающем экране, который можно смахнуть жестом вниз.
        case popOver
        
        /// Открывает флоу выезжающем снизу экране, который полностью перекрывает предыдущий.
        case slideFromBottomToFullScreen
    }
    
    // MARK: - Private properties
    
    /// NavigationController для переходов popOver и slideFromBottomToFullScreen
    private lazy var navigationController = UINavigationController()
    
    /// Тип перехода в координатор
    private let transition: Transition
    
    // MARK: - Init
    
    /// Создает координатор с указанием родительского координатора с которого произойдет переход
    /// - Parameters:
    ///   - tabCoordinator: Родительский координатор с которого произойдет переход
    ///   - transition: Переход
    convenience init?(from tabCoordinator: TabBarItemCoordinator, transition: SimpleTransition) {
        switch transition {
            case .popOver:
                guard let rootViewController = tabCoordinator.navigation?.topViewController else { return nil }
                self.init(transition: .popOver(source: rootViewController))
            
            case .push(let hideTabBar):
                self.init(transition: .push(navigation: tabCoordinator.navigation!, hideTabBar: hideTabBar))
            
            case .slideFromBottomToFullScreen:
            guard let rootViewController = tabCoordinator.navigation?.topViewController else { return nil }
                self.init(transition: .slideFromBottomToFullScreen(source: rootViewController))
        }
    }
    
    /// Создает координатор с указанием перехода
    /// - Parameter transition: Переход
    init(transition: Transition) {
        self.transition = transition
        super.init()
    }

    // MARK: - Public methods
    
    /// Выполняет переход на ViewController согласно настроенному переходу
    /// - Parameter view: ViewController, на который необходимо выполнить переход
    func show(view: UIViewController) {
        switch transition {
            
            case .push(let navigation, let hideTabBar):
                view.hidesBottomBarWhenPushed = hideTabBar
                navigation.pushViewController(view, animated: true)
            
            case .popOver(let source):
                navigationController.setViewControllers([view], animated: true)
                navigationController.modalPresentationStyle = .popover
                navigationController.popoverPresentationController?.sourceView = source.view
                source.present(navigationController, animated: true, completion: nil)
            
            case .slideFromBottomToFullScreen(let source):
                navigationController.setViewControllers([view], animated: true)
                navigationController.modalPresentationStyle = .overFullScreen
                navigationController.popoverPresentationController?.sourceView = source.view
                source.present(navigationController, animated: true, completion: nil)
        }
    }
}
