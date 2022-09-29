//
//  AddBookmarkView + Const.swift
//  Presantation
//
//  Created by chuchu on 2022/09/19.
//

import Foundation
import UIKit

extension AddBookmarkView {
    struct Const {
        
        enum Custom {
            case background
            case line
            case cancle
            case store
            
            var color: UIColor? {
                switch self {
                case .background, .line: return UIColor(white: 0.4, alpha: 0.5)
                case .cancle: return .red
                case .store: return .blue
                }
            }
        }
        
        enum ToBeLocalized {
            case addBookmark
            case note
            case weather
            case mood
            case loadNameExample
            
            // ButtonTitle
            case cancel
            case store
            
            var text: String {
                switch self {
                case .addBookmark: return "북마크 추가하기"
                case .note: return "메모"
                case .weather: return "날씨"
                case .mood: return "기분"
                case .loadNameExample: return "광주 세정아울렛"
                case .cancel: return "취소하기"
                case .store: return "저장하기"
                }
            }
        }
    }
}

enum Weather: CaseIterable {
    case clear        // 맑음
    case rain         // 비
    case clouds       // 구름
    case snow         // 눈
    case atmosphere   // 안개
    case thunderstorm // 폭풍
    case drizzle      // 이슬비
    
    var text: String {
        switch self {
        case .clear: return "맑음"
        case .rain: return "비"
        case .clouds: return "구름"
        case .snow: return "눈"
        case .atmosphere: return "안개"
        case .thunderstorm: return "폭풍"
        case .drizzle: return "이슬비"
        }
    }
    
    var emoticon: String {
        switch self {
        case .clear: return "☀️"
        case .rain: return "🌧"
        case .clouds: return "☁️"
        case .snow: return "❄️"
        case .atmosphere: return "🌫"
        case .thunderstorm: return "🌪"
        case .drizzle: return "☔️"
        }
    }
}
