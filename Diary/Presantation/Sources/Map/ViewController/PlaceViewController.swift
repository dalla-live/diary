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

class PlaceViewController: UIViewController {
    
    var coordinator: MapViewDelegate?
    var disposeBag: DisposeBag = .init()
    var viewModel : MapViewModel
    
    var service: MapService?
    
    var layoutModel = MapLayoutModel()
    
    private lazy var contentView: UIImageView = {
       return UIImageView(image: UIImage(named: "plus.app"))
     }()
    
    init ( dependency: MapViewModel) {
        self.viewModel = dependency
        super.init(nibName: nil, bundle: nil)
        self.service   = GoogleMapServiceProvider(service: GPSLocationServiceProvider(), delegate: self)
//        GMSPlacesClient.provideAPIKey("AIzaSyCufAiUM6o1EKSLquAZtZGa8WVRgr2iEiY")
    }
    
    required init?(coder: NSCoder) {
         fatalError("init(coder:) is not supported")
     }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setConstraint()
        print(self.view.bounds)
        
        self.viewModel.viewDidLoad()
        
        btnBind()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setLayout() {
        self.view.addSubview(layoutModel._MAP_CONTAINER)
        
        layoutModel.layoutButton(container: self.view)
        
        guard let view = service?.mapUI else {
            return
        }
        
        layoutModel._MAP_CONTAINER.addSubview(view)
    }
    
    func setConstraint() {
        layoutModel.setConstraint(container: self.view)
        self.service?.mapUI?.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        print(UIScreen.main.bounds)
        print(self.view.frame.height)
        print(self.tabBarController?.tabBar.frame.size)
        print(layoutModel._MAP_CONTAINER.frame)
        super.viewDidAppear(animated)
        
        
    }
    func btnBind() {
        // 현재 위치로
        layoutModel._CURRENT_LOCATION_BUTTON.rx.tapGesture()
            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                // 약한참조 처리
                guard let `self` = self else {
                    return
                }
                
                let _ = self.service?.setCurrentLocation()
                print("add tap")
            })
            .disposed(by: disposeBag)
        
        // 마커 위치 북마크에 추가
        layoutModel._FLOATING_ADD_BUTTON.rx.tapGesture()
            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                // 약한참조 처리
                guard let `self` = self else {
                    return
                }
                print("add tap \(self.coordinator)")
                self.coordinator?.openMapViewEdit()
            })
            .disposed(by: disposeBag)
        
        // 장소 점색
        layoutModel._FLOATING_SEARCH_BUTTON.rx.tapGesture()
            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                // 약한참조 처리
                guard let `self` = self else {
                    return
                }
                self.autocompleteClicked()
            })
            .disposed(by: disposeBag)
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
    
     func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//         print("place \(place.coordinate)")
         self.service?.setLocation(position: place.coordinate)
       dismiss(animated: true, completion: nil)
     }

     func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
       // TODO: handle the error.
       print("Error: ", error.localizedDescription)
     }

     // User canceled the operation.
     func wasCancelled(_ viewController: GMSAutocompleteViewController) {
       dismiss(animated: true, completion: nil)
     }

     // Turn the network activity indicator on and off again.
     func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//       UIApplication.shared.isNetworkActivityIndicatorVisible = true
     }

     func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//       UIApplication.shared.isNetworkActivityIndicatorVisible = false
     }
}
extension PlaceViewController : GMSMapViewDelegate {
//     인포는 나중에
//    public func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//        marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
//        marker.icon = UIImage(named: "plus.app")
//        marker.map = mapView
//        mapView.selectedMarker = marker
//        return nil
//    }
//    public func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
//
//        marker.snippet = "testests"
//        marker.title = "testset"
//        marker.map = mapView
//
//        return contentView
//    }
//
    public func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        layoutModel._BOOK_MARK_TOOL_TIP.isHidden = true
        
//        layoutModel._MAP_CENTER_MARKER.isHidden = false
        print(gesture)
    }
    
    
    public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.layoutModel._BOOK_MARK_TOOL_TIP.isHidden = false
        })
        
        mapView.animate(toLocation: marker.position)
        
        return true
    }

    public func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        print("didTap")
    }
    
    
    public func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print(mapView.camera.target)
        service?.setLocation(position: mapView.camera.target)
    }
    
    public func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        print(mapView.camera.target)
        
        
    }
}
