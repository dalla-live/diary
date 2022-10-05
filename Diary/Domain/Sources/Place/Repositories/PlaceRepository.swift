//
//  MapRepository.swift
//  Domain
//
//  Created by inforex_imac on 2022/09/18.
//

import Foundation


public protocol PlaceRepositoryProtocol {
    func fetchList()
    func requestAddress(request: Location , completion : @escaping (Result<String, Error>) -> Void)
}
