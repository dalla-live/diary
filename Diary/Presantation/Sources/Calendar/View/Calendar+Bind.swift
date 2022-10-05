//
//  Calendar+Bind.swift
//  Presantation
//
//  Created by ejsong on 2022/09/22.
//

import Foundation
import RxCocoa
import RxSwift

extension CalendarViewController {
    func bind() {
        viewModel.getDate(date: Date())
        
        viewModel.monthStruct.bind(to: collectionView.rx.items(cellIdentifier: CalendarCollectionViewCell.identifier, cellType: CalendarCollectionViewCell.self)) { [weak self] row, data , cell in
            guard let self = self else {return }
            
            let dateList = self.viewModel.dateList.value
    
            cell.eventMark.isHidden = !dateList.contains(data.getDate())
            cell.configUI(data)
            cell.isSelected = false
            
            if data.dayInt == 1 || data.getDate() == CalendarHelper.shared.getDate() {
                cell.isSelected = true
                let indexPath = IndexPath(row: row, section: 0)
                self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            }
        
        }.disposed(by: disposeBag)
    
        
        collectionView.rx.itemSelected.bind{ [weak self] index in
            guard let self = self else { return }
            self.lastSelectedIndexPath = index
            let data = self.viewModel.monthStruct.value[index.row]
            guard let cell = self.collectionView.cellForItem(at: index) else { return }
            
            if data.monthType == .Curr {
                cell.isSelected = true
            }
            self.viewModel.getContentofList(date: data.getDate())
            
        }.disposed(by: disposeBag)
        
        
        prevButton.rx.tap.bind{ [weak self] _ in
            guard let self = self else { return }
            let prevMonth = CalendarHelper.shared.getPrevMonth(self.viewModel.model.date)
            self.viewModel.getDate(date: prevMonth)
        }.disposed(by: disposeBag)
        
        nextButton.rx.tap.bind{ [weak self] _ in
            guard let self = self else { return }
            let nextMonth = CalendarHelper.shared.getNextMonth(self.viewModel.model.date)
            self.viewModel.getDate(date: nextMonth)
            
        }.disposed(by: disposeBag)
        
        viewModel.monthOfDate.bind{ [weak self] data in
            
            guard let self = self else { return }
            self.monthLabel.text = data
            self.viewModel.getMonth(month: data)
            
            
        }.disposed(by: disposeBag)
        
        viewModel.contentsList.bind(to: tableView.rx.items(cellIdentifier: CalendarMarkCell.identifier, cellType: CalendarMarkCell.self)) { [weak self] row, model, cell in
            guard let _ = self else { return }
            cell.configUI(model.hasWritten)
            cell.bookMarkTitle.text = model.note
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.bind{ [weak self] indexPath in
            guard let self = self else { return }
            
            self.viewModel.openDiaryViewController(self.viewModel.contentsList.value[indexPath.row])
        }.disposed(by: disposeBag)
        
    }
}
