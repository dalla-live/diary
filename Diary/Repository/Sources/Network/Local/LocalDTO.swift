//
//  LocalDTO.swift
//  RepositoryTests
//
//  Created by cheonsong on 2022/09/16.
//

import Foundation

public struct LocalDTO: Codable {
    var lat: Double
    var lon: Double
    var limit: Int
    var appID: String = "7a30119259b375a62188ecebaf47d51b"
}
