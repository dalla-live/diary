//
//  Extension+UIColor.swift
//  Calendar
//
//  Created by 인포렉스 on 2022/09/14.
//

import Foundation
import UIKit

extension UIColor {
    public convenience init(rgb: CGFloat, a: CGFloat = 1.0) {
        let rgb = rgb / 255.0
        self.init(red: rgb, green: rgb, blue: rgb, alpha:a)
    }
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        let red = r / 255,
            green = g / 255,
            blue = b / 255
        self.init(red: red, green: green, blue: blue, alpha:a)
    }
}
