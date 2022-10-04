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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func addComponent() {
        fileName = #file.fileName
    }
    
    public override func setConstraints() {
        
    }
    
    public override func bind() {
        
    }
    
    public override func moreAction() {
        
    }
    
    public override func deinitAction() {
        
    }
    
    deinit {
        print("VideoViewController deinit")
    }
}
