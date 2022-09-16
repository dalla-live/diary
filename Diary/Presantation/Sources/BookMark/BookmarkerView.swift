//
//  Bookmarker.swift
//  Presantation
//
//  Created by chuchu on 2022/09/16.
//

import Foundation
import UIKit
import RxSwift
import Then
import Util

class BookmarkerView: ProgrammaticallyView {
    let imageView = UIImageView().then {
        $0.image = UIImage(named: "checkmark.rectangle")
        $0.backgroundColor = .black
        $0.tintColor = .white
    }
    
    let testLabel = UILabel().then {
        $0.text = "Test 입니다."
        $0.textColor = .white
    }
    
    override func addComponent() {
        [imageView, testLabel].forEach(addSubview)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        testLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func bind() {
        imageView.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in self.removeFromSuperview() }
            .disposed(by: disposeBag)
    }
    
    override func moreAction() {
        
    }
    
    deinit {
        print("deinit Bookmarker")
    }
}
