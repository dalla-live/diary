//
//  CalendarView.swift
//  Calendar
//
//  Created by 인포렉스 on 2022/09/13.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Util

class CalendarView : ProgrammaticallyView {
    
    var contentView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var monthOfDate = UIView().then {
        $0.backgroundColor = .white
    }
    
    var monthLabel = UILabel().then {
        $0.backgroundColor = .white
        $0.textColor = .black
    }
    
    var prevButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        $0.tintColor = .black
    }
    
    var nextButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        $0.tintColor = .black
    }
    
    lazy var weekStackView = UIStackView()
    
    lazy var collectionView : UICollectionView = {
        let layout                        = UICollectionViewFlowLayout()
        layout.minimumLineSpacing         = 0
        layout.minimumInteritemSpacing    = 0
        let view                          = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        view.isPagingEnabled              = false
        view.showsVerticalScrollIndicator = false
        view.allowsMultipleSelection      = false
        view.isScrollEnabled              = false
        view.delegate                     = self
        view.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: "CalendarCollectionViewCell")
        view.backgroundColor = .white
        return view
    }()
    
    
    var viewModel : CalendarGridViewModel!
    weak var delegate : DiaryViewDelegate?
    
    var visibleDateInfo : Date = Date()
    var date : PublishSubject<Date> = .init()
    var lastSelectedIndexPath : IndexPath?

    override func addComponent() {
        fileName = #file.fileName
        setUI()
        configWeekStackView()
    }
    
    override func moreAction() {
        addGesture()
    }
    
    override func bind() {
        binds()
    }
    
    func setUI() {
        
        addSubview(contentView)
        
        [monthOfDate, weekStackView, collectionView].forEach{ contentView.addSubview($0)}
        
        [monthLabel, prevButton, nextButton].forEach{ monthOfDate.addSubview($0)}
    
    }

    override func setConstraints() {
        contentView.snp.makeConstraints{
            let height = (Size.contentCellWidth.scale() * 6) + Size.monthOfDateHeight.scale() + Size.weekStackHeight.scale() + Size.weekStackTopPadding.scale()
            $0.centerX.centerY.equalToSuperview()
            $0.height.equalTo(height)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        monthOfDate.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(Size.monthOfDateHeight.scale())
        }
        
        monthLabel.snp.makeConstraints{
            $0.left.equalToSuperview().offset(16)
            $0.top.bottom.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints{
            $0.right.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(50)
        }
        
        prevButton.snp.makeConstraints{
            $0.right.equalTo(nextButton.snp.left).inset(-3)
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(50)
        }
        
        weekStackView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(monthOfDate.snp.bottom)
            $0.height.equalTo(Size.weekStackHeight.scale())
        }
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(weekStackView.snp.bottom).offset(Size.weekStackTopPadding.scale())
            $0.width.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
    }
    
    private func configWeekStackView() {
        let dayofWeek = ["일", "월", "화", "수", "목", "금", "토"]
        dayofWeek.forEach{ data in
            let label = UILabel()
            label.text = data
            label.textColor = .black
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 12)
            self.weekStackView.addArrangedSubview(label)
            label.snp.makeConstraints{
                $0.width.equalTo(Size.contentCellWidth.scale())
            }
        }
    }
    
    private func addGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureRecog(_ :)))
        swipeRight.direction = .right
        self.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureRecog(_ :)))
        swipeLeft.direction = .left
        self.addGestureRecognizer(swipeLeft)
    }
    
    @objc func swipeGestureRecog(_ sender : UISwipeGestureRecognizer) {
        
        switch sender.direction {
        case .right:
            let prevMonthDate = CalendarHelper.shared.getPrevMonth(viewModel.model.date)
            date.onNext(prevMonthDate)
        case .left:
            let nextMonthDate = CalendarHelper.shared.getNextMonth(viewModel.model.date)
            date.onNext(nextMonthDate)
        default:
            return
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

extension CalendarView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Size.contentCellWidth.scale() , height: Size.contentCellWidth.scale())
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

}


extension CalendarView {
    enum Size {
        case contentCellWidth
        case monthOfDateHeight
        case weekStackHeight
        case weekStackTopPadding
        
        var const : CGFloat  {
            switch self {
            case .contentCellWidth:
                return (UIScreen.main.bounds.width - 32) / 7
            case .monthOfDateHeight:
                return 50
            case .weekStackHeight:
                return 50
            case .weekStackTopPadding:
                return 10
            }
        }
        
        func scale() -> CGFloat { return const }
    }
}
