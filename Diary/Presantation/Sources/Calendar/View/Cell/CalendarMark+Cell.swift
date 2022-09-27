//
//  CalendarMark+Cell.swift
//  Calendar
//
//  Created by ejsong on 2022/09/15.
//

import Foundation
import UIKit

enum CalendarType {
    case BookMark
    case Diary
}

class CalendarMarkCell : UITableViewCell {
    static let identifier  = "CalendarMarkCell"
    
    var markColor : UIColor = {
        return .black
    }()
    
    var contentCell = UIView().then {
        $0.backgroundColor = .clear
    }
    
    var markDivider = UIView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 2
    }
    
    var bookMarkTitle = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
        $0.textAlignment = .left
        $0.text = "북마크"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    func commonInit() {
        setUI()
        self.backgroundColor = .white
    }
    
    func setUI() {
        
        contentView.addSubview(contentCell)
        
        [markDivider, bookMarkTitle].forEach { contentCell.addSubview($0)}
        
        contentCell.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        markDivider.snp.makeConstraints{
            $0.left.equalToSuperview().offset(6)
            $0.height.equalTo(18)
            $0.width.equalTo(4)
            $0.centerY.equalToSuperview()
        }
        
        bookMarkTitle.snp.makeConstraints{
            $0.left.equalTo(markDivider.snp.right).offset(10)
            $0.right.equalToSuperview().offset(-6)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configUI(_ data : CalendarType) {
        switch data {
        case .BookMark:
            markDivider.backgroundColor = .darkGray
        case .Diary:
            markDivider.backgroundColor = .purple
        }
    }
}
