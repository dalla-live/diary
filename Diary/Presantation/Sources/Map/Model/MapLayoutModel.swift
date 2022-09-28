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
import RxGesture

// 디자인 소스 분리 테스트..
//  맵 뷰컨 레이아웃 부분을 따로 뗀것
// add, hidden, 등의 액션을 여기서 처리해볼것이다
struct MapLayoutModel {
    
    var disposeBag = DisposeBag()
    
    let _MAP_CONTAINER            = UIView(frame: .zero).then{
        $0.backgroundColor = .clear
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
        
//        $0.backgroundColor = .blue
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
    
    let _QUICK_LIST_BUTTON           = UIView(frame:.zero).then{
        $0.backgroundColor = .red
        $0.isUserInteractionEnabled = true
    }
    
    let _QUICK_LIST = UIView(frame: .zero).then{
        $0.backgroundColor = .white
        $0.isUserInteractionEnabled = true
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
    
    func layoutButton(container: UIView) {
        container.addSubview(_SUBMENU_MAP)
        container.addSubview(_SUBMENU_LIST)
        container.addSubview(_QUICK_LIST_BUTTON)
        container.addSubview(_QUICK_LIST)
        container.addSubview(_BOOK_MARK_TOOL_TIP)
        container.addSubview(_FLOATING_SEARCH_BUTTON)
        container.addSubview(_FLOATING_ADD_BUTTON)
        container.addSubview(_FLOATING_EXTEND_BUTTON)
        container.addSubview(_CURRENT_LOCATION_BUTTON)
        
//        _MAP_CONTAINER.addSubview(_MAP_CENTER_MARKER)
        container.addSubview(_MAP_CENTER_MARKER)
    }
    
    func setConstraint(container: UIView){
        
        _SUBMENU_MAP.snp.makeConstraints{
            $0.width.equalTo(50)
            $0.height.equalTo(25)
            $0.top.equalTo(50)
            $0.centerX.equalToSuperview().offset(-25)
        }
        
        _SUBMENU_LIST.snp.makeConstraints{
            $0.width.equalTo(50)
            $0.height.equalTo(25)
            $0.top.equalTo(50)
            $0.centerX.equalToSuperview().offset(25)
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
        
        _QUICK_LIST.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
            $0.left.equalTo(_QUICK_LIST_BUTTON.snp.right)
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
        
        _MAP_CONTAINER.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        _MAP_CENTER_MARKER.snp.makeConstraints{
            $0.width.height.equalTo(150)
            $0.centerY.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setAnimation(toOriginX: CGFloat){
        UIView.animate(withDuration: 0.5, animations: {
            _QUICK_LIST_BUTTON.transform = CGAffineTransform(translationX: toOriginX, y: 0)
            _QUICK_LIST.transform        = CGAffineTransform(translationX: toOriginX, y: 0)
        })
    }
    
}
