//
//  UILabel+.swift
//  Util
//
//  Created by chuchu on 2022/09/26.
//

import Foundation
import UIKit

extension UILabel {
    public var currentLineCount: Int {
        guard let text = self.text as NSString?,
              let font = self.font else { return 0 }
        
        var attributes = [NSAttributedString.Key: Any]()
        
        if let kernAttribute = self.attributedText?.attributes(at: 0, effectiveRange: nil).first(where: { key, _ in
            return key == .kern
        }) {
            attributes[.kern] = kernAttribute.value
        }
        attributes[.font] = font
        
        let labelTextSize = text.boundingRect(
            with: CGSize(width: self.bounds.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil
        )
        
        // 총 Height에서 한 줄의 Line Height를 나누면 현재 총 Line 수
        return Int(ceil(labelTextSize.height / font.lineHeight))
    }
    
    public func calculateMaxLines() -> Int {
        guard let font = self.font else { return 0 }
        
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity)),
            charSize = font.lineHeight,
            text = (self.text ?? "") as NSString,
            textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return Int(ceil(textSize.height/charSize))
    }
}

