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
        contentView.addSubview(emotionLabel)
    }
    
    func setConstraints() {
        emotionLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func bind() {
//        <#code#>
    }
    
    
    
    
}
