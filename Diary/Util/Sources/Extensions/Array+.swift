//
//  Array+.swift
//  Util
//
//  Created by chuchu on 2022/09/22.
//

import Foundation

extension Array {
    public subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
