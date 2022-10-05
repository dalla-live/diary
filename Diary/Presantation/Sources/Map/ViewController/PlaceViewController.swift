//
//  PlaceViewController.swift
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
import GooglePlaces
import Util
import NMapsMap
import Domain

public class PlaceViewController: UIViewController {
    
    var coordinator: PlaceDelegate?
    var disposeBag: DisposeBag = .init()
    var viewModel : PlaceViewModel
    var mapService : (any MapService)?
    
    var googleService: (any MapService)?
    var naverService : (any MapService)?
    
    var layoutModel = MapLayoutModel()
    
    private lazy var contentView: UIImageView = {
       return UIImageView(image: UIImage(named: "plus.app"))
     }()
    
    
    public init ( dependency: PlaceViewModel ) {
        self.viewModel = dependency
        super.init(nibName: nil, bundle: nil)

        self.googleService = GoogleMapServiceProvider(service: GPSLocationServiceProvider(), delegate: self)
        self.naverService  = NaverMapServiceProvider(service:  GPSLocationServiceProvider())

        GMSPlacesClient.provideAPIKey("AIzaSyCufAiUM6o1EKSLquAZtZGa8WVRgr2iEiY")
        GMSServices.provideAPIKey("AIzaSyCufAiUM6o1EKSLquAZtZGa8WVRgr2iEiY")
    }
    
    required init?(coder: NSCoder) {
         fatalError("init(coder:) is not supported")
     }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        
        setLayout()
        layoutModel.viewDidLoad(container: self.view)
        
        setConstraint()
        
        self.viewModel.viewDidLoad()
        
        bindToViewModel()
        btnBind()
        
        layoutModel._SUBMENU_SEGMENT.selectedSegmentIndex = 0
        self.mapService                                   = googleService
        
