//
//  Extensions.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 27/04/2025.
//

import Foundation
import UIKit

extension UIView {
    func shake(duration: CFTimeInterval = 0.6) {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        shakeAnimation.duration = duration
        shakeAnimation.values = [-10, 10, -8, 8, -5, 5, 0]
        self.layer.add(shakeAnimation, forKey: "shake")
    }
}
