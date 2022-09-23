//
//  BookmarkListView.swift
//  Presantation
//
//  Created by chuchu on 2022/09/23.
//

import Foundation
import UIKit
import Util
import SnapKit
import Then
import RxSwift
import Domain

class BookmarkListView: ProgrammaticallyView {
    let listTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(BookmarkCell.self, forCellReuseIdentifier: BookmarkCell.identifier)
    }
    
    override func addComponent() {
        [listTableView].forEach(addSubview)
    }
    
    override func setConstraints() {
        listTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func bind() {
        let testArray: [TestBK] = [TestBK(date: "1997-03-18", contents: "이것은 일기?", distance: "장성 40km"),
                                   TestBK(date: "1997-03-18", contents: "이것은 일기?", distance: "장성 40km"),
                                   TestBK(date: "1997-03-18", contents: "이것은 일기?", distance: "장성 40km"),
                                   TestBK(date: "1997-03-18", contents: "이것은 일기?", distance: "장성 40km"),
                                   TestBK(date: "1997-03-18", contents: "이것은 일기?", distance: "장성 40km"),
                                   TestBK(date: "1997-03-18", contents: "이것은 일기?", distance: "장성 40km"),
                                   TestBK(date: "1997-03-18", contents: "이것은 일기?", distance: "장성 40km"),
                                   TestBK(date: "1997-03-18", contents: "이것은 일기?", distance: "장성 40km"),
                                   TestBK(date: "1997-03-18", contents: "이것은 일기?", distance: "장성 40km"),
                                   TestBK(date: "1997-03-18", contents: "이것은 일기이것은 일기이것은 \n일기이것은 일기이것은 \n일기이것은 일기이것은 \n일기이것은 일기이것은 \n일기이것은 일기이것은 일기이것은 일기이것은\n 일기이것은 일기이것은 일기\n?", distance: "장성 40km")]
        let test = BehaviorSubject(value: testArray)
        
        test.asDriver { _ in .empty() }
            .drive(listTableView.rx.items(cellIdentifier: BookmarkCell.identifier, cellType: BookmarkCell.self)) { row, model, cell in
                cell.dateLabel.text = model.date
                cell.contentsLabel.text = model.contents
                cell.distanceLabel.text = model.distance
            }
            .disposed(by: disposeBag)
    }
}

class InstaCollectionFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        scrollDirection = .vertical
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct TestBK {
    let date: String
    let contents: String
    let distance: String
}