        bindToViewModel()
    }
    
    public func bindToViewModel() {
        
        // 테이블 로드
        self.viewModel.didItemLoaded.subscribe(onNext: { [weak self] _ in
            self?.reloadList()
            Log.d("reloaded")
        }).disposed(by: disposeBag)
        
        // 위치의 날씨
        self.viewModel.weatherLoded.subscribe(onNext: { [weak self] _ in
            self?.layoutModel.setToolTipWith(weather: self?.viewModel.weather)
        }).disposed(by: disposeBag)
        
        
        // 셀이 선택된 경우
        self.viewModel.didBookmarkSelected.subscribe(onNext: { [weak self] _ in
            let mapData = self?.viewModel.selectedBookmarkData
            
            self?.layoutModel.setToolTipWith(weather: mapData?.weather, mood: mapData?.mood)
        }).disposed(by: disposeBag)
        
    }
    
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setDelegate() {
        layoutModel._QUICK_LIST_TABLE.delegate   = self
        layoutModel._QUICK_LIST_TABLE.dataSource = self
    }
    
    func setLayout() {
        guard let googleView = googleService?.getMapView() as? UIView else { return }
        guard let naverView  = naverService?.getMapView() as? UIView else { return }
        
        layoutModel._MAP_CONTAINER.addSubview(googleView)
        layoutModel._NAVER_MAP_CONTAINER.addSubview(naverView)
    }
    
    func setConstraint() {
        guard let googleView = googleService?.getMapView() as? UIView else { return }
        guard let naverView  = naverService?.getMapView() as? UIView else { return }
        
        layoutModel._MAP_CONTENT_CONTAINER.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        layoutModel._MAP_SCROLL_CONTAINER.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        googleView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        naverView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        layoutModel.setConstraint(container: self.view)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // 현재 위치로
    func didMoveCurrentLocation(){
        layoutModel._CURRENT_LOCATION_BUTTON.rx.tapGesture()
            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                let _ = self?.googleService?.setCurrentLocation()
            })
            .disposed(by: disposeBag)
    }
    
    // 마커 위치 북마크에 추가
    fileprivate func didOpenAddBookmark() {
        layoutModel._FLOATING_ADD_BUTTON.rx.tapGesture()
            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.coordinator?.openMapViewEdit()
            })
            .disposed(by: disposeBag)
    }
    
    // 장소 점색
    fileprivate func didOpenSearchView() {
        
        layoutModel._FLOATING_SEARCH_BUTTON.rx.tapGesture()
            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.autocompleteClicked()
            })
            .disposed(by: disposeBag)
    }
    
    // 퀵리스트 버튼 이벤트
    fileprivate func didSlideQuickList() {
        var lastPosition = 0
        var isFirst = true
        
        layoutModel._QUICK_LIST_BUTTON.rx.panGesture().when(.changed, .ended)
            .subscribe(onNext: { [weak self] gesture in
                guard let `self` = self else {
                    return
                }
                
                let trans         = gesture.translation(in: self.view)
                let openedWidth   = (self.layoutModel._QUICK_LIST.frame.width / 2)
                let movedDistance = self.layoutModel._QUICK_LIST.transform.tx.magnitude + trans.x.magnitude
                var transX        = -min(movedDistance, openedWidth)
                
                if trans.x > 0 {
                    lastPosition = 1
                    transX       = min((self.layoutModel._QUICK_LIST.transform.tx + trans.x), 0)
                } else if trans.x < 0 {
                    lastPosition = -1
                }
                
                if gesture.state == .ended {
                    return self.layoutModel.setTransformAction(toOriginX: lastPosition < 0 ? -openedWidth : 0 , state: gesture.state, isFirst: &isFirst)
                }
                
                self.layoutModel.setTransformAction(toOriginX: transX , state: gesture.state, isFirst: &isFirst)
                
                gesture.setTranslation(.zero, in: self.view)
            })
            .disposed(by: disposeBag)
    }
    
    
    
    func toggleMapView(selectedIndex: Int) {
        
        switch selectedIndex {
        case 0 :
            //구글
            self.layoutModel._MAP_SCROLL_CONTAINER.setContentOffset(self.layoutModel._MAP_CONTAINER.frame.origin, animated: true)
            self.mapService = self.googleService
        case 1 :
            //네이버
            self.layoutModel._MAP_SCROLL_CONTAINER.setContentOffset(self.layoutModel._NAVER_MAP_CONTAINER.frame.origin, animated: true)
            self.mapService = self.naverService
        default:
            return
        }
    }
    
    fileprivate func didSwitchMap() {
        layoutModel._SUBMENU_SEGMENT.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] _ in
                // 약한참조 처리
                guard let `self` = self else {
                    return
                }
                self.toggleMapView(selectedIndex: self.layoutModel._SUBMENU_SEGMENT.selectedSegmentIndex)
            })
            .disposed(by: disposeBag)
    }
    
    fileprivate func didSwitchLaguageButtonTap() {
        layoutModel._LANGUAGE_CHANGE_BUTTON.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let picker = LocalizePickerView()
                self.tabBarController?.view?.addSubview(picker)
                picker.snp.makeConstraints {
                    $0.height.equalTo(250)
                    $0.left.right.bottom.equalToSuperview()
                }
            })
            .disposed(by: disposeBag)
        
        Localize.newState.subscribe(onNext: { [weak self] language in
            guard let self = self else { return }
            self.layoutModel._SUBMENU_SEGMENT.setTitle("google".localized, forSegmentAt: 0)
            self.layoutModel._SUBMENU_SEGMENT.setTitle("naver".localized, forSegmentAt: 1)
            self.layoutModel._LANGUAGE_CHANGE_BUTTON.setTitle("changeLanguageBtn".localized, for: .normal)
        })
        .disposed(by: disposeBag)
    }
    
    func btnBind() {
        // 현재위치로 이동
        didMoveCurrentLocation()
        
        // 북마크 추가 버튼
        didOpenAddBookmark()
        
        // 검색 버튼
        didOpenSearchView()
        
        // 퀵리스트 토글
        didSlideQuickList()
        
        // 네이버, 구글 맵 토글
        didSwitchMap()
        
        didSwitchLaguageButtonTap()
    }
    
    
    func reloadList() {
        self.viewModel.fetchList()
    }
    
    // Present the Autocomplete view controller when the button is pressed.
      func autocompleteClicked() {
        let autocompleteController = GMSAutocompleteViewController()
          autocompleteController.delegate = self

        // Specify the place data types to return.
        let fields: GMSPlaceField =  [.name, .formattedAddress, .coordinate]
          autocompleteController.placeFields = fields
          
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
            filter.types = []
        autocompleteController.autocompleteFilter = filter

        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
      }
}

