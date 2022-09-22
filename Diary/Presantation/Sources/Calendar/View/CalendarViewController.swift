//
//  CalendarViewController.swift
//  Presantation
//
//  Created by ejsong on 2022/09/15.
//

import Foundation
import UIKit
import Util

public final class CalendarViewController : UIViewController {
    
    private var viewModel : CalendarViewModel!
    
    public static func create(with viewModel: CalendarViewModel) -> CalendarViewController {
        let vc = CalendarViewController()
        vc.viewModel = viewModel
        
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind(to : viewModel)
    }
    
    func setUI() {
        let calendarView = CalendarView(frame: self.view.frame)
            calendarView.calendarVM = viewModel
        
        let calendarMarkView = CalendarMarkView(frame: self.view.frame)
            calendarMarkView.calendarVM = viewModel
        
        [calendarView, calendarMarkView].forEach{ self.view.addSubview($0)}
        
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

        calendarView.contentView.layer.cornerRadius = 15
        calendarView.contentView.layer.masksToBounds = true
        calendarView.addShadow(location: .bottom, color: UIColor(rgb: 103), opacity: 0.16, blur: 6)
    }
    
    func bind(to viewModel: CalendarViewModel) {
        
    }
    
}
