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
    
    deinit {
        print("VideoViewController deinit")
    }
}

extension VideoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("고름")
    }
}
