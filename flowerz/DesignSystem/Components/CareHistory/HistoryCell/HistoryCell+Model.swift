//
//  HistoryCell+Model.swift
//  flowerz
//
//  Created by Кузнецов Олег on 11.07.2023.
//

import UIKit

// MARK: - CareHistory.Cell + Model

extension CareHistory.HistoryCell {
    
    /// Модель карточки истории ухода за цветами
    public struct Model {
        
        /// Операция по уходу
        public struct Operation {
            
            /// Тип операции
            public enum Kind: Int {
                
                /// Полив
                case watering = 1
                /// Опрыскивание
                case spraying = 2
                /// Пересадка
                case transfering = 3
            }
            
            /// Название операции
            public let name: String
            /// Тип операции
            public let kind: Kind
            /// Количество растений, которых затронула операция
            public let quantity: Int
            /// Использованные штуки в операции
            public let facilities: [String]
            
            /// Операция по уходу
            /// - Parameters:
            ///   - name: Название операции (например, полив)
            ///   - kind: Тип операции (например, .watering)
            ///   - quantity: Количество растений, которых затронула операция (например, 2)
            ///   - facilities: Использованные штуки в операции, например (вода и удобрение)
            public init(name: String, kind: Kind, quantity: Int, facilities: [String]) {
                self.name = name
                self.kind = kind
                self.quantity = quantity
                self.facilities = facilities
            }
        }
        
        /// Заголовок в карточке
        public let title: String
        /// Массив операций в карточке
        public let operations: [Operation]
        /// Полное количество цветов
        public let totalQuantity: Int
        
        /// Модель карточки истории ухода за цветами
        /// - Parameters:
        ///   - title: Заголовок в карточке (например, 1 декабря, 11:17)
        ///   - operations: Массив операций в карточке
        ///   - totalQuantity: Полное количество цветов (например, 13)
        public init(title: String, operations: [Operation], totalQuantity: Int) {
            self.title = title
            self.operations = operations
            self.totalQuantity = totalQuantity
        }
    }
}

extension CareHistory.HistoryCell.Model.Operation.Kind {
    
    /// Режим отображения операции
    public enum Mode {
        /// Светофор
        case traficLight
        /// Бейдж
        case badge
    }
    
    /// Возвращает цвет операции
    /// - Parameter mode: Режим отображения операции
    /// - Returns: цвет UIColor
    public func color(for mode: Mode) -> UIColor {
        typealias Colors = Color.Operation
    
        switch mode {
            case .badge:
                switch self {
                    case .watering:
                        return Colors.Bage.watering
                    case .spraying:
                        return Colors.Bage.spraying
                    case .transfering:
                        return Colors.Bage.transfering
                }
            
            case .traficLight:
                switch self {
                    case .watering:
                        return Colors.TrafficLight.watering
                    case .spraying:
                        return Colors.TrafficLight.spraying
                    case .transfering:
                        return Colors.TrafficLight.transfering
                }
        }
    }
}
