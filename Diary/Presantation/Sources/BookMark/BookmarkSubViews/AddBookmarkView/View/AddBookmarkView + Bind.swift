//
//  AddBookmarkView + Bind.swift
//  Presantation
//
//  Created by chuchu on 2022/09/20.
//

import Foundation

extension AddBookmarkView {
    func rxTapActions() {
        backgroundView.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in removeFromSuperview() }
            .disposed(by: disposeBag)
        
        storeButton.rx.tap
            .bind { print("저장") }
            .disposed(by: disposeBag)
        
        reviseLocationButton.rx.tap
            .bind { [unowned self] in self.isHidden = true }
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .bind { [unowned self] in
                print("취소 \(date.string(from: Date()))")
                // 오류 있을 때 Shake And Show Toast
                contentView.shakeAnimation() {
                    self.makeToast("오류가 있습니다!")
                }
            }
            .disposed(by: disposeBag)
    }
}
