//
//  WriteDiaryViewController.swift
//  Presantation
//
//  Created by inforex on 2022/09/20.
//

import Foundation
import UIKit
import RxSwift
import Util
import Service

public final class WriteDiaryViewController: ProgrammaticallyViewController, SpeechRecognizeService {
    
    var coordinator: DiaryCoordinator?
    private var viewModel: WriteDiaryViewModel!
    var speechRecognizer : SpeechRecognizer?
    
    // MARK: Component
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }
    
    var dateTitle = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 25, weight: .bold)
    }
    
    var weatherView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var weatherLabel = UILabel().then {
        $0.text = AddBookmarkView.Const.ToBeLocalized.weather.text
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    var weather = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    var addressView = UIView().then{
        $0.backgroundColor = .white
    }
    
    var addressLabel = UILabel().then {
        $0.text = "주소"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    var address = UILabel().then {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .center
    }
    
    var moodView = UIView().then{
        $0.backgroundColor = .white
    }
    
    var moodLabel = UILabel().then {
        $0.text = AddBookmarkView.Const.ToBeLocalized.mood.text
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    var mood = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    let textContainer = UIView().then{
        $0.backgroundColor = .white
    }
    
    let recordButton = UIButton().then{
        $0.setTitle("음성인식", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addBorder(width: 1, color: .black)
        $0.layer.cornerRadius = 8
    }
    
    let textView = UITextView().then{
        $0.backgroundColor = .white
        $0.textAlignment = .left
        $0.textColor = .black
        $0.textContainerInset = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        $0.addBorder(width: 1, color: .black)
        $0.layer.cornerRadius = 8
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    let translateButton = UIButton().then{
        $0.setTitle("번역하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addBorder(width: 1, color: .black)
        $0.layer.cornerRadius = 8
    }
    
     // 음성인식 뷰
    let exampleRecogBgView = UIView().then {
        $0.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.3)
        $0.isHidden = true
    }
    
    let exampleRecogContainer = UIView().then {
        $0.backgroundColor = UIColor(r:255, g: 105, b: 153)
        $0.layer.cornerRadius = 18
    }
    
    let exampleTextView = UITextView().then{
        $0.backgroundColor = .white
        $0.textAlignment = .left
        $0.textColor = .black
        $0.textContainerInset = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        $0.addBorder(width: 1, color: .black)
        $0.layer.cornerRadius = 8
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.isEditable = false
    }
    
    let exampleButtonContainer = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let exampleRecogButton = UIButton().then {
        $0.setImage(UIImage(systemName: "play.fill"), for: .normal)
        $0.contentHorizontalAlignment = .center
        $0.tintColor = .blue
        $0.isHidden = false
    }
    
    let applyButton = UIButton().then{
        $0.setTitle("적용", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let cancelButton = UIButton().then{
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        $0.setTitleColor(.black, for: .normal)
    }
    
    // ViewController 의존성 주입을 위한 create
    public static func create(viewModel: WriteDiaryViewModel, coordinator: DiaryCoordinator, speechRecognizer: SpeechRecognizer) -> WriteDiaryViewController {
        let vc = WriteDiaryViewController()
            vc.viewModel = viewModel
            vc.coordinator = coordinator
            vc.speechRecognizer = speechRecognizer
        
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let identifier = Locale.current.identifier
        guard let regionCode = Locale.current.regionCode else { return }
        guard let languageCode = Locale.current.languageCode else { return }
        print("identifier: \(identifier), regionCode: \(regionCode), languageCode: \(languageCode)")
        
        let langCode : String?
        
        if #available(iOS 16, *) {
            langCode = Locale(identifier: Locale.preferredLanguages.first ?? "ko-KR").language.languageCode?.identifier
        } else {
            langCode = Locale(identifier: Locale.preferredLanguages.first ?? "ko-KR").languageCode
        }
        print(langCode) // ja // ko // en
        
        let code = Locale.preferredLanguages.first!.prefix(2)
        print(code)

        
        self.speechRecognizer?.delegate = self
        self.view.backgroundColor = .white
        addNotification()
    }
    
    public override func addComponent() {
        fileName = #file.fileName
        
        [stackView , textContainer, exampleRecogBgView].forEach(view.addSubview)
        
        exampleRecogBgView.addSubview(exampleRecogContainer)
        
        [exampleTextView, exampleButtonContainer].forEach(exampleRecogContainer.addSubview)
        
        [exampleRecogButton, applyButton, cancelButton].forEach(exampleButtonContainer.addSubview)
        
        [recordButton, textView, translateButton].forEach(textContainer.addSubview)
        
        [dateTitle, weatherView, addressView, moodView].forEach{ stackView.addArrangedSubview($0) }
        
        [weatherLabel, weather].forEach(weatherView.addSubview)
        
        [addressLabel, address].forEach(addressView.addSubview)
        
        [moodLabel, mood].forEach(moodView.addSubview)
    }
    
    public override func setConstraints() {
        stackView.snp.makeConstraints{
            $0.height.equalTo(200)
            $0.top.equalToSuperview().offset(50)
            $0.right.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
        }
        
        weatherLabel.snp.makeConstraints{
            $0.top.equalTo(weatherView.snp.top)
            $0.leading.bottom.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        weather.snp.makeConstraints{
            $0.leading.equalTo(weatherLabel.snp.trailing)
            $0.top.bottom.trailing.equalToSuperview()
        }
        
        addressLabel.snp.makeConstraints{
            $0.top.equalTo(addressView.snp.top)
            $0.leading.bottom.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        address.snp.makeConstraints{
            $0.leading.equalTo(addressLabel.snp.trailing)
            $0.top.bottom.trailing.equalToSuperview()
        }
        
        moodLabel.snp.makeConstraints{
            $0.top.equalTo(moodView.snp.top)
            $0.leading.bottom.equalToSuperview()
            $0.width.equalTo(100)
        }
        
        mood.snp.makeConstraints{
            $0.leading.equalTo(moodLabel.snp.trailing)
            $0.top.bottom.trailing.equalToSuperview()
        }
        
        textContainer.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.height.equalTo(180)
            $0.top.equalTo(stackView.snp.bottom)
        }
        
        recordButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
        }
        
        textView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            $0.top.equalTo(recordButton.snp.bottom).offset(10)
        }
        
        translateButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
            $0.top.equalToSuperview()
            $0.right.equalToSuperview().inset(16)
        }
        
        exampleRecogBgView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        exampleRecogContainer.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(180)
        }
        
        exampleTextView.snp.makeConstraints{
            $0.left.bottom.right.equalToSuperview().inset(16)
            $0.height.equalTo(120)
        }
        
        exampleButtonContainer.snp.makeConstraints{
            $0.left.right.top.equalToSuperview()
            $0.bottom.equalTo(exampleTextView.snp.top)
        }
        
        cancelButton.snp.makeConstraints{
            $0.left.equalToSuperview().inset(16)
            $0.width.equalTo(50)
            $0.centerY.equalToSuperview()
        }
        
        exampleRecogButton.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        applyButton.snp.makeConstraints{
            $0.right.equalToSuperview().inset(16)
            $0.width.equalTo(50)
            $0.centerY.equalToSuperview()
        }
        
    }
    
    public override func bind() {
        // 음성인식 gogo
        recordButton.rx.tapGesture()
            .when(.recognized)
            .bind {[weak self] _ in
                guard let self = self else { return }
                self.exampleRecogBgView.isHidden = false
            }
            .disposed(by: disposeBag)
        
        // 번역
        translateButton.rx.tapGesture()
            .when(.recognized)
            .bind {[weak self] _ in
//                self?.speechRecognizer?.stopRecording()
                self?.translate(self?.textView.text ?? "")
//                self?.detect(self?.textView.text ?? "")
//                self?.translateAfterDetect(self?.textView.text ?? "")
            }
            .disposed(by: disposeBag)
        
        // 음성인식 시작 or 종료
        exampleRecogButton.rx.tapGesture()
            .when(.recognized)
            .bind {[weak self] _ in
                guard let self = self else { return }
                self.speechRecognizer?.speechToText()
            }
            .disposed(by: disposeBag)
        
        // 취소
        cancelButton.rx.tapGesture()
            .when(.recognized)
            .bind {[weak self] _ in
                guard let self = self else { return }
                self.exampleRecogBgView.isHidden = true
                self.speechRecognizer?.stopRecording()
            }
            .disposed(by: disposeBag)
        
        // 적용
        applyButton.rx.tapGesture()
            .when(.recognized)
            .bind {[weak self] _ in
                guard let self = self else { return }
                self.exampleRecogBgView.isHidden = true
                self.textView.text += self.exampleTextView.text
                self.speechRecognizer?.stopRecording()
            }
            .disposed(by: disposeBag)
        

        
        viewModel.bookmark.bind{ [weak self] data in
            guard let self = self else { return }
            
            self.dateTitle.text = data.date
            self.mood.text = data.mood.mood.emoticon
            self.address.text = data.location.address
            self.weather.text = data.weather.weather.emoticon
            self.textView.text = data.note
        }.disposed(by: disposeBag)
        
    }
    
    public func recognizeStop() {
        exampleRecogButton.isEnabled = false
        exampleRecogButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        exampleRecogButton.tintColor = .blue
        
        exampleTextView.text = ""
    }
    
    public func recognizeStart() {
        exampleRecogButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        exampleRecogButton.tintColor = .red
    }
    
    public func recognizing(text: String?) {
        guard let text = text else { return }
        Log.d(text)
        exampleTextView.text = text
    }
    
    public func recognizePause() {
        exampleRecogButton.isEnabled = true
    }
    
    func detect(_ text: String){
        GoogleTranslater.shared.detect(text) { (detections, error) in
            if let detections = detections {
                for detection in detections {
                    print(detection.language)
                    print(detection.isReliable)
                    print(detection.confidence)
                    print("---")
                }
            }
        }
    }
    
    func translate(_ text: String){
        GoogleTranslater.shared.translate(text, "en") {[weak self] (text, error) in
            guard let self = self,
                  let text = text else { return }
            DispatchQueue.main.async {
                self.textView.text = text
            }
        }
    }
    
    func translateAfterDetect(_ text: String){
        GoogleTranslater.shared.translateAfterDetect(text){[weak self] (text, error) in
            guard let self = self,
                  let text = text else { return }
            DispatchQueue.main.async {
                self.textView.text = text
            }
        }
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustOnKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustOnKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func adjustOnKeyboard(notification: NSNotification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let keyboardDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) else { return }
        let keyboardHeight = self.view.safeAreaInsets.bottom - keyboardRect.height + 150
        
        switch notification.name {
        case UIResponder.keyboardWillShowNotification:
            keyboardAnimation(duration: keyboardDuration, keyboardHeight: keyboardHeight)
            
        case UIResponder.keyboardWillHideNotification:
            keyboardAnimation(duration: keyboardDuration)
        default:
            break
        }
    }
    
    private func keyboardAnimation(duration: Double, keyboardHeight: CGFloat = 0.0) {
        UIView.animate(withDuration: duration) {
            self.view.frame.origin.y = keyboardHeight
        }
    }
    
    public override func moreAction() {
        
    }
    
    public override func deinitAction() {
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    deinit {
        print("WriteDiaryViewController deinit")
    }
}
