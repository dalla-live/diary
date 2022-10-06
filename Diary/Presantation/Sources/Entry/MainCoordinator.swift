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

public protocol MainCoordinatorDependencies {
    func makeBookmarkCoordinator(navigationController: UINavigationController)-> BookmarkCoordinator
    func makePlaceCoordinator(navigationController: UINavigationController)-> PlaceCoordinator
    func makeDiaryCoordinator(navigationController: UINavigationController)-> DiaryCoordinator
    func makeVideoCoordinator(navigationController: UINavigationController)-> VideoCoordinator
}

public class MainCoordinator: Coordinator {
    public var childCoordinator: [Coordinator] = []
    
    public var coordinator : DiaryTabbarController
    
    private let dependencies: MainCoordinatorDependencies
    
    var disposeBag: DisposeBag = .init()
    
    public init(coordinator: DiaryTabbarController,
                dependencies: MainCoordinatorDependencies) {
        self.coordinator = coordinator
        self.dependencies = dependencies
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
        let vc4 = getNavigation()
        
        let bookMarkCoordinator = dependencies.makeBookmarkCoordinator(navigationController: vc1)
        let mapCoordinator      = dependencies.makePlaceCoordinator(navigationController: vc2)
            mapCoordinator.coordinator = self
        let diaryCoordinator    = dependencies.makeDiaryCoordinator(navigationController: vc3)
        let videoCoordinator    = dependencies.makeVideoCoordinator(navigationController: vc4)
        
        var image: (deselected: UIImage?, selected: UIImage?) {
            if #available(iOS 15.0, *) {
                return (UIImage(systemName: "location.north.circle"), UIImage(systemName: "location.north.circle.fill"))
            } else {
                return (UIImage(systemName: "location.north"), UIImage(systemName: "location.north.fill"))
            }
        }
        
        vc1.tabBarItem = UITabBarItem(title: TabMenu.bookMark.title, image: UIImage(systemName: "bookmark"), selectedImage: UIImage(systemName: "bookmark.fill"))
        vc2.tabBarItem = UITabBarItem(title: TabMenu.map.title, image: image.deselected, selectedImage: image.selected)
        vc3.tabBarItem = UITabBarItem(title: TabMenu.diary.title, image: UIImage(systemName: "pencil.circle"), selectedImage: UIImage(systemName: "pencil.circle.fill"))
        vc4.tabBarItem = UITabBarItem(title: TabMenu.video.title, image: UIImage(systemName: "video"), selectedImage: UIImage(systemName: "video.fill"))
        
        
        
        childCoordinator = [bookMarkCoordinator, mapCoordinator, diaryCoordinator, videoCoordinator]
        
        coordinator.viewControllers = [vc1, vc2, vc3, vc4]
        coordinator.modalPresentationStyle = .fullScreen
        coordinator.selectedIndex          = 1
        
        bookMarkCoordinator.start()
        mapCoordinator.start()
        diaryCoordinator.start()
        videoCoordinator.start()
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


