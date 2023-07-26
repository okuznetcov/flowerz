//
//  UIWindow+Extensions.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import Foundation
import UIKit

public extension UIWindow {

    /// Активное окно приложения
    static var activeWindow: UIWindow? {
        let scene = UIApplication.shared.connectedScenes.first {
            $0.activationState == .foregroundActive
        }
        if let window = (scene as? UIWindowScene)?.windows.first {
            return window
        }

        return UIApplication.shared.delegate?.window as? UIWindow
    }
}
