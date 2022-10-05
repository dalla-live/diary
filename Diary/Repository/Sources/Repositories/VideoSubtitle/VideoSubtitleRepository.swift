//
//  VideoSubtitleRepository.swift
//  Repository
//
//  Created by inforex on 2022/10/04.
//

import Foundation
import Domain
import SwiftyJSON

public final class VideoSubtitleRepository: VideoSubtitleRepositoryProtocol {
    
    public init() {}
    
    public func requestVideoSubtitle(request: URL, completion: @escaping (Result<JSON, Error>) -> Void) {
        
        VideoSubtitleAPI.requestVideoSubtitle(request: VideoSubtitleDTO(media: request, params: VideoReqInfo()), completion: { (result) in
            completion(result)
        })
    }
}
