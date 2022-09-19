//
//  CalendarMarkView.swift
//  Calendar
//
//  Created by ejsong on 2022/09/15.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Util

class CalendarMarkView : ProgrammaticallyView , UITableViewDelegate{
    
    var bookMark : BehaviorRelay<[String]> = .init(value: ["북마크", "일기"])
    var contentView = UIView().then{
        $0.backgroundColor = .white
    }
    
    var addDiaryBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "plus.app"), for: .normal)
        $0.tintColor = .black
    }
    
    var tableView = UITableView().then{
        $0.backgroundColor = .white
        $0.isScrollEnabled = false
        $0.rowHeight = 50
        $0.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.register(CalendarMarkCell.self, forCellReuseIdentifier: "CalendarMarkCell")
    }
    
    weak var delegate : DiaryViewDelegate?
    
    override func addComponent() {
        fileName = #file.fileName
        setUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
    }

    func setUI() {
        addSubview(contentView)
        [addDiaryBtn, tableView].forEach{ contentView.addSubview($0) }
        
        tableView.delegate = self
    }
    
    override func setConstraints() {
        contentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        addDiaryBtn.snp.makeConstraints{
            $0.top.right.equalToSuperview()
            $0.right.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(addDiaryBtn.snp.bottom).offset(10)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    override func bind() {
        bookMark.bind(to: tableView.rx.items(cellIdentifier: CalendarMarkCell.identifier, cellType: CalendarMarkCell.self)) { [weak self] row, model, cell in
            guard let _ = self else { return }
            cell.bookMarkTitle.text = model
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.bind{ [weak self] indexPath in
            guard let self = self else { return }
            self.delegate?.openDiaryView()
        }.disposed(by: disposeBag)
        
        addDiaryBtn.rx.tapGesture()
            .when(.recognized)
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.openDiaryView()
            
        }).disposed(by: disposeBag)
    }
}
