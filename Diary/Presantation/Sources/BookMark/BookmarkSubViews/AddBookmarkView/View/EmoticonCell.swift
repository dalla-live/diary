//
//  EmoticonCell.swift
//  Presantation
//
//  Created by chuchu on 2022/09/20.
//

import Foundation
import UIKit
import SnapKit
import Util
import Then

class EmoticonCell: UICollectionViewCell, Programmaticable {
    static let identifier = description()
    
    var fileName: String = #file.fileName
    
    let emotionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 30)
    }
    
    let selectImage = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark")
        $0.tintColor = .red
        $0.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        addComponent()
        setConstraints()
        bind()
    }
    
    func addComponent() {
        [emotionLabel, selectImage].forEach(contentView.addSubview)
    }
    
    func setConstraints() {
        emotionLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        selectImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-10)
            $0.size.equalTo(20)
        }
    }
    
    func bind() {
//        <#code#>
    }
    
    
    
    
}
