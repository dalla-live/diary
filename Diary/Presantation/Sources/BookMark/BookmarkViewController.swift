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
            $0.size.equalTo(300)
        }
    }
}
