//
//  Service.swift
//  ProjectDescriptionHelpers
//
//  Created by cheonsong on 2022/09/06.
//

import Foundation

public class ServiceTest {
    
    var translator = MLKitTranslator.shared
    public init() {
        print("ServiceTest Success")
        
        translator.set(source: .korean, target: .english)
        translator.translate(source: "안녕하세요", completion: { text, error in
            print("번역 완료!! ---> \(text!)")
        })
    }
}
