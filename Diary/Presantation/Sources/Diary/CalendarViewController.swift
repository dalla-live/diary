//
//  CalendarViewController.swift
//  Presantation
//
//  Created by ejsong on 2022/09/15.
//

import Foundation
import UIKit
import Util

class CalendarViewController : UIViewController {
    
    weak var delegate : DiaryViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendarView = CalendarView(frame: self.view.frame)
            calendarView.delegate = delegate
        let calendarMarkView = CalendarMarkView(frame: self.view.frame)
            calendarMarkView.delegate = delegate
        
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
    
}
