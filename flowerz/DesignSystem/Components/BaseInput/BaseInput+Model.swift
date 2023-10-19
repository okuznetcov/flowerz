//
//  BaseInput+Model.swift
//  flowerz
//
//  Created by Кузнецов Олег on 03.08.2023.
//

import UIKit

// MARK: - Components.BaseInput + Model

extension Components.BaseInput {
    
    /// Модель поля ввода
    public struct Model {
        
        /// Заголовок поля ввода (уедет наверх при вводе 1-го символа)
        let title: String
        /// Хэлпер. Будет отображаться до ввода 1-го символа, затем будет скрыт. Необязательно.
        let helper: String?
        /// Тип клавиатуры поля ввода
        let keyboard: UIKeyboardType
    }
}
