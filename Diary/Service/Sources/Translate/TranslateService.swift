//
//  TranslateService.swift
//  Service
//
//  Created by cheonsong on 2022/10/06.
//

import Foundation
import Util

protocol Translatable {
    var source: LaguageCode { get }
    var target: LaguageCode { get }
    
    func set(source: LaguageCode, target: LaguageCode)
    func translate(text: String, _ completion: @escaping ((String)-> Void)) 
}
