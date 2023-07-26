//
//  UIControl+AddHandler.swift
//  flowerz
//
//  Created by Кузнецов Олег on 10.07.2023.
//

import UIKit

private var controlHandlerKey: Int8 = 0

// MARK: - UIControl+AddHandler

public extension UIControl {
    
    /// Добавляет обработчик действия при взаимодействии с UIControl
    /// - Parameters:
    ///   - controlEvents: события, на которые среагирует Handler
    ///   - handler: обработчик события
    func addHandler(
        for controlEvents: UIControl.Event,
        handler: @escaping (UIControl) -> Void
    ) {
        if let oldTarget = objc_getAssociatedObject(self, &controlHandlerKey) as? CocoaTarget<UIControl> {
            removeTarget(oldTarget, action: #selector(oldTarget.sendNext), for: controlEvents)
        }

        let target = CocoaTarget<UIControl>(handler)
        objc_setAssociatedObject(self, &controlHandlerKey, target, .OBJC_ASSOCIATION_RETAIN)
        addTarget(target, action: #selector(target.sendNext), for: controlEvents)
    }
}

private final class CocoaTarget<Value>: NSObject {

    private let action: (Value) -> Void

    init(_ action: @escaping (Value) -> Void) {
        self.action = action
    }

    @objc
    internal func sendNext(_ receiver: Any) {
        action(receiver as! Value) // swiftlint:disable:this force_cast
    }
}
