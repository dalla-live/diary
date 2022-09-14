//
//  LayerProvider.swift
//  Util
//
//  Created by inforex_imac on 2022/09/14.
//

import Foundation
import UIKit


// ********************************************************************
//   레이어 생성시 구현한다
//   여러 형태의 뷰를 올릴때 규격화를 위해서 사용 (보통 coordinator 혹)
//   ex) 풀스크린레이어, 하단에서 올라오는 다이얼로그 레이어 , 중간에 올라오는 다이얼로그 레이어
// ********************************************************************
public protocol LayerProvider : AnyObject {
    func presentFullScreenLayer()
    func presentBottomLayer()
    func presentCenterLayer()
}

extension LayerProvider {
    public func presentBottomLayer() {
        print("하단에서 등장하는 다이얼로그를 생성할때 구현하자")
    }
    
    public func presentCenterLayer() {
        print("중앙에 팝업으로 등장하는 다이얼로그")
    }
}
