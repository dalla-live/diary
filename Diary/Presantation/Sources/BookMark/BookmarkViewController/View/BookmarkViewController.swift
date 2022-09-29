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
    var coordinator: BookmarkCoordinator?
    
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
        let bookmarker = BookmarkerView(),
            bookmarkList = BookmarkListView().then {
                $0.isHidden = false
            }
        
        self.view.addSubview(bookmarker)
        self.view.addSubview(bookmarkList)
        bookmarker.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(30)
            $0.height.equalTo(50)
        }
        bookmarkList.snp.makeConstraints {
            let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 50
            $0.bottom.equalToSuperview().inset(tabBarHeight)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(600)
        }
        
        bookmarker.rx.panGesture()
            .bind { [unowned self] in handlingBookmarker($0) }
            .disposed(by: disposeBag)
        
        bookmarkList.rx.tapGesture()
            .when(.recognized)
            .bind { [unowned self] _ in
                coordinator?.presentCommonFormatViewController(type: .bookmarkAdd)
            }.disposed(by: disposeBag)
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
