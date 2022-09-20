//
//  VibrationView.swift
//  UtilTests
//
//  Created by chuchu on 2022/09/19.
//

import Foundation
import UIKit

open class VibrationView: UIView, Vibratable {
    public var vibrator: UINotificationFeedbackGenerator?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupGenerator()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupGenerator() {
        self.vibrator = UINotificationFeedbackGenerator()
        self.vibrator?.prepare()
    }
    
    /// There's a haptic sound on the iPhone.
    /// - Parameter type: Type is kinds of `success`, `warning`And `error`, defualt value is error.
    public func vibrate(_ type: UINotificationFeedbackGenerator.FeedbackType = .error) {
        self.vibrator?.notificationOccurred(type)
    }
    
    /// ShakeAnimation
    /// - Parameters:
    ///   - shouldVibrate: Should it `vibrate`, default value is true
    ///   - completion: The closure to be executed once the call is `complete`, default value is nil.
    public func shakeAnimation(shouldVibrate: Bool = true, completion: (() -> ())? = nil) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.5
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        layer.add(animation, forKey: "shake")
        
        if shouldVibrate {
            self.vibrate()
        }
        
        completion?()
    }
}
