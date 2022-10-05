//
//  RequestVideoSubtitleUseCase.swift
//  Domain
//
//  Created by inforex on 2022/10/04.
//

import Foundation
import SwiftyJSON

public protocol RequestVideoSubtitleUseCase {
    func execute(request: URL,
                 completion: @escaping (Result<JSON,Error>)-> Void)
}

public final class RequestVideoSubtitleService: RequestVideoSubtitleUseCase {
    private let videoSubtitleRepository: VideoSubtitleRepositoryProtocol
    
    public init(videoSubtitleRepository: VideoSubtitleRepositoryProtocol){
        self.videoSubtitleRepository = videoSubtitleRepository
    }
    
    public func execute(request: URL, completion: @escaping (Result<JSON, Error>) -> Void) {
        videoSubtitleRepository.requestVideoSubtitle(request: request) { (result) in
            completion(result)
        }
    }
}
