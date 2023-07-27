//
//  DryPlantsCell+Model.swift
//  flowerz
//
//  Created by Кузнецов Олег on 14.07.2023.
//

import UIKit

// MARK: - ScrollableCardsWithImages.View + Model

/// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой
extension ScrollableCardsWithImages.View {
    
    /// Модель карточек
    public struct Model {
        let cards: [Card.Model]
    }
}
