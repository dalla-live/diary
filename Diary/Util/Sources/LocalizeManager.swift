//
//  Localize.swift
//  Util
//
//  Created by cheonsong on 2022/09/26.
//

import Foundation

struct LocalizeManager {
    
    public static var languageCode: LanguageCode = .ko {
        willSet {
            bundle = Bundle(path: Bundle.main.path(forResource: languageCode.rawValue, ofType: "lproj")!)
        }
    }
    
    public static var bundle = Bundle(path: Bundle.main.path(forResource: languageCode.rawValue, ofType: "lproj")!)
    
}

public enum LanguageCode: String {
    case ko
    case en
    case ja
}
