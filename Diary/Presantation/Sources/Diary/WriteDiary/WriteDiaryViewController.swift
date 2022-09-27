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
    var speechRecognizer = SpeechRecognizer() // TODO: 의존성 주입
    
    // MARK: Component
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
    }
    
    let translateButton = UIButton().then{
        $0.setTitle("번역하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addBorder(width: 1, color: .black)
        $0.layer.cornerRadius = 8
    }
    
    // ViewController 의존성 주입을 위한 create
    public static func create(viewModel: WriteDiaryViewModel, coordinator: DiaryCoordinator) -> WriteDiaryViewController {
        let vc = WriteDiaryViewController()
            vc.viewModel = viewModel
            vc.coordinator = coordinator
        
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

        
        self.speechRecognizer.delegate = self
        self.view.backgroundColor = .white
    }
    
    public override func addComponent() {
        fileName = #file.fileName
        
        [recordButton, textView, translateButton].forEach(view.addSubview)
    }
    
    public override func setConstraints() {
        recordButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
            $0.top.left.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        textView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(10)
            $0.top.equalTo(recordButton.snp.bottom).offset(10)
            $0.height.equalTo(150)
        }
        
        translateButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
            $0.top.right.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    public override func bind() {
        recordButton.rx.tapGesture()
            .when(.recognized)
            .bind {[weak self] _ in
                guard let self = self else { return }
                self.speechRecognizer.speechToText()
            }
            .disposed(by: disposeBag)
        
        translateButton.rx.tapGesture()
            .when(.recognized)
            .bind {[weak self] _ in
                self?.translate(self?.textView.text ?? "")
                self?.detect(self?.textView.text ?? "")
            }
            .disposed(by: disposeBag)
    }
    
    public func recognizeStop() {
        recordButton.isEnabled = false
        recordButton.setTitle("음성인식", for: .normal)
    }
    
    public func recognizeStart() {
        recordButton.setTitle("멈추기", for: .normal)
    }
    
    public func recognizing(text: String?) {
        guard let text = text else { return }
        textView.text = text
    }
    
    public func recognizePause() {
        recordButton.isEnabled = true
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
        // 한국어를 영어로
        GoogleTranslater.shared.translate(text, "en", "ko") {[weak self] (text, error) in
            guard let self = self,
                  let text = text else { return }
            DispatchQueue.main.async {
                self.textView.text = text
            }
        }
    }
    
    
    public override func moreAction() {
        
    }
    
    public override func deinitAction() {
        
    }
    
    deinit {
        print("WriteDiaryViewController deinit")
    }
}
