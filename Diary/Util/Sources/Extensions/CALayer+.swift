//
//  CALayer+.swift
//  Util
//
//  Created by chuchu on 2022/09/26.
//

import Foundation
import UIKit

extension CALayer {
    public var snapshotImage: UIImage? {
            defer { UIGraphicsEndImageContext() }
            
            UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
            guard let context = UIGraphicsGetCurrentContext() else { return nil }
            self.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
            
    }
}
