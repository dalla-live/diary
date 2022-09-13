//
//  ResponseData.swift
//  RepositoryTests
//
//  Created by cheonsong on 2022/09/13.
//

import Foundation
import Moya
import SwiftyJSON
import Util

struct ResponseData<Model: Codable> {
    
    /// 원하는 모델타입으로 리턴해주는 함수
    static func processModelResponse(_ result: Result<Response, MoyaError>) -> Result<Model?, Error> {
        switch result {
        case .success(let response):
            do {
                Log.d(JSON(response.data))
                // status code가 200...299인 경우만 success로 체크 (아니면 예외발생)
                _ = try response.filterSuccessfulStatusCodes()
                
                let model = try JSONDecoder().decode(Model.self, from: response.data)
                return .success(model)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            
            return .failure(error)
        }
    }
    
    /// JSON 타입으로 리턴해주는 함수
    static func processJSONResponse(_ result: Result<Response, MoyaError>) -> Result<JSON, Error> {
        switch result {
        case .success(let response):
            do {
                Log.d(JSON(response.data))
                // status code가 200...299인 경우만 success로 체크 (아니면 예외발생)
                _ = try response.filterSuccessfulStatusCodes()
                
                let model = JSON(response.data)
                return .success(model)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            
            return .failure(error)
        }
    }
}
