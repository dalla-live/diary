//
//  PlaceRepository.swift
//  Repository
//
//  Created by John Park on 2022/09/25.
//

import Foundation
import Domain

public final class PlaceRepository : PlaceRepositoryProtocol {
    
    public init() {}
    
    public func fetchList() {
        
    }
    
    public func requestAddress(request: Location, completion: @escaping (Result<String, Error>) -> Void) {
        PlaceAPI.requestAddress(request: NaverPlaceRequestDTO(lat: request.lat, lng: request.lon), completion: { (result) in
            completion(result)
        })
    }

}
