//
//  PlaceTargetType.swift
//  Repository
//
//  Created by ejsong on 2022/09/29.
//

import Foundation
import Moya

public enum PlaceTargetType {
    case requestAddress(NaverPlaceRequestDTO)
}

extension PlaceTargetType : BaseTargetType {
    public var baseURL: URL {
        return URL(string: NetworkURL.naverGeoCodingUrl)!
    }
    
    public var path: String {
        switch self {
        case.requestAddress(_):
            return "/map-reversegeocode/v2/gc"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .requestAddress(_):
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .requestAddress(let model):
            return .requestParameters(parameters: ["coords" : "\(model.lng),\(model.lat)",
                                                   "orders" : "roadaddr",
                                                   "output": "json"],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .requestAddress(_):
            return ["Content-type": "application/json",
                    "X-NCP-APIGW-API-KEY-ID" : AppKey.naverMapClientID,
                    "X-NCP-APIGW-API-KEY" : AppKey.naverMapSecret]
        }
    }
}





public struct NaverPlaceRequestDTO : Codable {
    var lat : Double //위도
    var lng : Double //경도
}
