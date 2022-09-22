//
//  EmoticonView.swift
//  Presantation
//
//  Created by chuchu on 2022/09/22.
//

import Foundation
import UIKit
import Util
import RxSwift
import Then
import SnapKit

class EmoticonView: ProgrammaticallyView {
    
    let emotionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 30)
    }
    
    let selectImage = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark")
        $0.tintColor = .red
        $0.isHidden = true
    }
    
    
    override func addComponent() {
        fileName = #file.fileName
        [emotionLabel, selectImage].forEach(addSubview)
    }
    
    override func setConstraints() {
        emotionLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        selectImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-10)
            $0.size.equalTo(20)
        }
    }
    
    override func bind() { }
}
