//
//  Service.swift
//  ProjectDescriptionHelpers
//
//  Created by cheonsong on 2022/09/06.
//

import Foundation
import Util

public class ServiceTest {
    
    var provider: TranslateServiceProvider
    
    public init() {
        print("ServiceTest Success")
        
        provider = TranslateServiceProvider(service: PapagoTranslator.shared)
        
        provider.translate(text: "안녕하세요") { text in
            Log.d("Papago:: \(text)")
        }
        
        provider = TranslateServiceProvider(service: GoogleTranslator.shared)
        
        provider.translate(text: "안녕하세요") { text in
            Log.d("Google:: \(text)")
        }
        
        provider = TranslateServiceProvider(service: MLKitTranslator.shared)
        
        provider.translate(text: "안녕하세요") { text in
            Log.d("MLKit:: \(text)")
        }
        
    }
}
