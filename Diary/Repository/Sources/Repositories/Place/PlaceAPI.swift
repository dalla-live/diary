//
//  PlaceAPI.swift
//  Repository
//
//  Created by ejsong on 2022/09/29.
//

import Foundation
import SwiftyJSON

struct PlaceAPI : Networkable {
    typealias Target = PlaceTargetType
    
    static func requestAddress(request: NaverPlaceRequestDTO , completion : @escaping (Result<String, Error>) -> Void) {
        
        makeProvider().request(.requestAddress(request)) { (result) in
            
            switch ResponseData<JSON>.processJSONResponse(result) {
            case .success(let model):
                completion(.success("success"))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}
