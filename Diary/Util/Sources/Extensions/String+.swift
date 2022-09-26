//
//  String+.swift
//  UtilTests
//
//  Created by chuchu on 2022/09/16.
//

import Foundation

extension String {
    public var fileName: String {
        self.components(separatedBy: "/").last ?? ""
    }
    
    public var localized: String {
        return LocalizeManager.bundle?.localizedString(forKey: self, value: nil, table: nil) ?? self
//        return NSLocalizedString(self, comment: "")
    }
    
    /// Format이 있는 로컬라이징 함수 Ex) "My Age %d"
    /// - Parameter arguments: [CVarArg] format에 들어갈 Value값들
    /// $d - Int, %f - Float, %ld - Long, %@ - String
    public func localized(_ arguments: CVarArg = [])-> String {
        return String(format: self.localized, arguments)
    }
}
