//
//  WriteDiaryViewController.swift
//  Presantation
//
//  Created by inforex on 2022/09/20.
//

import Foundation
import UIKit
import RxSwift

public final class WriteDiaryViewController: UIViewController {
    
    weak var coordinatro: DiaryCoordinator?
    private var viewModel: WriteDiaryViewModel!
    let disposeBag = DisposeBag()
    
    // ViewController 의존성 주입을 위한 create
    public static func create(with viewModel: WriteDiaryViewModel) -> WriteDiaryViewController {
        let vc = WriteDiaryViewController()
        vc.viewModel = viewModel
        
        return vc
    }
    
    public override func viewDidLoad() {
        print("writeDiartViewController!!!!")
    }
}
