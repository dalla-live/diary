//
//  Extension+UIView.swift
//  Calendar
//
//  Created by 인포렉스 on 2022/09/14.
//

import Foundation
import UIKit


public enum VerticalLocation: String{
    case bottom
    case top
}

extension UIView {
    public func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, blur: CGFloat = 5.0){
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 6), color: color, opacity: opacity, blur: blur)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -6), color: color, opacity: opacity, blur: blur)
        }
    }
    
    public func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, blur: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = blur
    }
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}
