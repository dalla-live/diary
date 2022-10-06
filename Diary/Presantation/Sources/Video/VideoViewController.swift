//
//  VideoViewController.swift
//  Presantation
//
//  Created by inforex on 2022/10/04.
//

import Foundation
import UIKit
import RxSwift
import Util
import AVKit
import Domain
import Service

public final class VideoViewController: ProgrammaticallyViewController {
    private var viewModel: VideoViewModel!
    
    public static func create(viewModel: VideoViewModel) -> VideoViewController {
        let vc = VideoViewController()
        vc.viewModel = viewModel
        
        return vc
    }
    let container = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor(r: 172, g: 172, b: 172).cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
    }
    
    let btnBgImgView = UIImageView().then{
        $0.image = PresantationAsset.back.image
    }
    
    // MARK: Component
    let addButton = UIButton().then{
        $0.setImage(PresantationAsset.plus.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24
    }
    
    let findVideoLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .medium)
        $0.textColor = UIColor(r: 32, g: 32, b: 32)
        $0.text = "자막 생성할 동영상 찾기"
    }
    
    let translateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = UIColor(r: 255, g: 60, b: 123)
        $0.text = "디바이스 언어로 번역하기"
    }
    
    let translateSwitch = UISwitch().then{
        $0.tintColor = .black
        $0.thumbTintColor = .white
        $0.onTintColor = UIColor(r: 255, g: 60, b: 123)
        $0.backgroundColor = .clear
    }
    
    let imagePickerViewController = UIImagePickerController().then{
        $0.mediaTypes = ["public.movie"]
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerViewController.delegate = self
        
        viewModelOutputBind()
    }
    
    public override func addComponent() {
        fileName = #file.fileName
        
        [btnBgImgView, addButton, findVideoLabel].forEach(container.addSubview)
        
        [container, translateLabel, translateSwitch].forEach(view.addSubview)
    }
    
    public override func setConstraints() {
        container.snp.makeConstraints{
            $0.height.equalTo(86)
            $0.left.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        addButton.snp.makeConstraints{
            $0.left.equalToSuperview().inset(19)
            $0.size.equalTo(48)
            $0.centerY.equalToSuperview()
        }
        
        btnBgImgView.snp.makeConstraints{
            $0.size.equalTo(52)
            $0.center.equalTo(addButton)
        }
        
        findVideoLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalTo(addButton.snp.right).offset(10)
        }
        
        translateLabel.snp.makeConstraints{
            $0.left.equalToSuperview().inset(16)
            $0.top.equalTo(container.snp.bottom).offset(15)
        }
        
        translateSwitch.snp.makeConstraints{
            $0.centerY.equalTo(translateLabel)
            $0.right.equalToSuperview().inset(16)
        }
    }
    
    public override func bind() {
        container.rx.tapGesture()
            .when(.recognized)
            .bind {[weak self] _ in
                self?.showAlbum()
            }.disposed(by: disposeBag)
    }
    
    func showAlbum(){
        let type = UIImagePickerController.SourceType.photoLibrary
        guard UIImagePickerController.isSourceTypeAvailable(type) else { return } // 현재 기기에서 가능한지 확인하는 부분
        
        imagePickerViewController.sourceType = type
        imagePickerViewController.view.hideToastActivity()
        present(imagePickerViewController, animated: true, completion: nil)
    }
    
    public override func moreAction() {
        
    }
    
    public override func deinitAction() {
        
    }
    
    public func viewModelOutputBind() {
        viewModel.subtitleData.subscribe(onNext: {[weak self] subtitleData, fileUrl in
            guard let self = self else { return }
            self.dismissImagePicker()
            if subtitleData.result == "COMPLETED"{
                self.presentAVPlayer(subtitleData, fileUrl)
            }
        }).disposed(by: disposeBag)
        
        viewModel.errorMessage.subscribe(onNext: {[weak self] message in
            self?.dismissImagePicker()
            self?.view.makeToast(message)
        }).disposed(by: disposeBag)
    }
    
    func presentAVPlayer(_ subtitleData: SubtitleData, _ url: URL){
        let moviePlayer = AVPlayerViewController()
        moviePlayer.player = AVPlayer(url: url)
        self.present(moviePlayer, animated: true, completion: nil)
        
        moviePlayer.addSubtitles()
        moviePlayer.show(subtitles: subtitleData.segments, isTranslate: translateSwitch.isOn)
        
        // Change text properties
//        moviePlayer.subtitleLabel?.textColor = UIColor.white
        // Play
        moviePlayer.player?.play()
    }
    
    func dismissImagePicker(){
        self.imagePickerViewController.view.hideToastActivity()
        self.imagePickerViewController.dismiss(animated: false)
    }
    
    deinit {
        print("VideoViewController deinit")
    }
}

extension VideoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL{
            Log.d(videoURL)
            viewModel.requestVideoSubtitle(url: videoURL)
            picker.view.makeToastActivity(.center)
        }
    }
}
