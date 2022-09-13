//
//  TranslationAPI.swift
//  RepositoryTests
//
//  Created by cheonsong on 2022/09/13.
//

import Foundation
import Moya
import SwiftyJSON

struct TranslationAPI: Networkable {
    // Networkable 프로토콜에서 MoyaTarget을 기반으로 MoyaProvider를 생성합니다
    // Target 을 지정해줘야 합니다
    typealias Target = TranslationTargetType
    
    static func requestTraslation(request: TranslationDTO, completion: @escaping (_ succeed: String?, _ failed: Error?) -> Void) {
        // JSON형태로 디코딩
        makeProvider().request(.requestTranslation(request)) { (result) in
            switch ResponseData<JSON>.processJSONResponse(result) {
            case .success(let model):
                return completion(model["message"]["result"]["translatedText"].string, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
        // 데이터모델로 디코딩
//        makeProvider().request(.requestTranslation(request)) { (result) in
//            switch ResponseData<TranslationModel>.processModelResponse(result) {
//            case .success(let model):
//                return completion(model, nil)
//            case .failure(let error):
//                return completion(nil, error)
//            }
//        }
    }
}
