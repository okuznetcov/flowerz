//
//  ControlsStack+Entity+Block+Model.swift
//  flowerz
//
//  Created by Кузнецов Олег on 03.09.2023.
//

extension Components.ControlsStack.Entity.Block {
    
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
