//
//  CalendarView+Bind.swift
//  Calendar
//
//  Created by 인포렉스 on 2022/09/14.
//

import Foundation
import RxCocoa
import RxSwift
import Util

extension CalendarView {
    
    func binds() {
        viewModel = CalendarGridViewModel(CalendarGridViewModel.Input(date: date.asObservable()))
        date.onNext(visibleDateInfo)
        
        viewModel.output?.monthStruct.bind(to: collectionView.rx.items(cellIdentifier: CalendarCollectionViewCell.identifier, cellType: CalendarCollectionViewCell.self)) { [weak self] row, data , cell in
            guard let self = self else {return }
            
            cell.configUI(data)
            cell.isSelected = false
            
            if data.dayInt == 1 || data.getDate() == CalendarHelper.shared.getDate() {
                cell.isSelected = true
                let indexPath = IndexPath(row: row, section: 0)
                self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            }
        
        }.disposed(by: disposeBag)
        
        collectionView.rx.itemSelected.bind{ [weak self ] indexPath in
            guard let self = self else { return }
            
            self.lastSelectedIndexPath = indexPath
            
            let data = self.viewModel.output?.monthStruct.value[indexPath.row]
            self.viewModel.model.currSelectedDate = data?.getDate() ?? ""
            
            guard let cell = self.collectionView.cellForItem(at: indexPath) else { return }
            
            if data?.monthType == .Curr {
                cell.isSelected = true
            }
            
            self.calendarVM?.getContentofList(date: data?.getDate() ?? "")
            
        }.disposed(by: disposeBag)
        
        prevButton.rx.tap.bind{ [weak self] _ in
            guard let self = self else { return }
            let prevMonth = CalendarHelper.shared.getPrevMonth(self.viewModel.model.date)
            self.date.onNext(prevMonth)
        }.disposed(by: disposeBag)
        
        nextButton.rx.tap.bind{ [weak self] _ in
            guard let self = self else { return }
            let prevMonth = CalendarHelper.shared.getNextMonth(self.viewModel.model.date)
            self.date.onNext(prevMonth)
            
        }.disposed(by: disposeBag)
        
        viewModel.output?.monthOfDate.bind{ [weak self] data in
            
            guard let self = self else { return }
            self.monthLabel.text = data
            self.calendarVM?.getMonth(month: data)
            
        }.disposed(by: disposeBag)
        
        calendarVM?.dateList.bind{ [weak self] data in
            print("data :: \(data)")
            
        }.disposed(by: disposeBag)
        
    }

}
