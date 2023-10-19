//
//  EurekaComponents.swift
//  flowerz
//
//  Created by Кузнецов Олег on 31.07.2023.
//

/**
 # Компоненты дизайн-системы для использования в формах Эврики.
 
     Для использования компонентов в целевых экранах / фичах смотри:
    - Components — чистые компоненты дизайн-системы
    - EurekaComponents — компоненты дизайн-системы в обертке для использования в формах Эврики.
    - UniversalTableView.Components — компоненты дизайн-системы в обертке для использования в универсальной таблице.
*/

/// Компоненты дизайн-системы в обертке для использования в формах Эврики.
public enum EurekaComponents { }

public extension EurekaComponents {
    
    // Шоукейс
    enum Banner { } //+
    enum PromoBanner { } //+
    
    // Карточки
    enum History { } // +
    enum ItemSummary { } // +
    
    // Основа
    enum Title { } // +
    enum LabelWithName { } // +
    enum Button { } // +
    enum BadgeGroup { } // +
    enum Label { } // +
    
    // Контролы и инпуты
    enum Input { } // +
    enum ControlsStack { } // +
    
    // Вспомогательное
    enum Separator { } //+
    
    // TODO:
    enum ScrollableCards { } //+ multipleCards? grid (2/3), scrollable progress переработать
    enum CardPicker { } //+ progress переработать
    enum Switch { } // переработать +
    
    // Потом:
    enum TextField { }
    enum CardsGrid { } // может пойдет и ScrollableCards
    enum Image { } // height, title?, subtitle?, shadow?, inContainer потом
    enum TitleImage { } // потом
    enum Video { } // потом
}
