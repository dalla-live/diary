//
//  MapViewController.swift
//  Presantation
//
//  Created by inforex_imac on 2022/09/14.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture
import SnapKit

class MapViewController: UIViewController {
    
    weak var coordinator: MapViewDelegate?
    var disposeBag: DisposeBag = .init()
    var viewModel : MapViewModel
    
    
//    var viewService: MapViewService = .init()
    
    init ( dependency: MapViewModel ) {
        self.viewModel = dependency
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
         fatalError("init(coder:) is not supported")
     }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonLayer = UIView()
        self.view.addSubview(buttonLayer)
        buttonLayer.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        self.viewModel.viewDidLoad(parentView: buttonLayer)
        setInput()
        setOutput()
        
        
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setInput() {
        
    }
    
    func setOutput(){
        viewModel.openWindow.subscribe(onNext: { _ in
            self.coordinator?.openWindow()
        }).disposed(by: disposeBag)
    }
}
