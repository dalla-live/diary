//
//  MapCoordinator.swift
//  AppTests
//
//  Created by inforex_imac on 2022/09/13.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import RxGesture
import Util

class MapCoordinator: Coordinator {
    var childCoordinator: [Coordinator]  = []
    var navigationController: UINavigationController
    weak var coordinator : MainCoordinator?
    init(navigation: UINavigationController) {
        navigationController = navigation
        navigation.view.backgroundColor = .blue
    }
    
    func start() {
        let mapVc = MapViewController()
            mapVc.coordinator = self
        self.navigationController.pushViewController(mapVc, animated: false)
        mapVc.view.backgroundColor = .darkGray
        print(#file)
    }
    
    deinit {
        print(#file)
    }
}

extension MapCoordinator: MapViewDelegate {
    public func openWindow() {
        coordinator?.presentFullScreenLayer()
    }
}



public protocol MapViewDelegate: AnyObject {
    func openWindow()
}

public class MapViewController: UIViewController {
    weak var coordinator: MapViewDelegate?
    
    var disposeBag: DisposeBag = .init()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIView()
        let text = UILabel()
        
        btn.addSubview(text)
        text.text = "누르면 전체 뷰"
        view.addSubview(btn)
        text.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
        btn.snp.makeConstraints{
            $0.width.height.equalTo(100)
            $0.center.equalToSuperview()
        }
        
        
        btn.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                
            self?.coordinator?.openWindow()
                
        }).disposed(by: disposeBag)

    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
}
