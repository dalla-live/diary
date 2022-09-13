//
//  BaseTargetType.swift
//  RepositoryTests
//
//  Created by cheonsong on 2022/09/13.
//
import Foundation
import Moya

protocol BaseTargetType: TargetType {
}

extension BaseTargetType {
    
    // HTTP header
    //  return ["Content-type": "application/json"]
    public var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
    // 테스트용 Mock Data
    public var sampleData: Data {
        return Data()
    }
    
//    public var authorizationType: AuthorizationType? {
//        return .bearer
//    }
}

