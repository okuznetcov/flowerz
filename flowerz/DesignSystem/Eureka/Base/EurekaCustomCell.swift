//
//  EurekaCustomCell.swift
//  flowerz
//
//  Created by Кузнецов Олег on 31.07.2023.
//

import UIKit
import SnapKit
import Eureka

open class CustomCell<T, Component: UIView>: Cell<T> where T: Equatable {
    
    public var component: Component?
    
    public override func setup() {
        
        super.setup()
        
        guard let component = component else { return }
        
        contentView.addSubview(component)
        component.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        selectionStyle = .none
        backgroundColor = .clear
    }
}
