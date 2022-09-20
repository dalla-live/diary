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
import GoogleMaps
import Service


class MapViewController: UIViewController {
    
    weak var coordinator: MapViewDelegate?
    var disposeBag: DisposeBag = .init()
    var viewModel : MapViewModel
    var service: MapService!
    
    
    init ( dependency: MapViewModel, service: MapService ) {
        self.viewModel = dependency
        self.service   = service
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
         fatalError("init(coder:) is not supported")
     }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setConstraint()
        
        
        self.viewModel.viewDidLoad()
        
        setInput()
        setOutput()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setLayout() {
        self.view.addSubview(viewModel.layoutModel._MAP_CONTAINER)
        self.view.addSubview(viewModel.layoutModel._BUTTON_CONTAINER)
        
        self.setMapView()
    }
    
    
    func setMapView() {
        guard let view = service?.mapUI else {
            return
        }
        
        viewModel.layoutModel._MAP_CONTAINER.addSubview(view)
    }
    
    func setConstraint() {
        viewModel.layoutModel._MAP_CONTAINER.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        viewModel.layoutModel._BUTTON_CONTAINER.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        self.service?.mapUI?.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func setInput() {
        
    }
    
   
    
    func setOutput() {
        viewModel.openWindow.subscribe(onNext: { _ in
            self.coordinator?.openWindow()
        }).disposed(by: disposeBag)
    }
    
    
}
