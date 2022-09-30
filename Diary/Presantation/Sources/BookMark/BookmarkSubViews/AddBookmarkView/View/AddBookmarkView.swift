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
import Domain

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
        $0.text = Const.ToBeLocalized.note.text
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
    
    let weatherScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    let weatherStackView = UIStackView().then {
        $0.spacing = 2
    }
    
    let moodScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    let moodStackView = UIStackView().then {
        $0.spacing = 2
    }
    
    let moodLabel = UILabel().then {
        $0.text = Const.ToBeLocalized.mood.text
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    let moodGradientView = UIView()
    
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
        
        weatherGradientView.addSubview(weatherScrollView)
        weatherScrollView.addSubview(weatherStackView)
        
        moodGradientView.addSubview(moodScrollView)
        moodScrollView.addSubview(moodStackView)
        
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
            $0.width.equalTo(300)
            $0.height.equalTo(260)
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
        
        weatherScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        weatherStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(halfSpacing)
            $0.top.bottom.equalToSuperview()
            $0.height.equalToSuperview()
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
        
        moodScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        moodStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(halfSpacing)
            $0.top.bottom.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(halfSpacing)
            $0.bottom.equalToSuperview().inset(halfSpacing)
            $0.height.equalTo(50)
        }
    }
    
    override func bind() {
        setScrollView()
        rxTapActions()
    }
    
    private func setScrollView() {
        let weatherCases = Weather.WeatherCase.allCases,
            moodCases = Mood.MoodCase.allCases
        
        weatherCases.enumerated().forEach { index, model in
            let view = EmoticonView()
            view.emotionLabel.text = model.emoticon
            
            weatherStackView.addArrangedSubview(view)
            
            view.snp.makeConstraints {
                $0.width.equalTo(34)
            }
            
            view.rx.tapGesture()
                .when(.recognized)
                .bind { [unowned self] _ in selectItem(for: weatherStackView, index: index) }
                .disposed(by: disposeBag)
        }
        
        moodCases.enumerated().forEach { index, model in
            let view = EmoticonView()
            view.emotionLabel.text = model.emoticon
            
            moodStackView.addArrangedSubview(view)
            
            view.snp.makeConstraints {
                $0.width.equalTo(34)
            }
            
            view.rx.tapGesture()
                .when(.recognized)
                .bind { [unowned self] _ in selectItem(for: moodStackView, index: index) }
                .disposed(by: disposeBag)
        }
    }
    
    private func selectItem(for stackView: UIStackView, index: Int) {
        let emoticonViews = stackView.arrangedSubviews.filter { $0 is EmoticonView }.map { $0 as! EmoticonView }
        emoticonViews.forEach {
            $0.selectImage.isHidden = true
        }
        
        emoticonViews[safe: index]?.selectImage.isHidden = false
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
