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

public final class WriteDiaryViewController: ProgrammaticallyViewController {
    
    var coordinator: DiaryCoordinator?
    private var viewModel: WriteDiaryViewModel!
    
    // ViewController 의존성 주입을 위한 create
    public static func create(viewModel: WriteDiaryViewModel, coordinator: DiaryCoordinator) -> WriteDiaryViewController {
        let vc = WriteDiaryViewController()
            vc.viewModel = viewModel
            vc.coordinator = coordinator
        
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .green
//        self.navigationController?.popViewController(animated: false)
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
        print("WriteDiaryViewController deinit")
    }
}
