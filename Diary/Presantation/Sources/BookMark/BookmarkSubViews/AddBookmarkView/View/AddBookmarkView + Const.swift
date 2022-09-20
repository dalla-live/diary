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
            case location
            case weather
            case mood
            case loadNameExample
            
            // ButtonTitle
            case cancel
            case store
            
            var text: String {
                switch self {
                case .addBookmark: return "북마크 추가하기"
                case .location: return "위치"
                case .weather: return "날씨"
                case .mood: return "기분이 조크등요"
                case .loadNameExample: return "광주 세정아울렛"
                case .cancel: return "취소하기"
                case .store: return "저장하기"
                }
            }
        }
    }
}
