//
//  TranslationTargetType.swift
//  RepositoryTests
//
//  Created by cheonsong on 2022/09/13.
//

import Foundation
import Moya

//🔎 참고: https://github.com/Moya/Moya/blob/master/docs/Targets.md

public enum TranslationTargetType {
    case requestTranslation(TranslationDTO) // 번역 요청
}

extension TranslationTargetType: BaseTargetType {
    
    // API 서버의 baseURL
    // EX) return api.dallalive.com
    public var baseURL: URL {
        return URL(string: NetworkURL.naverUrl)!
    }
    
    // 서버의 base URL 뒤에 추가 될 Path (일반적으로 API)
    // EX) case .broadcast(_) return "/brodcast"
    public var path: String {
        switch self {
        case .requestTranslation(_):
            return "/v1/papago/n2mt"
        }
    }
    
    // HTTP 메소드 (ex. .get / .post / .delete 등등)
    // EX) case .broadcast: return .get
    public var method: Moya.Method {
        switch self {
        case .requestTranslation(_):
            return .post
        }
    }
    
    // request에 사용되는 파라미터 설정
    // plain request : 추가 데이터가 없는 request
    // data request : 데이터가 포함된 requests body
    // parameter request : 인코딩된 매개 변수가 있는 requests body
    // JSONEncodable request : 인코딩 가능한 유형의 requests body
    // upload request
    // EX) case .broadcast: return .plain
    public var task: Task {
        switch self {
        case .requestTranslation(let request):
            // 파라미터를 딕셔너리형태로 만들어서 넣어도 되고
            // Encodable DTO를 만들어서 넣어도 됩니다
            let request: [String: Any] = [
                "source": request.source,
                "target": request.target,
                "text": request.text
            ]
            return .requestParameters(parameters: request, encoding: URLEncoding.queryString)
//            return .requestJSONEncodable(request)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .requestTranslation(let translationDTO):
            return ["Content-Type": "application/x-www-form-urlencoded",
                    "X-Naver-Client-Id": Papago.clientID,
                    "X-Naver-Client-Secret": Papago.clientSecret,
                    "Content-length" : "\(translationDTO.text.count)"]
        }
        
    }
}
