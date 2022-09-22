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
            .bind { [unowned self] in handlingBookmarker($0) }
            .disposed(by: disposeBag)
        
        testScrollView()
        
    }
    
    private func testScrollView() {
        let testScrollView = UIScrollView().then {
            $0.backgroundColor = .black
        }
        
        let testStackView = UIStackView().then {
            $0.spacing = 10
        }
        
        view.addSubview(testScrollView)
        testScrollView.addSubview(testStackView)
        
        testScrollView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(200)
            $0.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(36)
            $0.width.equalTo(100)
        }
        
        testStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        
        (1...6).forEach { _ in
            let emoticonView = EmoticonView()
            emoticonView.backgroundColor = .cyan
            testStackView.addArrangedSubview(emoticonView)
            emoticonView.snp.makeConstraints {
                $0.width.equalTo(34)
            }
        }
        
    }
    
    private func handlingBookmarker(_ sender: UIPanGestureRecognizer) {
        guard let bookmarkerView = sender.view else { return }
        let location = sender.location(in: view)
        switch sender.state {
        case .began:
            bookmarkerView.snp.remakeConstraints {
                $0.center.equalTo(location)
                $0.width.equalTo(30)
                $0.height.equalTo(50)
            }
            
        case .changed:
            bookmarkerView.snp.updateConstraints {
                $0.center.equalTo(location)
            }
            
        case .ended:
            print("panGesture ended")
            let addBookmarkViewList = view.subviews.filter { $0 is AddBookmarkView }.map { $0 as! AddBookmarkView }
            
            addBookmarkViewList.isEmpty ? makeAddBookmarkView() : updateBookmarkLocation(addBookmarkViewList.first!)
        case _: break
        }
    }
    
    private func makeAddBookmarkView() {
        let addBookmarkView = AddBookmarkView()
        
        view.addSubview(addBookmarkView)
        
        addBookmarkView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func updateBookmarkLocation(_ bookmarkView: AddBookmarkView) {
        print(bookmarkView.roadNameLabel.text)
        print("업데이트하는 함수 구현")
    }
}
