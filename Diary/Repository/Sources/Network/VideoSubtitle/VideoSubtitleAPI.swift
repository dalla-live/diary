//
//  VideoSubtitleAPI.swift
//  Repository
//
//  Created by inforex on 2022/10/04.
//

import Foundation
import Moya
import SwiftyJSON

struct VideoSubtitleAPI: Networkable {
    // Networkable 프로토콜에서 MoyaTarget을 기반으로 MoyaProvider를 생성합니다
    // Target 을 지정해줘야 합니다
    typealias Target = VideoSubtitleTargetType
    
    static func requestVideoSubtitle(request: VideoSubtitleDTO, completion: @escaping (Result<JSON,Error>) -> Void) {
        // JSON형태로 디코딩
        makeProvider().request(.requestVideoSubtitle(request)) { (result) in
            switch ResponseData<JSON>.processJSONResponse(result) {
            case .success(let model):
                return completion(.success(model))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}
