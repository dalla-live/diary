//
//  MainCoordinator.swift
//  AppTests
//
//  Created by inforex_imac on 2022/09/13.
//

import UIKit
import Design
import SnapKit
import RxSwift
import RxCocoa
import RxGesture
import Util



public class MainCoordinator: Coordinator {
    public var childCoordinator: [Coordinator] = []
    
    public var coordinator : DiaryTabbarController
    
    var disposeBag: DisposeBag = .init()
    
    public init(coordinator: DiaryTabbarController) {
        self.coordinator = coordinator
    }
    
    public func start(){
        // 인디케이터 부터..
        serviceInit()
    }
    
    /**
     네비게이션컨트롤러를 생성한다
     - Parameters: -
     - Returns: UINavigationController
     */
    func getNavigation() -> UINavigationController{
        let navigation = UINavigationController()
            navigation.setToolbarHidden(true, animated: false)
            navigation.setNavigationBarHidden(true, animated: false)
        return navigation
    }
    
    func serviceInit() {
        // 인디케이터 끝나고
        let vc1 = getNavigation()
        let vc2 = getNavigation()
        let vc3 = getNavigation()
        
        let bookMarkCoordinator = BookmarkCoordinator(navigation: vc1)
        let mapCoordinator      = MapCoordinator(navigation: vc2)
            mapCoordinator.coordinator = self
        let diaryCoordinator    = DiaryCoordinator(navigation: vc3)
        
        vc1.tabBarItem = UITabBarItem(title: TabMenu.bookMark.title, image: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill"))
        vc2.tabBarItem = UITabBarItem(title: TabMenu.map.title, image: UIImage(systemName: "location.north.circle"), selectedImage: UIImage(systemName: "location.north.circle.fill"))
        vc3.tabBarItem = UITabBarItem(title: TabMenu.diary.title, image: UIImage(systemName: "pencil.circle"), selectedImage: UIImage(systemName: "pencil.circle.fill"))
        
        
        
        childCoordinator = [bookMarkCoordinator, mapCoordinator, diaryCoordinator]
        
        coordinator.viewControllers = [vc1, vc2, vc3]
        coordinator.modalPresentationStyle = .fullScreen
        coordinator.selectedIndex          = 1
        
        bookMarkCoordinator.start()
        mapCoordinator.start()
        diaryCoordinator.start()
    }
}
class TestSubView: UIView {
    public func open() {
        Log.d("test")
    }
}

extension MainCoordinator: LayerProvider {
    
    public func presentFullScreenLayer() {
        let vc = UIViewController.init()
            vc.modalPresentationStyle = .overFullScreen

        let img = UIImageView(image: UIImage(systemName: "xmark"))
            img.tintColor = .darkGray
            vc.view.addSubview(img)

        img.snp.makeConstraints{
            $0.width.height.equalTo(30)
            $0.top.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }


        vc.hidesBottomBarWhenPushed = true
        vc.view.backgroundColor = .black
        self.coordinator.present(vc, animated: true)

        img.rx.tapGesture()
            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                // 약한참조 처리
                guard let `self` = self else {
                    return
                }
                vc.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
}

