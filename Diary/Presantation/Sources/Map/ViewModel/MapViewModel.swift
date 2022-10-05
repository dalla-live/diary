//
//  PlaceViewModel.swift
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


// 무엇을 했다
protocol PlaceViewModelInput {
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

protocol PlaceViewModelOutput {
    var mapData : [Bookmark] {get}
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


public class PlaceViewModel: NSObject , PlaceViewModelOutput{
    var didItemLoaded: PublishSubject<Void> = .init()
    
    // 엔티티 리스트
    var mapData : [Bookmark] = [] {
            didSet {
                self.didItemLoaded.onNext(())
            }
        }
    
    
    // for Repository
    var placeUseCase : PlaceUseCase!
    
    public init(placeUseCase: PlaceUseCase) {
        self.placeUseCase      = placeUseCase
    }
    
    
    var disposeBag: DisposeBag = .init()
    
    // MARK: @ Output
    var openWindow = PublishSubject<Bool>()
    
    
    func viewDidLoad() {
        self.fetchList()
    }
  
    
    // test func 인터페이스 호출
    public func showFullScreenWindow() {
        
        self.openWindow.onNext(true)
    }
    
    public func fetchList(){
        self.placeUseCase.search(requestVo: .init(type: .all), completion: { list in
            switch list {
            case .success(let bookMark):
                self.mapData = bookMark.bookmarks
            case .failure(let err):
                Log.d(err.localizedDescription)
            }
        })
    }
    
}

extension PlaceViewModel: PlaceViewModelInput{
    
    func didLoadList(startLocation : CLLocationCoordinate2D, endLocation : CLLocationCoordinate2D) {
        // 엔티티 리스트
    }
    
    func didSelectBookmark(indexPath: IndexPath, completion: @escaping ((CLLocationCoordinate2D) -> Void) ) {
        let location = CLLocationCoordinate2D(latitude: self.mapData[indexPath.row].location.lat, longitude: self.mapData[indexPath.row].location.lon)
        completion(location)
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

