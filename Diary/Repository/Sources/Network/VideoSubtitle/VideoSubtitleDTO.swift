//
//  VideoSubtitleDTO.swift
//  Repository
//
//  Created by inforex on 2022/10/04.
//

import Foundation

public struct VideoSubtitleDTO: Codable {
    // 동영상 파일 로컬 경로
    var media: String
    // 요청 파라미터
    var params: VideoReqInfo
}

public struct VideoReqInfo: Codable {
    // 인식할 언어 // ko-KR, en-US, enko, ja
    var language: String = "enko"
    
    var completion: String = "sync"
}
