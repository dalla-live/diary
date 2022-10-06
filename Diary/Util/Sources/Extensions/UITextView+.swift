//
//  UITextView+.swift
//  Util
//
//  Created by chuchu on 2022/09/27.
//

import Foundation
import UIKit
import SnapKit

extension UITextView {
    public func addPlacehoder(text: String, placeholderColor: UIColor? = UIColor(rgb: 102), font: UIFont? = nil) {
        let placeholder = UILabel()
        
        placeholder.tag = 100
        placeholder.text = text
        placeholder.textColor = placeholderColor
        placeholder.font = font ?? self.font
        
        self.addSubview(placeholder)
        
        placeholder.snp.makeConstraints {
            $0.top.equalToSuperview().inset(self.textContainerInset.top)
            $0.leading.equalToSuperview().inset(self.textContainerInset.left + 4)
        }
    }
}
