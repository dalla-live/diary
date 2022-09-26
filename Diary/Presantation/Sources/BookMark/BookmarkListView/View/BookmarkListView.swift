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
    enum ContentButtonType {
        case readMore
        case translate
        
        var title: String {
            switch self {
            case .readMore: return "더보기"
            case .translate: return "번역하기"
            }
        }
    }
    
    lazy var listTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(BookmarkCell.self, forCellReuseIdentifier: BookmarkCell.identifier)
        $0.dataSource = self
        $0.delegate = self
    }
    
    let testArray: [TestBK] = [TestBK(date: "1997-03-18", contents: "이것은 일기이것은 일기이것은 \n일기이것은 일기이것은 \n일기이것은 일기이것은 \n일기이것은 일기이것은 \n일기이것은 일기이것은 일기이것은 일기이것은\n 일기이것은 일기이것은 일기\n?", distance: "장성 40km"),
                               TestBK(date: "1997-03-18", contents: "이것은 일기?이것은 일기?이것은 일기?이것은 일기?이것은 일기?이것은 일기?이것은 일기?이것은 일기?이것은 일기?이것은 일기?이것은 일기?이것은 일기?이것은 일기?이것은 일기?이것은 일기?이것은 일기?", distance: "장성 40km"),
                               TestBK(date: "1997-03-18", contents: "이것은 일기?", distance: "장성 40km"),
                               TestBK(date: "1997-03-18", contents: "이것은 일기?", distance: "장성 40km"),
                               TestBK(date: "1997-03-18", contents: "이것은 일기?", distance: "장성 40km"),
                               TestBK(date: "1997-03-18", contents: "이것은 일기?", distance: "장성 40km"),
                               TestBK(date: "1997-03-18", contents: "이것은 일기?", distance: "장성 40km"),
                               TestBK(date: "1997-03-18", contents: "이것은 일기?", distance: "장성 40km"),
                               TestBK(date: "1997-03-18", contents: "이것은 일기?", distance: "장성 40km"),
                               TestBK(date: "1997-03-18", contents: "이것은 일기이것은 일기이것은 \n일기이것은 일기이것은 \n일기이것은 일기이것은 \n일기이것은 일기이것은 \n일기이것은 일기이것은 일기이것은 일기이것은\n 일기이것은 일기이것은 일기\n?", distance: "장성 40km")]
    var testIndexPathList: Set<IndexPath> = []
    
    override func addComponent() {
        fileName = #file.fileName
        [listTableView].forEach(addSubview)
    }
    
    override func setConstraints() {
        listTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func bind() {
        self.rx.tapGesture()
            .when(.recognized)
            .bind{ [weak self] _ in self?.removeFromSuperview() }
            .disposed(by: disposeBag)
    }
    
    private func buttonAction(buttonTitle: String?, indexPath: IndexPath) {
        print(indexPath.row)
        switch buttonTitle {
        case ContentButtonType.readMore.title:
            testIndexPathList.insert(indexPath)
            listTableView.reloadRows(at: [indexPath], with: .automatic)
        case ContentButtonType.translate.title:
            removeFromSuperview()
        default: break
        }
    }
}

extension BookmarkListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listTableView.dequeueReusableCell(withIdentifier: BookmarkCell.identifier) as? BookmarkCell else { return UITableViewCell() }
        
        cell.dateLabel.text = testArray[indexPath.row].date
        cell.contentsLabel.text = testArray[indexPath.row].contents
        cell.distanceLabel.text = testArray[indexPath.row].distance
        cell.mapView.image = ResourceManager.shared.getImage(imageNo: "\(indexPath.row)")
        
        switch indexPath.row {
        case let test where testIndexPathList.contains(where: { $0.row == test }): cell.contentsLabel.numberOfLines = 0
        default: cell.contentsLabel.numberOfLines = 2
        }

        cell.readMoreButton.rx.tap
            .bind { [unowned self] in buttonAction(buttonTitle: cell.readMoreButton.title(for: .normal), indexPath: indexPath) }
            .disposed(by: cell.disposeBag)
        
        return cell
    }
}

extension BookmarkListView: UITableViewDelegate {
    
}

struct TestBK {
    let date: String
    let contents: String
    let distance: String
}
