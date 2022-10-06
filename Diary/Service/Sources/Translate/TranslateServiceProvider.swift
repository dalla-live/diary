//
//  TranslateServiceProvider.swift
//  Service
//
//  Created by cheonsong on 2022/10/06.
//

import Foundation

class TranslateServiceProvider {
    
    public var service: Translatable
    
    init(service: Translatable) {
        self.service = service
    }
    
    /// 소스언어, 타겟언어 설정 Default ko -> en
    public func set(source: LaguageCode, target: LaguageCode) {
        service.set(source: source, target: target)
    }
    
    func translate(text: String, _ completion: @escaping ((String)-> Void))  {
        return service.translate(text: text, completion)
    }
}
