//
//  VideoSubtitleRepository.swift
//  Domain
//
//  Created by inforex on 2022/10/04.
//

import Foundation
import SwiftyJSON

public protocol VideoSubtitleRepositoryProtocol {
    func requestVideoSubtitle(request: URL,
                              completion: @escaping(Result<JSON,Error>)-> Void)
}
