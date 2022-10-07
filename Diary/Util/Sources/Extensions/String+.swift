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
    
    public func splitString() -> [String]{
        let splitArr: [String] = self.split(separator: " ").map(String.init)
        
        return splitArr
    }
    
    public var lastSplitString : String {
        self.splitString().last ?? ""
    }
}
