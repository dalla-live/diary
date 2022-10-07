//
//  CalendarViewController.swift
//  Presantation
//
//  Created by ejsong on 2022/09/15.
//

import Foundation
import UIKit
import Util
import RxSwift
import RxCocoa

public final class CalendarViewController : UIViewController, UITableViewDelegate {
    
    var calendarView = UIView().then {
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
        let view                          = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        view.isPagingEnabled              = false
        view.showsVerticalScrollIndicator = false
        view.allowsMultipleSelection      = false
        view.isScrollEnabled              = false
        view.delegate                     = self
        view.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: "CalendarCollectionViewCell")
        view.backgroundColor = .white
        return view
    }()
    
    var markView = UIView().then{
        $0.backgroundColor = .white
    }
    
    var tableView = UITableView().then{
        $0.backgroundColor = .white
        $0.isScrollEnabled = true
        $0.rowHeight = 50
        $0.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.register(CalendarMarkCell.self, forCellReuseIdentifier: "CalendarMarkCell")
    }

    var viewModel : CalendarViewModel!
    var visibleDateInfo : Date = Date()
    var lastSelectedIndexPath : IndexPath?

    var disposeBag : DisposeBag = DisposeBag()
    
    public static func create(with viewModel: CalendarViewModel) -> CalendarViewController {
        let vc = CalendarViewController()
        vc.viewModel = viewModel
        
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        configWeekStackView()
        setConstraint()
        bind()
        addGesture()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        viewModel.getContentofList(date: CalendarHelper.shared.getDate())
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
    
    func setUI() {
        view.backgroundColor = .white
        [calendarView, markView].forEach{ self.view.addSubview($0) }
        [monthOfDate, weekStackView, collectionView].forEach{ calendarView.addSubview($0)}
        
        [monthLabel, prevButton, nextButton].forEach{ monthOfDate.addSubview($0)}
        [tableView].forEach{ markView.addSubview($0) }
        
        calendarView.roundCorners(.allCorners, radius: 15)

        calendarView.addShadow(location: .bottom, color: UIColor(rgb: 103), opacity: 0.16, blur: 6)
        
        markView.frame = markView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
        tableView.delegate = self
    }
    
    func setConstraint() {
        calendarView.snp.makeConstraints{
            let height = (Size.contentCellWidth.scale() * 6) + Size.monthOfDateHeight.scale() + Size.weekStackHeight.scale() + Size.weekStackTopPadding.scale()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(height)
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
        
        markView.snp.makeConstraints{
            $0.top.equalTo(calendarView.snp.bottom).offset(20)
            $0.left.right.bottom.equalToSuperview()
        }
    
        tableView.snp.makeConstraints{
            $0.top.equalTo(calendarView.snp.bottom).offset(20)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    private func addGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureRecog(_ :)))
        swipeRight.direction = .right
        self.calendarView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureRecog(_ :)))
        swipeLeft.direction = .left
        self.calendarView.addGestureRecognizer(swipeLeft)
    }
    
    @objc func swipeGestureRecog(_ sender : UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            let prevMonthDate = CalendarHelper.shared.getPrevMonth(viewModel.model.date)
            self.viewModel.getDate(date: prevMonthDate)
        case .left:
            let nextMonthDate = CalendarHelper.shared.getNextMonth(viewModel.model.date)
            self.viewModel.getDate(date: nextMonthDate)
        default:
            return
        }
    }
    
}

extension CalendarViewController : UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Size.contentCellWidth.scale() , height: Size.contentCellWidth.scale())
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

}


extension CalendarViewController {
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
