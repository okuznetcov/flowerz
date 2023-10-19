//
//  BaseInput+State.swift
//  flowerz
//
//  Created by Кузнецов Олег on 03.08.2023.
//

import UIKit

/**
 
 # Components.BaseInput + State
 Обычно поле ввода проходит путь по 4 статусам в процессе пользовательского взаимодействия:
 
 1. **empty**
 _Не редактируется. Поле пустое. Не является firstResponder._
 Экран только отрисовался, пользователь увидел поле. Еще не начал на него тыкать.
 
 2. **editingEmpty**
 _Редактируется. Поле ввода пусто. Является firstResponder._
 Пользователь тыкнул на поле, но не ввел ни одного символа. Показываем ему цветом что поле было выбрано,
 а также отображаем плейсхолдер на месте текста, который в будущем будет введен.
 
 3. **editing**
 _Редактируется. Уже содержит текст. Является firstResponder._
 Пользователь ввел хотя-бы один символ в поле. С тех пор плейсхолдер ему больше не нужен, если бы он был,
 он бы перекрывал введенный текст. Подсветка поля продолжает жить, а также появляется кнопка отчистки справа.
 
 4. **filled**
 _Не редактируется. Содержит текст. Не является firstResponder._
 Пользователь закончил ввод. Фокус сместился куда-то еще, подстветка выключена. Заголовок поля остается остается маленьким,
 т. к. теперь главное — то что было введено в поле. Кнопка отчистки тоже скрыта.
 
 
 # User Flow:
 Первый ввод:
 **empty** -> **editingEmpty** -> **editing** -> **filled**
 
 Редактирование:
 **filled** -> **editing** -> **filled**
 
 Очистка и ввод заново:
 **filled** -> **empty** -> **editingEmpty** -> **editing** -> **filled**
 
*/

extension Components.BaseInput {
    
    /// Состояние инпута
    enum State {
        
        /// Не редактируется. Поле пустое. Не является firstResponder.
        case empty
        /// Редактируется. Уже содержит текст. Является firstResponder.
        case editing
        /// Редактируется. Поле ввода пусто. Является firstResponder.
        case editingEmpty
        /// Не редактируется. Содержит текст. Не является firstResponder.
        case filled
        
        /// Константы
        private enum Consts {
            
            /// Заголовок поля
            enum Title {
                
                /// Шрифты заголовка поля
                enum Fonts {
                    
                    /// Paragraph 12 Regular 0.0
                    static let small: UIFont = Font.get(size: 12, weight: .regular)
                    /// Paragraph 15 Regular 0.0
                    static let big: UIFont = Font.get(size: 15, weight: .regular)
                }
                
                /// Сдвиг заголовка поля
                enum Offset {
                    
                    /// Заголовок поля уезжает вверх
                    static let top: CGFloat = 6
                    /// Заголовок поля находится по центру
                    static let centered: CGFloat = 24
                }
            }
            
            /// Палитра компонента
            enum Colors {
                
                /// Линия под полем ввода
                enum Line {
                    /// Цвет в активном состоянии
                    static let active: UIColor = .link
                    /// Цвет в неактивном состоянии
                    static let inactive: UIColor = .lightGray.lighter(by: 0.1)
                }
            }
        }
        
        /// Возвращает параметры отображения инпута
        /// - Returns: параметры отображения инпута
        func parameters() -> Parameters {
            
            switch self {
                /// Редактируется. Поле ввода пусто. Является firstResponder.
                case .editingEmpty:
                    return .init(
                        titleTopOffset: Consts.Title.Offset.top,    // заголовок поля уезжает вверх
                        titleFont: Consts.Title.Fonts.small,        // заголовок становится маленьким
                        lineColor: Consts.Colors.Line.active,       // линия под полем становится синей
                        helperIsHidden: false,                      // хэлпер в поле отображается (если передан)
                        eraseButtonIsHidden: true                   // кнопка стирания скрыта
                    )
                
                /// Редактируется. Уже содержит текст. Является firstResponder.
                case .editing:
                    return .init(
                        titleTopOffset: Consts.Title.Offset.top,    // заголовок поля уезжает вверх
                        titleFont: Consts.Title.Fonts.small,        // заголовок становится маленьким
                        lineColor: Consts.Colors.Line.active,       // линия под полем становится синей
                        helperIsHidden: true,                       // хэлпер в поле скрывается
                        eraseButtonIsHidden: false                  // кнопка стирания отображается
                    )
                
                /// Не редактируется. Содержит текст. Не является firstResponder.
                case .filled:
                    return .init(
                        titleTopOffset: Consts.Title.Offset.top,    // заголовок поля уезжает вверх
                        titleFont: Consts.Title.Fonts.small,        // заголовок становится маленьким
                        lineColor: Consts.Colors.Line.inactive,     // линия под полем становится серой
                        helperIsHidden: true,                       // хэлпер в поле скрывается
                        eraseButtonIsHidden: true                   // кнопка стирания скрыта
                    )
                
                /// Не редактируется. Поле пустое. Не является firstResponder.
                case .empty:
                    return .init(
                        titleTopOffset: Consts.Title.Offset.centered,  // заголовок находится по центру
                        titleFont: Consts.Title.Fonts.big,             // заголовок становится большим
                        lineColor: Consts.Colors.Line.inactive,        // линия под полем становится серой
                        helperIsHidden: true,                          // хэлпер в поле скрывается
                        eraseButtonIsHidden: true                      // кнопка стирания скрыта
                    )
            }
        }
        
        /// Модель параметров отображения инпута
        struct Parameters {
            
            /// Расстония заголовка поля от верхнего края вью
            let titleTopOffset: CGFloat
            /// Шрифт заголовка поля
            let titleFont: UIFont
            /// Цвет линии под полем ввода
            let lineColor: UIColor
            /// Флаг, отображать ли хэлпер (если передан)
            let helperIsHidden: Bool
            /// Флаг, отображать ли кнопку стирания
            let eraseButtonIsHidden: Bool
        }
    }
}
