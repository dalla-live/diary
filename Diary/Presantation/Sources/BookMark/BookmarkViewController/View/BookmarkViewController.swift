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
    
    let disposeBag = DisposeBag()
    private var viewModel: BookmarkViewModel!
    var bookmarkListView: BookmarkListView!
    
    let bookmarkListTitle = UILabel().then {
        $0.text = "bookmark".localized
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 36, weight: .bold)
    }
    
    let addBookmarkButton = UIButton().then {
        $0.roundCorners(.allCorners, radius: 25)
        $0.setImage(UIImage(systemName: "plus.circle"), for: .normal)
    }
    
    /// ViewController 의존성 주입을 위한 Create 함수
    public static func create(with viewModel: BookmarkViewModel)-> BookmarkViewController {
        let vc = BookmarkViewController()
        vc.viewModel = viewModel
        
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
        setBookmarkListView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookmarkListTitle.text = "bookmark".localized
    }
    
    private func commonInit() {
        addComponent()
        setConstraints()
        bind()
    }
    
    private func addComponent() {
        [bookmarkListTitle,
         addBookmarkButton].forEach(view.addSubview)
    }
    
    private func setConstraints() {
        bookmarkListTitle.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(16)
        }
        
        addBookmarkButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
    }
    
    private func bind() {
        addBookmarkButton.rx.tap
            .bind { [weak self] in
                self?.coordinator?.presentCommonFormatViewController(type: .bookmarkAdd)
            }
            .disposed(by: disposeBag)
    }
    
    
    private func setBookmarkListView() {
        self.bookmarkListView = BookmarkListView()
        
        view.addSubview(bookmarkListView)
        
        bookmarkListView.snp.makeConstraints {
            let tabBarHeight = self.tabBarController?.tabBar.frame.size.height ?? 50
            $0.top.equalTo(addBookmarkButton.snp.bottom)
            $0.bottom.equalToSuperview().inset(tabBarHeight)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
