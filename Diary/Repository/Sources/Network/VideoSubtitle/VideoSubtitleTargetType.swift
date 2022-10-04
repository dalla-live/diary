//
//  VideoSubtitleTargetType.swift
//  Repository
//
//  Created by inforex on 2022/10/04.
//

import Foundation
import Moya

public enum VideoSubtitleTargetType {
    case requestVideoSubtitle(VideoSubtitleDTO)
}

extension VideoSubtitleTargetType: BaseTargetType {
    
    // API 서버의 baseURL
    // EX) return api.dallalive.com
    public var baseURL: URL {
        return URL(string: NetworkURL.videoSubtitleUrl)!
    }
    
    // 서버의 base URL 뒤에 추가 될 Path (일반적으로 API)
    // EX) case .broadcast(_) return "/brodcast"
    public var path: String {
        switch self {
        case .requestVideoSubtitle(_):
            return "/recognizer/upload"
        }
    }
    
    // HTTP 메소드 (ex. .get / .post / .delete 등등)
    // EX) case .broadcast: return .get
    public var method: Moya.Method {
        switch self {
        case .requestVideoSubtitle(_):
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
    public var task: Moya.Task {
        switch self {
        case .requestVideoSubtitle(let request):
            // 파라미터를 딕셔너리형태로 만들어서 넣어도 되고
            // Encodable DTO를 만들어서 넣어도 됩니다
            let media = MultipartFormData(provider: .file(request.media), name: "media")
            
            let paramsDict = request.params.toDictionary
            let paramsData = try? JSONSerialization.data(withJSONObject: paramsDict as Any)
            let params = MultipartFormData(provider: .data(paramsData!), name: "params")

            return .uploadMultipart([media, params])
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .requestVideoSubtitle(_):
            return ["Content-Type": "multipart/form-data",
                    "X-CLOVASPEECH-API-KEY": "e557951cbc4048ddb126a5a0fa44aaf8"]
        }
        
    }
    
    
}
