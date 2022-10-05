//
//  VideoSubtitle.swift
//  Domain
//
//  Created by inforex on 2022/10/05.
//

import Foundation

public struct SubtitleData: Codable {
    public var result: String
    public var message: String
    public var segments: [Segment]
    
    enum CodingKeys: String, CodingKey{
        case result
        case message
        case segments
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result = try container.decode(String.self, forKey: .result)
        message = try container.decode(String.self, forKey: .message)
        segments = try container.decode([Segment].self, forKey: .segments)
    }
}

public struct Segment: Codable {
    public var start: Int
    public var end: Int
    public var text: String
    
    enum CodingKeys: String, CodingKey{
        case start
        case end
        case text
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        start = try container.decode(Int.self, forKey: .start)
        end = try container.decode(Int.self, forKey: .end)
        text = try container.decode(String.self, forKey: .text)
    }
}
