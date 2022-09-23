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
import RxGesture
import RxCocoa

public final class CalendarViewController : UIViewController {
    
    weak var delegate : DiaryViewDelegate?
    var coordinator: DiaryCoordinator?
    var disposeBag = DisposeBag()
    
    let writeDiaryButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        $0.backgroundColor = .black
        $0.tintColor = .blue
        $0.layer.cornerRadius = 10.0
    }
    
    // ViewController 의존성 주입을 위한 create
    public static func create(coordinator: DiaryCoordinator) -> CalendarViewController {
        let vc = CalendarViewController()
        vc.coordinator = coordinator
        
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendarView = CalendarView(frame: self.view.frame)
            calendarView.delegate = delegate
        let calendarMarkView = CalendarMarkView(frame: self.view.frame)
            calendarMarkView.delegate = delegate
        
        [calendarView, calendarMarkView, writeDiaryButton].forEach{ self.view.addSubview($0)}
        
        self.view.backgroundColor = .white
        
        calendarView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(400)
        }
        
        calendarMarkView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(calendarView.snp.bottom).offset(20)
            $0.height.equalTo(300)
        }
        
        writeDiaryButton.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.right.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(100)
        }

        calendarView.contentView.layer.cornerRadius = 15
        calendarView.contentView.layer.masksToBounds = true
        calendarView.addShadow(location: .bottom, color: UIColor(rgb: 103), opacity: 0.16, blur: 6)
        
        bind()
    }
    
    func bind(){
        writeDiaryButton.rx.tapGesture()
            .when(.recognized)
            .bind {[weak self] _ in
                self?.coordinator?.writeDiaryViewControllerStart()
            }
            .disposed(by: disposeBag)
    }
    
}
