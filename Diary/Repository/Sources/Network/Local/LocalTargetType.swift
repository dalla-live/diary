//
//  LocationTargetType.swift
//  RepositoryTests
//
//  Created by cheonsong on 2022/09/16.
//

import Foundation
import Moya
import Util

//🔎 참고: https://github.com/Moya/Moya/blob/master/docs/Targets.md

public enum LocalTargetType {
    case requestLocalName(LocalDTO) // 지역이름 요청
}

extension LocalTargetType: BaseTargetType {
    public var baseURL: URL {
        return URL(string: NetworkURL.openWeatherMapUrl)!
    }
    
    public var path: String {
        switch self {
        case .requestLocalName(_):
            return "/geo/1.0/reverse"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .requestLocalName(_):
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .requestLocalName(let localDTO):
            let request = localDTO.toDictionary!
            return .requestParameters(parameters: request, encoding: URLEncoding.queryString)
        }
    }
}
