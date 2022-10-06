//
//  TranslationDTO.swift
//  RepositoryTests
//
//  Created by cheonsong on 2022/09/13.
//

import Foundation

public struct TranslationDTO: Codable {
    var text: String
    // 원본 언어의 언어코드
    var source: String
    // 타겟 언어의 언어코드
    var target: String
    
    public init(text: String, source: String, target: String) {
        self.text = text
        self.source = source
        self.target = target
    }
}
