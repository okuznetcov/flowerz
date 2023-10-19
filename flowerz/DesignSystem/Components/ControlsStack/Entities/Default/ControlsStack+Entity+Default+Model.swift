//
//  ControlsStack+Control+Model.swift
//  flowerz
//
//  Created by Кузнецов Олег on 01.09.2023.
//

extension Components.ControlsStack.Entity.Default {
    
    /// Модель контрола
    public struct DefaultEntityModel: ControlsStackEntityModel {
        /// Заголовок
        public let title: String
        /// Подзаголовок (необязательно)
        public let subtitle: String?
        /// Тег этого контрола
        public let tag: Tag
    }
}
