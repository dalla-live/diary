//
//  MapLayoutModel.swift
//  Presantation
//
//  Created by inforex_imac on 2022/09/15.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

// 디자인 소스 분리 테스트..
//  맵 뷰컨 레이아웃 부분을 따로 뗀것
// add, hidden, 등의 액션을 여기서 처리해볼것이다
struct MapLayoutModel {

    let _MAP_CONTENT_CONTAINER = UIView(frame: .zero).then{
        $0.backgroundColor = .clear
    }
    
    let _MAP_SCROLL_CONTAINER    = UIScrollView(frame: .zero).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    let _CURRENT_LOCATION_BUTTON = UIView(frame: .zero).then{
        let imgView = UIImageView(image: UIImage(systemName: "location.north.fill"))
            imgView.contentMode = .scaleAspectFit
            imgView.tintColor = .white
            $0.addSubview(imgView)
            
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray.cgColor
            
            $0.layer.shadowColor = UIColor.gray.cgColor
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowOffset = .init(width: 0, height: 0)
            $0.backgroundColor = .blue
            $0.isUserInteractionEnabled = true
        
            imgView.snp.makeConstraints{
                $0.edges.equalToSuperview().inset(6)
            }
    }
    
    let _MAP_CENTER_MARKER            = UIView(frame: .zero).then{
        let point = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
            point.layer.cornerRadius = 5
            point.layer.borderColor = UIColor.gray.cgColor
            point.backgroundColor = .red
            $0.addSubview(point)
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 75
            $0.layer.shadowColor = UIColor.lightGray.cgColor
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowOffset = .init(width: 0, height: 0)
            $0.backgroundColor = .blue.withAlphaComponent(0.2)
            
        point.snp.makeConstraints{
            $0.width.height.equalTo(10)
            $0.center.equalToSuperview()
        }
        
        $0.isUserInteractionEnabled = false
    }
    
    let _MAP_CONTAINER            = UIView(frame: .zero).then{
        $0.backgroundColor = .clear
    }
    
    let _NAVER_MAP_CONTAINER        = UIView(frame: .zero).then {
        $0.backgroundColor = .clear
    }

