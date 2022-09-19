//
//  Vibratable.swift
//  Presantation
//
//  Created by chuchu on 2022/09/19.
//

import Foundation
import UIKit

public protocol Vibratable {
    var vibrator: UINotificationFeedbackGenerator? { get set }
    func setupGenerator()
    func vibration()
    func shakeAnimation(shouldVibrate: Bool, completion: (() -> ())?)
}

extension Vibratable {
    func shakeAnimation(shouldVibrate: Bool, completion: (() -> ())?) { }
}
