//
//  Int+.swift
//  Util
//
//  Created by chuchu on 2022/10/06.
//

import Foundation

extension Int {
    public var withComma: String {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.groupingSeparator = ","
        decimalFormatter.groupingSize = 3
        
        guard let reulst = decimalFormatter.string(from: NSNumber(value: self)) else { return ""}
        return reulst
    }
}
