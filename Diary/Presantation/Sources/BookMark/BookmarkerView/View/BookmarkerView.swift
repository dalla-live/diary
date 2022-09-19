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
        $0.image = UIImage(systemName: "checkmark")
        $0.backgroundColor = .black
        $0.tintColor = .white
    }
        
    override func addComponent() {
        fileName = #file.fileName
        [imageView].forEach(addSubview)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func bind() {
        imageView.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in self.removeFromSuperview() }
            .disposed(by: disposeBag)
    }
    
    override func moreAction() {
//        <#code#>
    }
    
    override func deinitAction() {
//        <#code#>
    }
}
