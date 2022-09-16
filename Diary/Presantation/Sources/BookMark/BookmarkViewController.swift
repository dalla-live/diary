//
//  BookmarkViewController.swift
//  Presantation
//
//  Created by chuchu on 2022/09/16.
//

import Foundation
import UIKit
import RxSwift

class BookmarkViewController: UIViewController {
    weak var coordinator: BookmarkCoordinator?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bookmarker = BookmarkerView()
        
        self.view.addSubview(bookmarker)
        
        bookmarker.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(30)
            $0.height.equalTo(50)
        }
        
        bookmarker.rx.panGesture()
            .bind { [unowned self] in handlingBookmarker(sender: $0) }
            .disposed(by: disposeBag)
    }
    
    private func handlingBookmarker(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        print(location)
        
    }
}
