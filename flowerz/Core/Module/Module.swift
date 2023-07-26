//
//  Module.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import UIKit

/// Модуль приложения. От него необходимо унаследоваться, чтобы создать новый
open class Module<Input, Output>: BaseModule {

    // MARK: - Public propeties
    
    /// `ViewController` модуля — то что координатор будет отображать
    public let view: UIViewController
    /// Вход модуля — как правило поступает на вход из координатора
    public let input: Input
    /// Выход модуля — то что возвращается обратно в координатор
    public let output: Output

    // MARK: - Init
    
    /// Модуль приложения. От него необходимо унаследоваться, чтобы создать новый
    /// - Parameters:
    ///   - view: `ViewController` модуля — то что координатор будет отображать
    ///   - input: Вход модуля — как правило поступает на вход из координатора
    ///   - output: Выход модуля — то что возвращается обратно в координатор
    public init(
        view: UIViewController,
        input: Input,
        output: Output
    ) {
        self.view = view
        self.input = input
        self.output = output
    }
}
