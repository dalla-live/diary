//
//  LanguagePickerView.swift
//  Util
//
//  Created by cheonsong on 2022/09/26.
//

import Foundation
import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

public class LocalizePickerView: UIView {
    
    let disposeBag = DisposeBag()
    
    public let pickerView = UIPickerView().then {
        $0.backgroundColor = .white
        $0.isUserInteractionEnabled = true
    }
    
    // 현재 언어
    var selected: LaguageCode = .ko
    
    // 언어팩 데이터
    let languageData = LaguageCode.allCases
    
    let buttonContainer = UIView().then {
        $0.backgroundColor = .white
    }
    
    let doneButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("okBtn".localized, for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let cancelButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("cancelBtn".localized, for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        pickerView.delegate = self
        pickerView.dataSource = self
    
        self.addSubview(pickerView)
        self.addSubview(buttonContainer)
        buttonContainer.addSubview(doneButton)
        buttonContainer.addSubview(cancelButton)
        
        pickerView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        buttonContainer.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(pickerView.snp.top)
            $0.height.equalTo(50)
        }
        
        doneButton.snp.makeConstraints {
            $0.right.top.bottom.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        cancelButton.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        doneButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                Localize.setCurrentLanguage(self.selected)
                self.removeFromSuperview()
            })
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                self.removeFromSuperview()
            })
            .disposed(by: disposeBag)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension LocalizePickerView: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = languageData[row]
    }
}

extension LocalizePickerView: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languageData.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languageData[row].text
    }
}
