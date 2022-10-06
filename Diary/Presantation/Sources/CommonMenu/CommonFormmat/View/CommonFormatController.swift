//
//  CommonFormatController.swift
//  Presantation
//
//  Created by inforex_imac on 2022/09/26.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture
import SnapKit
import GoogleMaps
import Service
import GooglePlaces
import Util
import Domain

public class CommonFormatController: UIViewController {
    weak var coordinator: CommonFormatCoordinator?
    var service: (any MapService)?
    var viewModel: CommonFormatViewModel?
    
    let disposeBag = DisposeBag()
    let mapWrapper = UIView()
    
    let wrapperView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let titleLabel = UILabel().then {
        $0.text = "북마크 추가하기"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .center
    }
    
    let titleTopLine = UIView().then {
        $0.backgroundColor = UIColor(white: 0.4, alpha: 0.5)
    }
    
    let mapBottomLine = UIView().then {
        $0.backgroundColor = UIColor(white: 0.4, alpha: 0.5)
    }
    
    let moodView = VibrationView()
    
    let noteLabel = UILabel().then {
        $0.text = AddBookmarkView.Const.ToBeLocalized.note.text
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    let noteWrapperView = UIView().then {
        $0.addBorder(width: 1, color: AddBookmarkView.Const.Custom.line.color ?? UIColor())
        $0.layer.cornerRadius = 16.0
    }
    
    let noteTextView = UITextView().then {
        $0.addPlacehoder(text: AddBookmarkView.Const.ToBeLocalized.loadNameExample.text)
        $0.textColor = .black
        $0.backgroundColor = .white
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    let weatherLabel = UILabel().then {
        $0.text = AddBookmarkView.Const.ToBeLocalized.weather.text
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    let weatherGradientView = UIView()
    
    let weatherScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    let weatherStackView = UIStackView().then {
        $0.spacing = 2
        $0.tag = 30
    }
    
    let moodScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    let moodStackView = UIStackView().then {
        $0.spacing = 2
        $0.tag = 31
    }
    
    let moodLabel = UILabel().then {
        $0.text = AddBookmarkView.Const.ToBeLocalized.mood.text
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    let moodGradientView = UIView()
    
    let buttonStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 10.0
    }
    
    let cancelButton = UIButton().then {
        $0.setTitle(AddBookmarkView.Const.ToBeLocalized.cancel.text, for: .normal)
        $0.setTitleColor(AddBookmarkView.Const.Custom.cancle.color, for: .normal)
        $0.addBorder(width: 1, color: AddBookmarkView.Const.Custom.line.color ?? UIColor())
        $0.layer.cornerRadius = 8
    }
    
    let storeButton = UIButton().then {
        $0.setTitle(AddBookmarkView.Const.ToBeLocalized.store.text, for: .normal)
        $0.setTitleColor(AddBookmarkView.Const.Custom.store.color, for: .normal)
        $0.addBorder(width: 1, color: AddBookmarkView.Const.Custom.line.color ?? UIColor())
        $0.layer.cornerRadius = 8
    }
    
    lazy var mapView: GMSMapView = {
        guard let service = service as? GoogleMapServiceProvider else { return GMSMapView() }
        let map = service.getMapView()
        map.padding = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
        
        return map
    }()
    
    let tooltipStackView = UIStackView().then {
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8.0
        $0.layer.opacity = 0.7
    }
    
    let moodTooltip = UILabel().then {
        $0.font = .systemFont(ofSize: 30)
        $0.textAlignment = .center
    }
    
    let weatherTooltip = UILabel().then {
        $0.font = .systemFont(ofSize: 30)
        $0.textAlignment = .center
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        service = GoogleMapServiceProvider(service: GPSLocationServiceProvider(), delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setLayout()
        bind()
        addNotification()
        viewModel?.viewDidload(location: Location(lat: mapView.camera.target.latitude, lon: mapView.camera.target.longitude, address: "")) {
            self.selectItem(for: self.weatherStackView, index: $0)
        }
        viewModel?.viewDidload()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        [weatherGradientView, moodGradientView].forEach(setGradient)
    }
    
    public static func create(viewModel: CommonFormatViewModel,with type: BehaviorType) -> CommonFormatController {
        let vc = CommonFormatController()
        
        vc.viewModel = viewModel
        
        print("type ::: \(type)")
        print(viewModel)
        return vc
//        vc.viewModel = viewModel
    }
    
    
    func setLayout(){
        addComponent()
        setConstraints()
    }
    
    private func addComponent() {
        view.addSubview(wrapperView)
        
        [titleLabel,
         titleTopLine,
         mapWrapper,
         mapBottomLine,
         weatherLabel,
         weatherGradientView,
         moodView,
         noteLabel,
         noteWrapperView,
         buttonStackView
        ].forEach(wrapperView.addSubview)
        
        mapWrapper.addSubview(mapView)
        mapView.addSubview(tooltipStackView)
        
        noteWrapperView.addSubview(noteTextView)
        
        [weatherTooltip,
         moodTooltip].forEach(tooltipStackView.addArrangedSubview)
        
        weatherGradientView.addSubview(weatherScrollView)
        weatherScrollView.addSubview(weatherStackView)
        
        [moodLabel,
         moodGradientView,].forEach(moodView.addSubview)
        
        moodGradientView.addSubview(moodScrollView)
        moodScrollView.addSubview(moodStackView)
        
        [cancelButton,
         storeButton].forEach(buttonStackView.addArrangedSubview)
        
        
    }
    
    private func setConstraints() {
        let defaultSpacing: CGFloat = 16.0,
            halfSpacing: CGFloat = 8.0,
            width = UIScreen.main.bounds.width
        
        wrapperView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(defaultSpacing)
            $0.centerX.equalToSuperview()
        }
        
        titleTopLine.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(defaultSpacing)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        mapWrapper.snp.makeConstraints {
            $0.top.equalTo(titleTopLine.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(width * 9 / 16)
        }
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tooltipStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-70)
            $0.height.equalTo(50)
        }
        
        mapBottomLine.snp.makeConstraints {
            $0.top.equalTo(mapWrapper.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        weatherLabel.snp.makeConstraints {
            $0.top.equalTo(mapBottomLine.snp.bottom).offset(defaultSpacing)
            $0.leading.equalToSuperview().inset(defaultSpacing)
        }
        
        weatherGradientView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(defaultSpacing)
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
        
        moodView.snp.makeConstraints {
            $0.top.equalTo(weatherLabel.snp.bottom).offset(defaultSpacing * 2)
            $0.leading.trailing.equalToSuperview().inset(defaultSpacing)
            $0.height.equalTo(36.0)
        }
        
        moodLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        moodGradientView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(moodLabel)
            $0.height.equalToSuperview()
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
        
        noteLabel.snp.makeConstraints {
            $0.top.equalTo(moodView.snp.bottom).offset(defaultSpacing)
            $0.leading.equalToSuperview().inset(defaultSpacing)
        }
        
        noteWrapperView.snp.makeConstraints {
            $0.top.equalTo(noteLabel.snp.bottom).offset(halfSpacing)
            $0.leading.trailing.equalToSuperview().inset(defaultSpacing)
            $0.bottom.equalTo(buttonStackView.snp.top).offset(-halfSpacing)
        }
        
        noteTextView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(halfSpacing)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(defaultSpacing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(defaultSpacing)
            $0.height.equalTo(50)
        }
        
        setScrollView()
        
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
        
        switch stackView.tag {
        case 30: // weatherStackView
            weatherTooltip.snp.makeConstraints {
                $0.width.equalTo(50)
            }
            weatherTooltip.text = emoticonViews[safe: index]?.emotionLabel.text
        case 31: // moodStackView
            moodTooltip.snp.makeConstraints {
                $0.width.equalTo(50)
            }
            moodTooltip.text = emoticonViews[safe: index]?.emotionLabel.text
        default: break
        }
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
    
    private func bind() {
        view.rx.tapGesture()
            .when(.recognized)
            .filter { [unowned self] _ in noteTextView.isFirstResponder }
            .bind { [unowned self] _ in noteTextView.resignFirstResponder() }
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .bind { [weak self] in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        storeButton.rx.tap
            .bind { [weak self] in
                guard let mood = self?.getMood(),
                      let weather = self?.getWeather(),
                      let location = self?.mapView.camera.target else { return }
                
                let placeholder = self?.noteTextView.viewWithTag(100) as? UILabel
                let note = self?.noteTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 ? placeholder?.text: self?.noteTextView.text
                
                self?.viewModel?.didTapSave(bookmark: Bookmark(id: 0,
                                                                mood: mood,
                                                                weather: weather,
                                                                date: CalendarHelper.shared.getDate(),
                                                                location: Location(lat: location.latitude, lon: location.longitude, address: ""),
                                                                hasWritten: false,
                                                                note: note ?? "")) { ResourceManager.shared.saveImage(imageNo: "\($0 - 1)", from: self?.mapView ?? UIView())
                    
                    self?.dismiss(animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        guard let placeholder = noteTextView.viewWithTag(100) as? UILabel else { return }
        
        noteTextView.rx.text
            .map { $0?.count != 0 }
            .bind(to: placeholder.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustOnKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustOnKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func getWeather() -> Weather? {
        guard let weatherText = weatherTooltip.text else { return nil }
        
        return Weather(emoticon: weatherText)
    }
    
    private func getMood() -> Mood? {
        guard let moodText = moodTooltip.text else {
            moodView.shakeAnimation() {
                self.view.makeToast("기분을 선택해주세요!")
            }
            return nil
        }
        
        return Mood(emoticon: moodText)
    }
    
    deinit {
        print(#file.fileName , #function)
    }
    
}

extension CommonFormatController: GMSMapViewDelegate {
    //     인포는 나중에
    //    public func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
    //        marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
    //        marker.icon = UIImage(named: "plus.app")
    //        marker.map = mapView
    //        mapView.selectedMarker = marker
    //        return nil
    //    }
    //    public func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
    //
    //        marker.snippet = "testests"
    //        marker.title = "testset"
    //        marker.map = mapView
    //
    //        return contentView
    //    }
    //
    public func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        print(gesture)
        
    }
    
    
    public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        //            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
        //
        //            })
        
        //            mapView.animate(toLocation: marker.position)
        
        return true
    }
    
    public func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        print("didTap")
    }
    
    
    public func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        if self.viewModel?.location == nil {
            service?.setLocation(position: position.target)
        } else {
            guard let target = viewModel?.location else {
                service?.setLocation(position: position.target)
                viewModel?.location = nil
                return 
            }
            viewModel?.location = nil
            service?.setLocation(position: .init(latitude: target.lat, longitude: target.lon))
        }
        
    }
    
    public func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
    }
    
}

// MARK: Keyboard
extension CommonFormatController {
    @objc func adjustOnKeyboard(notification: NSNotification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) else { return }
        let keyboardHeight = self.view.safeAreaInsets.bottom - keyboardRect.height
        
        switch notification.name {
        case UIResponder.keyboardWillShowNotification:
            keyboardAnimation(duration: keyboardDuration, keyboardHeight: keyboardHeight)
            
        case UIResponder.keyboardWillHideNotification:
            keyboardAnimation(duration: keyboardDuration)
        default: break
        }
    }
    
    private func keyboardAnimation(duration: Double, keyboardHeight: CGFloat = 0.0) {
        UIView.animate(withDuration: duration) {
            self.view.frame.origin.y = keyboardHeight
        }
    }
}

extension CommonFormatController {
    public enum BehaviorType {
        case bookmarkAdd
        case bookmarkEdit
        case diaryAdd
        case diaryEdit
    }
}
