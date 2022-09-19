//
//  CalendarCV+Cell.swift
//  Calendar
//
//  Created by 인포렉스 on 2022/09/13.
//

import Foundation
import UIKit
import Then
import SnapKit

class CalendarCollectionViewCell : UICollectionViewCell {
    
    static let identifier = "CalendarCollectionViewCell"
    
    var contentCellView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    var eventView = UIView().then{
        $0.backgroundColor = .clear
    }
    
    var eventMark = UIView().then{
        $0.backgroundColor = .systemGray
        $0.layer.cornerRadius = 2.5
    }
    
    var label = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .black
    }
    
    var currSelectLine = UIView().then{
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 1.5
    }
    
    override var isSelected: Bool {
        didSet {
            currSelectLine.isHidden = !isSelected
        }
    }
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder : NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        setUI()
    }
    
    func setUI() {
        [contentCellView].forEach{ contentView.addSubview($0)}
        
        [label, currSelectLine, eventView].forEach{ contentCellView.addSubview($0)}
        
        eventView.addSubview(eventMark)
        
        contentCellView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        currSelectLine.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(3)
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.height.equalTo(2)
        }
        
        eventView.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
        
        eventMark.snp.makeConstraints{
            $0.width.height.equalTo(5)
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func configUI(_ data : MonthStruct) {
        
        label.isHidden          = false
        eventView.isHidden      = false
        eventMark.isHidden      = true
        label.font = .systemFont(ofSize: 12, weight: .regular)
        
        switch data.monthType {
        case .Curr:
            label.text = data.day()
            if data.getDate() == CalendarHelper.shared.getDate() {
                label.font = .systemFont(ofSize: 13, weight: .bold)
            }
            
        case .Next, .Prev:
            label.isHidden = true
            eventView.isHidden = true
        }
    }
    
}
