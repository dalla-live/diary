//
//  AddBookmarkView.swift
//  Presantation
//
//  Created by chuchu on 2022/09/19.
//

import Foundation
import Util
import UIKit
import SnapKit
import Then
import Toast
import RxSwift
import RxCocoa

class AddBookmarkView: ProgrammaticallyView {
    let backgroundView = UIView().then {
        $0.backgroundColor = Const.Custom.background.color
    }
    
    let contentView = VibrationView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.addShadow(location: .bottom)
    }
    
    let titleLabel = UILabel().then {
        $0.text = Const.ToBeLocalized.addBookmark.text
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    let titleLine = UIView().then {
        $0.backgroundColor = Const.Custom.line.color
    }
    
    let locationLabel = UILabel().then {
        $0.text = Const.ToBeLocalized.location.text
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    let reviseLocationButton = UIButton().then {
        $0.setImage(UIImage(systemName: "goforward"), for: .normal)
        $0.contentHorizontalAlignment = .center
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5.0
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = Const.Custom.line.color?.cgColor
    }
    
    let roadNameLabel = UILabel().then {
        $0.text = Const.ToBeLocalized.loadNameExample.text
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 14, weight: .light)
    }

    
    let weatherLabel = UILabel().then {
        $0.text = Const.ToBeLocalized.weather.text
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    let weatherGradientView = UIView()
    
    let weatherCollectionView = UICollectionView(frame: .zero, collectionViewLayout: TestFlowLayout()).then {
        $0.backgroundColor = .white
        $0.showsHorizontalScrollIndicator = false
        $0.register(EmoticonCell.self, forCellWithReuseIdentifier: EmoticonCell.identifier)
    }
    
    let moodLabel = UILabel().then {
        $0.text = Const.ToBeLocalized.mood.text
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    let moodGradientView = UIView()
    
    let moodCollectionView = UICollectionView(frame: .zero, collectionViewLayout: TestFlowLayout()).then {
        $0.backgroundColor = .white
        $0.showsHorizontalScrollIndicator = false
        $0.register(EmoticonCell.self, forCellWithReuseIdentifier: EmoticonCell.identifier)
    }
    
    let buttonStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 10.0
    }
    
    let cancelButton = UIButton().then {
        $0.setTitle(Const.ToBeLocalized.cancel.text, for: .normal)
        $0.setTitleColor(Const.Custom.cancle.color, for: .normal)
        $0.addBorder(width: 1, color: Const.Custom.line.color ?? UIColor())
        $0.layer.cornerRadius = 8
    }
    
    let storeButton = UIButton().then {
        $0.setTitle(Const.ToBeLocalized.store.text, for: .normal)
        $0.setTitleColor(Const.Custom.store.color, for: .normal)
        $0.addBorder(width: 1, color: Const.Custom.line.color ?? UIColor())
        $0.layer.cornerRadius = 8
    }
    
    let date = DateFormatter().then {
        $0.locale = Locale(identifier: "ko_KR")
        $0.timeZone = TimeZone(abbreviation: "KST")
        $0.dateFormat = "yyyy-MM-d"
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        [weatherGradientView, moodGradientView].forEach(setGradient)
    }
    
    override func addComponent() {
        fileName = #file.fileName
        [backgroundView, contentView].forEach(addSubview)
        
        [titleLabel,
         titleLine,
         locationLabel,
         reviseLocationButton,
         roadNameLabel,
         weatherLabel,
         weatherGradientView,
         moodLabel,
         moodGradientView,
         buttonStackView].forEach(contentView.addSubview)
        
        weatherGradientView.addSubview(weatherCollectionView)
        moodGradientView.addSubview(moodCollectionView)
        [cancelButton,
         storeButton].forEach(buttonStackView.addArrangedSubview)
    }
    
    override func setConstraints() {
        let defaultSpacing: CGFloat = 16.0,
            halfSpacing: CGFloat = 8.0
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14.0)
            $0.centerX.equalToSuperview()
        }
        
        titleLine.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(titleLine.snp.bottom).offset(defaultSpacing)
            $0.leading.equalToSuperview().inset(defaultSpacing)
        }
        
        reviseLocationButton.snp.makeConstraints {
            $0.centerY.equalTo(locationLabel)
            $0.trailing.equalToSuperview().inset(halfSpacing)
            $0.size.equalTo(40)
        }
        
        roadNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationLabel)
            $0.leading.greaterThanOrEqualTo(locationLabel.snp.trailing).offset(halfSpacing)
            $0.trailing.equalTo(reviseLocationButton.snp.leading).offset(-halfSpacing)
        }
        
        weatherLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(defaultSpacing * 2)
            $0.leading.equalTo(locationLabel)
        }
        
        weatherGradientView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(halfSpacing)
            $0.centerY.equalTo(weatherLabel)
            $0.height.equalTo(36)
            $0.width.equalTo(150)
        }
        
        weatherCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        moodLabel.snp.makeConstraints {
            $0.top.equalTo(weatherLabel.snp.bottom).offset(defaultSpacing * 2)
            $0.leading.equalTo(weatherLabel)
        }
        
        moodGradientView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(halfSpacing)
            $0.centerY.equalTo(moodLabel)
            $0.height.equalTo(36)
            $0.width.equalTo(150)
        }
        
        moodCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(halfSpacing)
            $0.bottom.equalToSuperview().inset(halfSpacing)
            $0.height.equalTo(50)
        }
    }
    
    override func bind() {
        setRxCollection()
        rxTapActions()
    }
    
    func setRxCollection() {
        let weatherCases = Weather.allCases,
            weatherTest = BehaviorRelay(value: weatherCases),
            moodCases = Mood.allCases,
            moodTest = BehaviorRelay(value: moodCases)
        
        weatherTest.asDriver()
            .drive(weatherCollectionView.rx.items(cellIdentifier: EmoticonCell.identifier, cellType: EmoticonCell.self)) { row, model, cell in
                cell.emotionLabel.text = model.emoticon
            }
            .disposed(by: disposeBag)
        
        weatherCollectionView.rx.modelSelected(Weather.self)
            .bind {
                print($0.text)
            }.disposed(by: disposeBag)
        
        moodTest.asDriver()
            .drive(moodCollectionView.rx.items(cellIdentifier: EmoticonCell.identifier, cellType: EmoticonCell.self)) { row, model, cell in
                cell.emotionLabel.text = model.emoticon
            }
            .disposed(by: disposeBag)
        
        moodCollectionView.rx.modelSelected(Mood.self)
            .bind {
                print($0.text)
            }.disposed(by: disposeBag)
    }
    
    private func setGradient(to view: UIView) {
        let gradient = CAGradientLayer(),
            clearColor = UIColor.clear.cgColor,
            whiteColor = UIColor.white.cgColor
        
        gradient.frame = view.bounds
        gradient.colors = [clearColor, whiteColor, whiteColor, clearColor]
        gradient.startPoint = CGPoint(x:0.0, y:0.5)
        gradient.endPoint = CGPoint(x:1.0, y:0.5)
        gradient.locations = [0, 0.1, 0.9, 1]
        
        view.layer.mask = gradient
    }
}

class TestFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        scrollDirection = .horizontal
        sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        minimumLineSpacing = 4.0
        itemSize = CGSize(width: 34.0, height: 36.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
