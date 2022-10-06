//
//  BookmarkViewController.swift
//  Presantation
//
//  Created by chuchu on 2022/09/16.
//

import Foundation
import UIKit
import RxSwift
import Domain
import CoreLocation
import Util

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
    
    let updateBookmarkButton = UIButton().then {
        $0.roundCorners(.allCorners, radius: 25)
        $0.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
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
        viewModel.viewDidload() {
            self.bookmarkListView.bookmakrList = $0
            self.bookmarkListView.listTableView.reloadData()
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTable()
        bookmarkListTitle.text = "bookmark".localized
    }
    
    private func commonInit() {
        addComponent()
        setConstraints()
        bind()
    }
    
    private func addComponent() {
        [bookmarkListTitle,
         addBookmarkButton,
         updateBookmarkButton].forEach(view.addSubview)
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
        
        updateBookmarkButton.snp.makeConstraints {
            $0.top.height.equalTo(addBookmarkButton)
            $0.trailing.equalTo(addBookmarkButton.snp.leading).offset(-16)
        }
    }
    
    private func bind() {
        addBookmarkButton.rx.tap
            .filter { [unowned self] _ in !bookmarkListView.listTableView.isDragging }
            .bind { [weak self] in
                self?.coordinator?.presentCommonFormatViewController(type: .bookmarkAdd)
            }
            .disposed(by: disposeBag)
        
        updateBookmarkButton.rx.tap
            .bind(onNext: reloadTable)
            .disposed(by: disposeBag)
    }
    
    private func reloadTable(){
        self.viewModel.updateButtonTap() { list in
            if list.bookmarks.count > 0 {
                
                self.bookmarkListView.bookmakrList = list
                self.bookmarkListView.listTableView.reloadData()
                self.bookmarkListView.listTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
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
