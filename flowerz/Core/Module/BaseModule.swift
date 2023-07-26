//
//  BaseModule.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import UIKit

/// Протокол модуля приложения
public protocol BaseModule: AnyObject {

    /// Вход модуля
    associatedtype Input
    /// Выход модуля
    associatedtype Output
    /// `ViewController` модуля
    var view: UIViewController { get }
    /// Input модуля — как правило поступает на вход из координатора
    var input: Input { get }
    /// Output модуля — то что возвращается обратно в координатор
    var output: Output { get }
}
