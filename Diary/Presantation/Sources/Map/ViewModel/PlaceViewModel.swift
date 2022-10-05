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
    func didLoadList(startLocation : CLLocationCoordinate2D, endLocation : CLLocationCoordinate2D)            // 리스트 로드
    func didSelectBookmark(indexPath: IndexPath, completion: @escaping (CLLocationCoordinate2D) -> Void)      // 북마크 깃발
    func didSelectMarker(location: CLLocationCoordinate2D)                                                     //
//    func didSubMenu(selected: MapSubMenu)          // 상단 서브메뉴 토글
//    func didFloating(selected: MapQuickMenu)   // 하단 플루팅 버튼
//    func didOpenBookmarkDetail()                       // 북마크 상세보기 선택
}

protocol PlaceViewModelOutput {
    var mapData : [Bookmark] {get}
    var didItemLoaded: PublishSubject<Void> { get }
    var weatherLoded: PublishSubject<Void> { get }
    var didBookmarkSelected: PublishSubject<Void> { get }
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
    
    /// Output
    var didItemLoaded: PublishSubject<Void>        = .init()
    var weatherLoded: PublishSubject<Void>         = .init()
    var didBookmarkSelected: PublishSubject<Void>  = .init()
    
    // 엔티티 리스트
    var mapData : [Bookmark] = [] {
            didSet {
                self.didItemLoaded.onNext(())
            }
        }
    
    var weather: Weather? = nil {
        didSet {
            self.weatherLoded.onNext(())
        }
    }
    
    // 선택당했다
    var selectedBookmarkData: Bookmark? = nil {
        didSet {
            self.didBookmarkSelected.onNext(())
        }
    }
    
    // for Repository
    var placeUseCase : PlaceUseCase!
    var weatherUseCase: RequestCurrentWeatherUsecase!
    
    public init(placeUseCase: PlaceUseCase, weatherUseCase: RequestCurrentWeatherUsecase) {
        self.placeUseCase   = placeUseCase
        self.weatherUseCase = weatherUseCase
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
        let data = self.mapData[indexPath.row]
        let location = CLLocationCoordinate2D(latitude: data.location.lat, longitude: data.location.lon)
            
        completion(location)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.selectedBookmarkData = data
        })
        
    }
    
    func didSelectMarker(location: CLLocationCoordinate2D) {
        self.weatherUseCase.excute(request: .init(lat: location.latitude, lon: location.longitude, address: ""), completion:{ result in
            switch result {
            case .success(let weather):
                self.weather = Weather(en: weather)
            case .failure(let err):
                print(err)
            }
        })
    }
}

extension PlaceViewModel : NaverMapProtocol {
    func reqNaverMapAddress(_ loc : Location) {
        mapUseCase.reqNaverMapAddress(location: loc, completion: { result in
            
            print("\(#function):\(result)")
            
        })
    }
}
