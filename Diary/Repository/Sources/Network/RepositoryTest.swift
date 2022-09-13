//
//  RepositoryTest.swift
//  RepositoryTests
//
//  Created by cheonsong on 2022/09/13.
//

import Foundation
import Util

public class RepositoryTest {
    public init() {
        let translationDTO = TranslationDTO(text: "안녕하세요", source: Papago.Code.ko.rawValue, target: Papago.Code.en.rawValue)
        TranslationAPI.requestTraslation(request: translationDTO, completion: { (response, error) in
            guard let response = response else {
                Log.d(error?.localizedDescription)
                return
            }
            Log.d(response)
        })
    }
}
