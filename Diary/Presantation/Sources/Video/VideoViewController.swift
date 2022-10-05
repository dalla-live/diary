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

public final class VideoViewController: ProgrammaticallyViewController {
    private var viewModel: VideoViewModel!
    
    public static func create(viewModel: VideoViewModel) -> VideoViewController {
        let vc = VideoViewController()
        vc.viewModel = viewModel
        
        return vc
    }
    
    // MARK: Component
    let addButton = UIButton().then{
        $0.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        $0.backgroundColor = .black
        $0.setTitleColor(.black, for: .normal)
        $0.addBorder(width: 1, color: .black)
        $0.layer.cornerRadius = 8
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
        
        view.addSubview(addButton)
    }
    
    public override func setConstraints() {
        addButton.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.size.equalTo(70)
        }
    }
    
    public override func bind() {
        addButton.rx.tapGesture()
            .when(.recognized)
            .bind {[weak self] _ in
                self?.showAlbum()
            }.disposed(by: disposeBag)
    }
    
    func showAlbum(){
        let type = UIImagePickerController.SourceType.photoLibrary
        guard UIImagePickerController.isSourceTypeAvailable(type) else { return } // 현재 기기에서 가능한지 확인하는 부분
        
        imagePickerViewController.sourceType = type
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
            self.presentAVPlayer(subtitleData, fileUrl)
        }).disposed(by: disposeBag)
    }
    
    func presentAVPlayer(_ subtitleData: SubtitleData, _ url: URL){
        let moviePlayer = AVPlayerViewController()
        moviePlayer.player = AVPlayer(url: url)
        self.present(moviePlayer, animated: true, completion: nil)
        
        moviePlayer.addSubtitles()
        moviePlayer.show(subtitles: subtitleData.segments)
        
        // Change text properties
        moviePlayer.subtitleLabel?.textColor = UIColor.red
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
