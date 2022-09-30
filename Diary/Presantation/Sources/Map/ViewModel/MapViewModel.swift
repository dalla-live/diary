//
//  MapViewModel.swift
//  Presantation
//
//  Created by inforex_imac on 2022/09/14.
//

import Foundation
import RxSwift
import RxCocoa
import Then
import SnapKit
import RxGesture
import Util
import Domain
import Service
import GoogleMapsUtils
import GoogleMaps

//struct MapUseCases {
//    var
//}

// 무엇을 했다
protocol MapViewModelInput {
    func didLoadList(startLocation : CLLocationCoordinate2D, endLocation : CLLocationCoordinate2D)
//    func didSubMenu(selected: MapSubMenu)          // 상단 서브메뉴 토글
//    func showQuickBookmark()                           // 빠른 북마크 보기
//    func didFloating(selected: MapQuickMenu)   // 하단 플루팅 버튼
    func didSelectBookmark(indexPath: IndexPath, completion: @escaping (CLLocationCoordinate2D) -> Void)                       // 북마크 깃발
//    func didOpenBookmarkDetail()                       // 북마크 상세보기 선택
}
struct TestPlace {
    let date: String
    let contents: String
    let distance: String
    let location : CLLocationCoordinate2D
}

protocol MapViewModelOutput {
    var mapData : [TestPlace] {get}
    var didItemLoaded: PublishSubject<Void> { get }
}

enum MapType {
    case google, naver
}

enum MapSubMenu {
    case map, list
}

enum MapQuickMenu {
    case search
    case addBookmark
    case toggle
}


public class MapViewModel: NSObject , MapViewModelOutput{
    var didItemLoaded: PublishSubject<Void> = .init()
        
    
    var mapData : [TestPlace] = [] {
            didSet {
                self.didItemLoaded.onNext(())
            }
        }
    
    
    // for Repository
    var mapUseCase : PlaceUseCase!
    
    init(mapUseCase: PlaceUseCase) {
        self.mapUseCase      = mapUseCase
    }
    
    
    var disposeBag: DisposeBag = .init()
    
    // MARK: @ Output
    var openWindow = PublishSubject<Bool>()
    
    
    func viewDidLoad() {
        
    }
  
    
    // test func 인터페이스 호출
    public func showFullScreenWindow() {
        
        self.openWindow.onNext(true)
    }
    
}

extension MapViewModel: MapViewModelInput{
    
    func didLoadList(startLocation : CLLocationCoordinate2D, endLocation : CLLocationCoordinate2D) {
        self.mapData = [
            TestPlace(date: "2020-10-01", contents: "이것은", distance: "위치 40km", location: .init(latitude: 2, longitude: 2)),
            TestPlace(date: "2020-10-02", contents: "이것은", distance: "위치 40km", location: .init(latitude: 3, longitude: 2)),
            TestPlace(date: "2020-10-03", contents: "이것은", distance: "위치 40km", location: .init(latitude: 4, longitude: 2)),
            TestPlace(date: "2020-10-04", contents: "이것은", distance: "위치 40km", location: .init(latitude: 25, longitude: 2)),
            TestPlace(date: "2020-10-05", contents: "이것은", distance: "위치 40km", location: .init(latitude: 26, longitude: 2)),
            TestPlace(date: "2020-10-06", contents: "이것은", distance: "위치 40km", location: .init(latitude: 27, longitude: 2)),
            TestPlace(date: "2020-10-07", contents: "이것은", distance: "위치 40km", location: .init(latitude: 28, longitude: 2)),
            TestPlace(date: "2020-10-08", contents: "이것은", distance: "위치 40km", location: .init(latitude: 29, longitude: 2)),
            TestPlace(date: "2020-10-09", contents: "이것은", distance: "위치 40km", location: .init(latitude: 20, longitude: 2)),
            TestPlace(date: "2020-10-10", contents: "이것은", distance: "위치 40km", location: .init(latitude: 31, longitude: 2)),
            TestPlace(date: "2020-10-11", contents: "이것은", distance: "위치 40km", location: .init(latitude: 32, longitude: 2)),
            TestPlace(date: "2020-10-12", contents: "이것은", distance: "위치 40km", location: .init(latitude: 33, longitude: 2)),
            TestPlace(date: "2020-10-13", contents: "이것은", distance: "위치 40km", location: .init(latitude: 34, longitude: 2)),
            TestPlace(date: "2020-10-14", contents: "이것은", distance: "위치 40km", location: .init(latitude: 35, longitude: 2)),
            TestPlace(date: "2020-10-15", contents: "이것은", distance: "위치 40km", location: .init(latitude: 36, longitude: 2)),
            TestPlace(date: "2020-10-16", contents: "이것은", distance: "위치 40km", location: .init(latitude: 37, longitude: 2)),
            TestPlace(date: "2020-10-17", contents: "이것은", distance: "위치 40km", location: .init(latitude: 38, longitude: 2)),
        ]
    }
    
    func didSelectBookmark(indexPath: IndexPath, completion: @escaping ((CLLocationCoordinate2D) -> Void) ) {
        completion(self.mapData[indexPath.row].location)
    }
    
    
//    func didSubMenu(selected: MapSubMenu) {
//        
//    }
//    
//    func showQuickBookmark() {
//        
//    }
//    
//    func didFloating(selected: MapQuickMenu) {
//        
//    }
//    
//    func didSelectBookmarkFlag() {
//        
//    }
//    
//    func didOpenBookmarkDetail() {
//        
//    }
}

