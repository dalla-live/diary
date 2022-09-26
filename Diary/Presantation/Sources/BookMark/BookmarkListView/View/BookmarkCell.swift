//
//  BookmarkCell.swift
//  Presantation
//
//  Created by chuchu on 2022/09/23.
//

import Foundation
import UIKit
import SnapKit
import Util
import Design
import RxSwift

class BookmarkCell: UITableViewCell {
    static let identifier = description()
    
    var disposeBag = DisposeBag()
    var scale: (startScale: CGFloat, endScale: CGFloat) = (1.0 ,1.0)
    
    let dateLabel = UILabel().then {
        $0.text = "2021-09-23"
        $0.textColor = .black
    }
    
    let distanceLabel = UILabel().then {
        $0.text = "서울 300km"
        $0.textColor = .black
    }
    
    let moreActionButton = UIButton().then {
        $0.setImage(PresantationAsset.icoMore.image, for: .normal)
    }
    
    // Map으로 바뀔 예정
    let mapView = UIImageView().then {
        $0.backgroundColor = .black
        $0.contentMode = .scaleAspectFit
    }
    
    let contentsLabel = UILabel().then {
        $0.text = "이것은 일기입니다. 영문으로 번역할 수도 있고 수정도 할 수 있지요 촤하하"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.lineBreakMode = .byTruncatingTail
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = UIColor(rgb: 213)
    }
    
    let readMoreButton = UIButton().then {
        $0.setTitle(BookmarkListView.ContentButtonType.readMore.title, for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
        dateLabel.numberOfLines = 1
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let title = contentsLabel.currentLineCount < 2 ? BookmarkListView.ContentButtonType.translate.title : BookmarkListView.ContentButtonType.readMore.title
        readMoreButton.setTitle(title, for: .normal)
        print(contentsLabel.currentLineCount < 2)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        addComponent()
        setConstraints()
        bind()
    }
    
    func addComponent() {
        contentView.backgroundColor = .white
        [dateLabel,
         distanceLabel,
         moreActionButton,
         contentsLabel,
         lineView,
         readMoreButton,
         mapView
        ].forEach(contentView.addSubview)
    }
    
    func setConstraints() {
        let defaultSpacing: CGFloat = 16.0,
            halfSapcing: CGFloat = 8.0
        
        dateLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(halfSapcing)
        }
        
        moreActionButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(halfSapcing)
            $0.size.equalTo(40)
        }
        
        distanceLabel.snp.makeConstraints {
            $0.trailing.equalTo(moreActionButton.snp.leading)
            $0.centerY.equalTo(dateLabel)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(halfSapcing)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.width * 9 / 16)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(halfSapcing)
            $0.height.equalTo(2)
        }
        
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom).offset(defaultSpacing)
            $0.leading.trailing.equalToSuperview().inset(defaultSpacing)
            $0.bottom.equalTo(lineView.snp.top).offset(-defaultSpacing)
        }
        
        readMoreButton.snp.makeConstraints {
            $0.top.equalTo(contentsLabel.snp.bottom).offset(-7)
            $0.leading.equalTo(contentsLabel)
        }
    }
    
    func bind() {
        mapView.rx.pinchGesture()
            .bind { [unowned self] pinch in
                switch pinch.state {
                case .changed:
                    scale.startScale = scale.endScale * pinch.scale
                    mapView.transform = CGAffineTransform(scaleX: scale.startScale, y: scale.startScale)
                case .ended:
                    UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn) {
                        self.scale.endScale = 1.0
                        self.mapView.transform = .identity
                    }
                    
                default: break
                }
            }
            .disposed(by: disposeBag)
        
    }
}
