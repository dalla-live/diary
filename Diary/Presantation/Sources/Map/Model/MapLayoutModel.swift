//
//  MapLayoutModel.swift
//  Presantation
//
//  Created by inforex_imac on 2022/09/15.
//

import UIKit
import Then
struct MapLayoutModel {
    let _MAP_CONTAINER            = UIView(frame: .zero).then{
        $0.backgroundColor = .clear
    }
    
    let _BUTTON_CONTAINER            = UIView(frame: .zero).then{
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = false
    }
    
    let _SUBMENU_MAP            = UIView(frame: .zero).then{
        $0.backgroundColor = .magenta
        $0.isUserInteractionEnabled = true
    }
    let _SUBMENU_LIST           = UIView(frame: .zero).then{
        $0.backgroundColor = .red
        $0.isUserInteractionEnabled = true
    }
    let _QUICK_BUTTON           = UIView(frame:.zero).then{
        $0.backgroundColor = .magenta
        $0.isUserInteractionEnabled = true
    }
    let _BOOK_MARK_FLAG         = UIView(frame:.zero).then{
        $0.backgroundColor = .magenta
        $0.isUserInteractionEnabled = true
    }
    let _BOOK_MARK_TOOL_TIP     = UIView(frame:.zero).then{
        $0.backgroundColor = .red
        $0.isUserInteractionEnabled = true
    }
    let _FLOATING_SEARCH_BUTTON = UIView(frame:.zero).then{
        $0.backgroundColor = .magenta
        $0.isUserInteractionEnabled = true
    }
    let _FLOATING_ADD_BUTTON    = UIView(frame:.zero).then{
        $0.backgroundColor = .magenta
        $0.isUserInteractionEnabled = true
    }
    let _FLOATING_EXTEND_BUTTON = UIView(frame:.zero).then{
        $0.backgroundColor = .magenta
        $0.isUserInteractionEnabled = true
    }
    
    
    
    
    
    
}

// 아래 방식도 사용 가능할듯 하다 
//public struct CustomViewContainer<T: UIView> {
//    var frame: CGRect
//    var view : T
//
//    public init(viewType: T.Type) {
//        frame = CGRect(x: 0, y: 0, width: 0, height: 0)
//        view = viewType.init(frame: frame) as T
//    }
//
//    public init(viewType: T.Type, frame: CGRect) {
//        self.frame = frame
//        view = viewType.init(frame: frame) as T
//    }
//}
//
//enum FlotingButton {
//    case search, add, extend
//    var view : CustomViewContainer<UIView> {
//        switch self {
//        case .search:
//            return CustomViewContainer(viewType: UIView.self)
//        case .add:
//            return CustomViewContainer(viewType: UIView.self)
//        case .extend:
//            return CustomViewContainer(viewType: UIView.self)
//        }
//    }
//}

//struct MapView {
//    var _BOOK_MARK_FLAG         = CustomViewContainer(viewType: UIView.self)
//    var _QUICK_BUTTON           = CustomViewContainer(viewType: UIView.self)
//    var _FLOATING_SEARCH_BUTTON = CustomViewContainer(viewType: UIView.self)
//    var _FLOATING_ADD_BUTTON    = CustomViewContainer(viewType: UIView.self)
//    var _FLOATING_EXTEND_BUTTON = CustomViewContainer(viewType: UIView.self)
//}
