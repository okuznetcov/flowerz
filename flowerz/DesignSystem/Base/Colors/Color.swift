//
//  Color.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import UIKit

// MARK: - Color

/// Палитра приложения
public enum Color {
    
    /// Операция (полив / опрыскивание / пересадка)
    public enum Operation {
        
        /// Цвет операции для "светофора"
        public enum TrafficLight {
            
            /// Полив
            public static var watering = #colorLiteral(red: 0, green: 0.6392156863, blue: 1, alpha: 1)
            /// Опрыскивание
            public static var spraying = #colorLiteral(red: 0.9137254902, green: 0.662745098, blue: 0.01960784314, alpha: 1)
            /// Пересадка
            public static var transfering = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }
        
        /// Цвет операции в бейдже с текстом
        public enum Bage {
            
            /// Полив
            public static var watering = #colorLiteral(red: 0, green: 0.6392156863, blue: 1, alpha: 1)
            /// Опрыскивание
            public static var spraying = #colorLiteral(red: 0.9137254902, green: 0.662745098, blue: 0.01960784314, alpha: 1)
            /// Пересадка
            public static var transfering = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        }
    }
    
    public static var textWhite = #colorLiteral(red: 1.00000000000, green: 1.00000000000, blue: 1.00000000000, alpha: 1)
    
    public static var controlInactiveTabBar = dynamicColor(light: #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.7490196078, alpha: 1), dark: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.4189259106))
    
    public static var controlActiveTabBar = dynamicColor(light: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), dark: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    
    public static var background = dynamicColor(light: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), dark: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    
    public static var textPrimary = dynamicColor(light: #colorLiteral(red: 0.1450980392, green: 0.1607843137, blue: 0.1764705882, alpha: 1), dark: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1))
    
    public static var textSecondary = dynamicColor(light: #colorLiteral(red: 0.4039215686, green: 0.4431372549, blue: 0.4901960784, alpha: 1), dark: #colorLiteral(red: 0.6078431373, green: 0.6431372549, blue: 0.6784313725, alpha: 1))
    
    public static var backgroundSecondary = dynamicColor(light: #colorLiteral(red: 0.9411764706, green: 0.9450980392, blue: 0.9607843137, alpha: 1), dark: #colorLiteral(red: 0.3803921569, green: 0.4156862745, blue: 0.4588235294, alpha: 0.25))
}

extension Color {
    
    /// Создает динамический цвет для темной и светлой темы приложения
    /// - Parameters:
    ///   - light: цвет для светлой темы
    ///   - dark: цвет для темной темы
    /// - Returns: UIColor с двумя цветами
    public static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor { traits -> UIColor in
            return traits.userInterfaceStyle == .dark ? dark : light
        }
    }
}
