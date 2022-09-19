//
//  BookmarkViewController.swift
//  Presantation
//
//  Created by chuchu on 2022/09/16.
//

import Foundation
import UIKit
import RxSwift

public final class BookmarkViewController: UIViewController {
    weak var coordinator: BookmarkCoordinator?
    
    private var viewModel: BookmarkViewModel!
    
    let disposeBag = DisposeBag()
    
    /// ViewController 의존성 주입을 위한 Create 함수
    public static func create(with viewModel: BookmarkViewModel)-> BookmarkViewController {
        let vc = BookmarkViewController()
        vc.viewModel = viewModel
        
        return vc
    }
    
    public override func viewDidLoad() {
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
