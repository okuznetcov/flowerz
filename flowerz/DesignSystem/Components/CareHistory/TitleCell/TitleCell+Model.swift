//
//  TitleCell+Model.swift
//  flowerz
//
//  Created by Кузнецов Олег on 18.07.2023.
//

import Foundation

import UIKit

extension CareHistory.TitleCell {
    
    /// Модель карточки истории ухода за цветами
    public struct Model {
        /// Заголовок
        let title: String?
        /// Подзаголовок
        let subtitle: String?
    }
}