    let _BUTTON_CONTAINER            = UIView(frame: .zero).then{
        $0.backgroundColor = .clear
    }
    
    
    let _SUBMENU_SEGMENT : UISegmentedControl  = {
        var segmentControl = UISegmentedControl(items: ["google".localized, "naver".localized])
        segmentControl.isUserInteractionEnabled = true
        segmentControl.selectedSegmentIndex     = 0
        segmentControl.tintColor                = .black
        segmentControl.backgroundColor          = .clear
        segmentControl.selectedSegmentTintColor = .gray
        return segmentControl
    }()
    
    
    let _QUICK_BUTTON           = UIView(frame:.zero).then{
        $0.backgroundColor = .magenta
    }

    
    let _QUICK_LIST_BUTTON           = UIView(frame:.zero).then{
        let imgView             = UIImageView(image: UIImage(systemName: "arrowtriangle.left.square.fill"))
            imgView.tag         = 12
            imgView.contentMode = .scaleAspectFit
            imgView.tintColor   = .gray
        
        $0.addSubview(imgView)
        $0.backgroundColor = .clear
        
        imgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        $0.isUserInteractionEnabled = true
    }
    
    
    let _QUICK_LIST = UIView(frame: .zero).then{
        $0.layer.backgroundColor = UIColor.white.withAlphaComponent(0).cgColor
        $0.isUserInteractionEnabled = true
    }
    
    
    var _QUICK_LIST_TABLE = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.register(BookmarkCell.self, forCellReuseIdentifier: BookmarkCell.identifier)
    }
    
    
    let _BOOK_MARK_FLAG         = UIView(frame:.zero).then{
        $0.backgroundColor = .magenta
        $0.isUserInteractionEnabled = true
    }
    
    
    let _BOOK_MARK_TOOL_TIP     = UIView(frame: .zero).then{
        $0.backgroundColor = .red
        $0.isUserInteractionEnabled = true
        $0.isHidden = true
    }
    
    
    let _FLOATING_SEARCH_BUTTON = UIView(frame:.zero).then{
        let imgView = UIImageView(image: UIImage(systemName: "magnifyingglass.circle"))
            imgView.contentMode = .scaleAspectFit
            imgView.tintColor = .white
            $0.addSubview(imgView)
            
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray.cgColor
            
            $0.layer.shadowColor = UIColor.gray.cgColor
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowOffset = .init(width: 0, height: 0)
            $0.backgroundColor = .gray
            $0.isUserInteractionEnabled = true
        
            imgView.snp.makeConstraints{
                $0.edges.equalToSuperview().inset(6)
            }
    }
    
    
    let _FLOATING_ADD_BUTTON    = UIView(frame:.zero).then{
        let imgView = UIImageView(image: UIImage(systemName: "plus.bubble"))
            imgView.contentMode = .scaleAspectFit
            imgView.tintColor = .white
            $0.addSubview(imgView)
        
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray.cgColor
        
            $0.layer.shadowColor = UIColor.gray.cgColor
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowOffset = .init(width: 0, height: 0)
            $0.backgroundColor = .gray
            $0.isUserInteractionEnabled = true
        
            imgView.snp.makeConstraints{
                $0.edges.equalToSuperview().inset(6)
            }
    }
    
    
    
    let _FLOATING_EXTEND_BUTTON = UIView(frame:.zero).then{
        let imgView = UIImageView(image: UIImage(systemName: "text.justify"))
            imgView.contentMode = .scaleAspectFit
            imgView.tintColor = .white
            $0.addSubview(imgView)
        
            $0.layer.cornerRadius = 20
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray.cgColor
        
            $0.layer.shadowColor = UIColor.gray.cgColor
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowOffset = .init(width: 0, height: 0)
            $0.backgroundColor = .gray
            $0.isUserInteractionEnabled = true
        
            imgView.snp.makeConstraints{
                $0.edges.equalToSuperview().inset(6)
            }
    }
    
    
    
    let googleLabel = UILabel().then {
        $0.text = "google".localized
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .black
    }
    
    
    
    let naverLabel = UILabel().then {
        $0.text = "naver".localized
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .black
    }
    
    
    
    func viewDidLoad(container: UIView) {
        container.addSubview(_MAP_CONTENT_CONTAINER)
        
        _MAP_CONTENT_CONTAINER.addSubview(_MAP_SCROLL_CONTAINER)
        _MAP_SCROLL_CONTAINER.addSubview(_MAP_CONTAINER)
        _MAP_SCROLL_CONTAINER.addSubview(_NAVER_MAP_CONTAINER)
        
        container.addSubview(_SUBMENU_SEGMENT)
        container.addSubview(_BOOK_MARK_TOOL_TIP)
        container.addSubview(_FLOATING_SEARCH_BUTTON)
        container.addSubview(_FLOATING_ADD_BUTTON)
        container.addSubview(_FLOATING_EXTEND_BUTTON)
        container.addSubview(_CURRENT_LOCATION_BUTTON)
        container.addSubview(_MAP_CENTER_MARKER)
        
        container.addSubview(_QUICK_LIST_BUTTON)
        container.addSubview(_QUICK_LIST)
        _QUICK_LIST.addSubview(_QUICK_LIST_TABLE)
    }
    
    
    func setConstraint(container: UIView){
        
        _MAP_SCROLL_CONTAINER.contentSize = CGSize(width: UIScreen.main.bounds.width * 2, height: UIScreen.main.bounds.height)
        
        _MAP_SCROLL_CONTAINER.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        _MAP_CONTAINER.snp.makeConstraints{
            $0.height.width.equalTo(_MAP_SCROLL_CONTAINER)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        _NAVER_MAP_CONTAINER.snp.makeConstraints{
            $0.height.width.equalTo(_MAP_SCROLL_CONTAINER)
            $0.centerY.equalToSuperview()
            $0.left.equalTo(_MAP_CONTAINER.snp.right)
        }
        
        
        _SUBMENU_SEGMENT.snp.makeConstraints{
            $0.width.equalTo(130)
            $0.height.equalTo(30)
            $0.top.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        
        _BOOK_MARK_TOOL_TIP.snp.makeConstraints{
            $0.width.equalTo(100)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-90)
        }
        
        _QUICK_LIST_BUTTON.snp.makeConstraints{
            $0.width.height.equalTo(50)
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview().dividedBy(2)
        }
        
        _FLOATING_SEARCH_BUTTON.snp.makeConstraints{
            $0.width.height.equalTo(40)
            $0.right.equalToSuperview().offset(-5)
            $0.bottom.equalTo(_FLOATING_ADD_BUTTON.snp.top).offset(-20)
        }
        
        _FLOATING_ADD_BUTTON.snp.makeConstraints{
            $0.width.height.equalTo(40)
            $0.right.equalToSuperview().offset(-5)
            $0.bottom.equalTo(_FLOATING_EXTEND_BUTTON.snp.top).offset(-20)
        }
        
        _FLOATING_EXTEND_BUTTON.snp.makeConstraints{
            $0.width.height.equalTo(40)
            $0.right.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().offset(-100)
        }
        
        _CURRENT_LOCATION_BUTTON.snp.makeConstraints{
            $0.width.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-100)
        }
        
        _MAP_CENTER_MARKER.snp.makeConstraints{
            $0.width.height.equalTo(150)
            $0.centerY.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        
        _QUICK_LIST_TABLE.snp.makeConstraints{
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(2)
        }
        
        _QUICK_LIST.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
            $0.left.equalTo(_QUICK_LIST_BUTTON.snp.right)
            $0.centerY.equalToSuperview()
        }
    }
    
    
    func setTransformAction(toOriginX: CGFloat, state: UIGestureRecognizer.State,  isFirst: inout Bool) {
        switch state {
        case .ended:
            
//            // 열린다면
//            if toOriginX != 0 {
//                isFirst = true
////                _QUICK_LIST_TABLE.visibleCells.enumerated().forEach{ idx, cell  in
////                    UIView.animate(withDuration: 0.3 , delay: Double(idx) * 0.1 , animations: {
////                        cell.transform = .identity
////                    })
////                }
//            } else {
//                isFirst = true
////                _QUICK_LIST_TABLE.visibleCells.enumerated().reversed().forEach{ idx, cell  in
////                    UIView.animate(withDuration: 0.3 , delay: Double(idx) * 0.3 , animations: {
////                        cell.transform = CGAffineTransform(translationX: 100, y: 0)
////                    })
////                }
//            }
//
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn, animations:  {
                _QUICK_LIST_BUTTON.transform = CGAffineTransform(translationX: toOriginX, y: 0)
                _QUICK_LIST.transform        = CGAffineTransform(translationX: toOriginX, y: 0)
            }, completion: { isComplete in
                let imgView = self._QUICK_LIST_BUTTON.viewWithTag(12) as? UIImageView
                let imageName = toOriginX == 0 ? "arrowtriangle.left.square.fill" : "arrowtriangle.right.square.fill"
                
                imgView?.image = UIImage(systemName: imageName)
            })
        default:
            isFirst = false
            
            _QUICK_LIST_BUTTON.transform = CGAffineTransform(translationX: toOriginX, y: 0)
            _QUICK_LIST.transform        = CGAffineTransform(translationX: toOriginX, y: 0)
        }
    }
    
}
