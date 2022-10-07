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
import CoreLocation
import Repository

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
    
    var bookmakrList: BookmarkList = BookmarkList(bookmarks: [], hasNext: false)
    var readMoreIndexPathList: Set<IndexPath> = []
    var translatedIndexPath: Set<IndexPath> = []
    var translateDic: [String: String] = [:]
    var recentTouchReadMoreButton = true
    
    override func addComponent() {
        fileName = #file.fileName
        translateDic = ResourceManager.shared.getJson()
        [listTableView].forEach(addSubview)
    }
    
    override func setConstraints() {
        listTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func bind() {
    }
    
    private func readMoreButtonAction(indexPath: IndexPath) {
        recentTouchReadMoreButton = true
        readMoreIndexPathList.insert(indexPath)
        listTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func translateButtonAction(id: Int, kr: String?) {
        recentTouchReadMoreButton = false
        
        let indexPath = IndexPath(row:  bookmakrList.bookmarks.count - id, section: 0)
        
        ResourceManager.shared.readJson(key: id) {
            switch $0 {
            case .success(_):
                self.listTableView.reloadRows(at: [indexPath], with: .automatic)
            case .failure(_):
                let translationDTO = TranslationDTO(text: kr ?? "", source: Papago.Code.ko.rawValue, target: Papago.Code.en.rawValue)

                TranslationAPI.requestTraslation(request: translationDTO) { [unowned self] result in
                    switch result {
                    case .success(let success):
                        translateDic.updateValue(success, forKey: "\(id)")
                        ResourceManager.shared.writeJson(jsonDic: translateDic)
                        listTableView.reloadRows(at: [indexPath], with: .automatic)
                    case .failure(_):
                        makeToast("쿼리 한도를 초과했습니다.")
                    }
                }
            }
        }
    }
}

extension BookmarkListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmakrList.bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listTableView.dequeueReusableCell(withIdentifier: BookmarkCell.identifier) as? BookmarkCell else { return UITableViewCell() }
        let location = CLLocationCoordinate2D(latitude: bookmakrList.bookmarks[indexPath.row].location.lat,
                                              longitude: bookmakrList.bookmarks[indexPath.row].location.lon),
            distance = Int(CLLocationCoordinate2D(latitude: 35.1466323, longitude: 126.8473066).distance(from: location).rounded(.up)).withComma
        
        cell.dateLabel.text = bookmakrList.bookmarks[indexPath.row].date
        cell.contentsLabel.text = bookmakrList.bookmarks[indexPath.row].note
        cell.distanceLabel.text = "\(distance)m"
        cell.mapView.image = ResourceManager.shared.getImage(imageNo: "\(indexPath.row)")
        
        switch indexPath.row {
        case let readRow where readMoreIndexPathList.contains(where: { $0.row == readRow }) && recentTouchReadMoreButton:
            cell.contentsLabel.numberOfLines = 0
        case let translateRow where translateDic["\(bookmakrList.bookmarks[translateRow].id)"] != nil &&
            translatedIndexPath.contains(IndexPath(row: translateRow, section: 0)):
            cell.contentsLabel.numberOfLines = 0
            ResourceManager.shared.readJson(key: bookmakrList.bookmarks[indexPath.row].id) {
                switch $0 {
                case .success(let value):
                    cell.contentsLabel.text = value
                case .failure(_): break
                }
            }
        default: cell.contentsLabel.numberOfLines = 1
        }

        cell.readMoreButton.rx.tap
            .bind { [unowned self] in readMoreButtonAction(indexPath: indexPath) }
            .disposed(by: cell.disposeBag)
        
        cell.translateButton.rx.tap
            .bind { [unowned self] in
                translatedIndexPath.insert(indexPath)
                translateButtonAction(id: bookmakrList.bookmarks[indexPath.row].id, kr: cell.contentsLabel.text) }
            .disposed(by: cell.disposeBag)
        
        cell.moreActionButton.rx.tap
            .bind { [unowned self] in print(bookmakrList.bookmarks[indexPath.row].id) }
            .disposed(by: cell.disposeBag)
        
        return cell
    }
}

extension BookmarkListView: UITableViewDelegate {
    
}