extension PlaceViewController: GMSAutocompleteViewControllerDelegate {
    
     public func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//         print("place \(place.coordinate)")
         self.googleService?.setLocation(position: place.coordinate)
         self.naverService?.setLocation(position: place.coordinate)
       dismiss(animated: true, completion: nil)
     }

    public func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
       // TODO: handle the error.
       print("Error: ", error.localizedDescription)
     }

     // User canceled the operation.
    public func wasCancelled(_ viewController: GMSAutocompleteViewController) {
       dismiss(animated: true, completion: nil)
     }

     // Turn the network activity indicator on and off again.
    public func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//       UIApplication.shared.isNetworkActivityIndicatorVisible = true
     }

    public func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//       UIApplication.shared.isNetworkActivityIndicatorVisible = false
     }
}

extension PlaceViewController : GMSMapViewDelegate {
    public func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        layoutModel._BOOK_MARK_TOOL_TIP.subviews.forEach{$0.removeFromSuperview()}
        layoutModel._BOOK_MARK_TOOL_TIP.isHidden = true
    }
    
    public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.viewModel.didSelectMarker(location: marker.position)
        mapView.animate(toLocation: marker.position)
        return true
    }

    public func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        print("didTap")
    }
    
    
    public func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print(mapView.camera.target)
        mapService?.setLocation(position: mapView.camera.target)
    }
    
    public func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        print(mapView.camera.target)
        
        
    }
}

extension PlaceViewController: UITableViewDelegate {
    
}

extension PlaceViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mapData.count
    }
    
    
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // 먼저 선택한 셀이 있다
        if let row = tableView.indexPathForSelectedRow, let cell = tableView.cellForRow(at: row) {
            UIView.animate(withDuration: 0.3 , delay: 0, animations: {
                cell.transform = .identity
            })
            
            if row == indexPath {
                return nil
            }
        }
        
        return indexPath
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let mapService = self.mapService else {
            return
        }
        
        if let row = tableView.indexPathForSelectedRow, let cell = tableView.cellForRow(at: row) {
            UIView.animate(withDuration: 0.3 , delay: 0, animations: {
                cell.transform = .init(translationX: 20, y: 0)
            })
        }
        
        self.viewModel.didSelectBookmark(indexPath: indexPath, completion: mapService.setLocation)
    }
    
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell                      = UITableViewCell()
       
        if #available(iOS 14.0, *) {
            // IOS 14 : UIListContentConfiguration
            // IOS 14 : UIBackgroundConfiguration
            var content                           = cell.defaultContentConfiguration()

            let row                               = viewModel.mapData[indexPath.row]
            Log.d(row.mood.mood.text)
                content.text                      = row.date + "\n\(row.mood.mood.emoticon) \(row.weather.weather.emoticon)" + "\n\(row.note)"
                content.textProperties.color = .white.withAlphaComponent(0.5)
            
            let containerView                     = content.makeContentView()
                cell.contentView.addSubview(containerView)
                containerView.snp.makeConstraints{
                    $0.edges.equalToSuperview()
                }
            
            var backgroundConfig                  = UIBackgroundConfiguration.listPlainCell()
                backgroundConfig.backgroundColor  = UIColor(r: 51, g: 51, b: 51)
                backgroundConfig.cornerRadius     = 5
                backgroundConfig.backgroundInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                cell.backgroundConfiguration      = backgroundConfig
        } else {
            // Fallback on earlier versions
            cell.textLabel?.text = viewModel.mapData[indexPath.row].note
        }
            

//        switch indexPath.row {
//        case let row where testIndexPathList.contains(where: { $0.row == row }): cell.contentsLabel.numberOfLines = 0
//        default: cell.contentsLabel.numberOfLines = 1
//        }
//
//        cell.readMoreButton.rx.tap
//            .bind { [unowned self] in buttonAction(buttonTitle: cell.readMoreButton.title(for: .normal), indexPath: indexPath) }
//            .disposed(by: cell.disposeBag)
        
        return cell
    }
}


