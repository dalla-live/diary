//
//  TranslationAPI.swift
//  RepositoryTests
//
//  Created by cheonsong on 2022/09/13.
//

import Foundation
import Moya
import SwiftyJSON

public struct TranslationAPI: Networkable {
    // Networkable 프로토콜에서 MoyaTarget을 기반으로 MoyaProvider를 생성합니다
    // Target 을 지정해줘야 합니다
    typealias Target = TranslationTargetType
    
    public static func requestTraslation(request: TranslationDTO, completion: @escaping (Result<String,Error>) -> Void) {
        // JSON형태로 디코딩
        makeProvider().request(.requestTranslation(request)) { (result) in
            switch ResponseData<JSON>.processJSONResponse(result) {
            case .success(let model):
                return completion(.success(model["message"]["result"]["translatedText"].stringValue))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}
