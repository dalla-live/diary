//
//  DiaryViewController.swift
//  Presantation
//
//  Created by ejsong on 2022/09/15.
//

import Foundation
import UIKit
import Then

class DiaryViewController : UIViewController {
    
    var text = UILabel().then {
        $0.text = "일기 수정 / 삭제 / 추가"
        $0.textColor = .black
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(text)
        
        text.snp.makeConstraints{
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    deinit{
        print("DiaryViewController deinit")
    }
}
