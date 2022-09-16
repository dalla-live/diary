//
//  LocalAPI.swift
//  RepositoryTests
//
//  Created by cheonsong on 2022/09/16.
//

import Foundation
import Moya
import SwiftyJSON

struct LocalAPI: Networkable {
    typealias Target = LocalTargetType
    
    static func requestLocalName(request: LocalDTO, completion: @escaping (Result<String, Error>)-> Void) {
        makeProvider().request(.requestLocalName(request)) { (result) in
            switch ResponseData<JSON>.processJSONResponse(result) {
            case.success(let model):
                return completion(.success(""))
                
            case .failure(let error):
                return completion(.failure(error))
            }
        }
    }
}
