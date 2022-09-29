//
//  PlaceEditViewController.swift
//  Presantation
//
//  Created by inforex_imac on 2022/09/26.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture
import SnapKit
import GoogleMaps
import Service
import GooglePlaces



struct EditLayoutModel {
    
}

class PlaceEditViewController: UIViewController {
    var service: (any MapService)?
    let mapWrapper = UIView()
    let addPlaceView = BookmarkerView()
    
//    override func loadView() {
//        guard let view = service?.mapUI else {
//            return
//        }
//
//        self.view = view
////        layoutModel._MAP_CONTAINER.addSubview(view)
//    }
    
    init () {
        super.init(nibName: nil, bundle: nil)
        service = GoogleMapServiceProvider(service: GPSLocationServiceProvider(), delegate: self)
    }
    
    required init?(coder: NSCoder) {
         fatalError("init(coder:) is not supported")
     }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setLayout()
    }
    

    
    func setLayout(){
        
        guard let service = service as? GoogleMapServiceProvider else {
            return
        }
        
        let map = service.getMapView()
        
        // 이게 없으면 왠지 지도 중심을 못잡는다 ..
        let mapInsets = UIEdgeInsets(top: 1, left: 0.0, bottom: 0.0, right: 0)
            map.padding = mapInsets
        mapWrapper.addSubview(map)
        
        let width = UIScreen.main.bounds.width
        view.addSubview(mapWrapper)
        view.addSubview(self.addPlaceView)
        self.addPlaceView.snp.makeConstraints{
            $0.top.equalTo(mapWrapper.snp.bottom)
            $0.bottom.left.right.equalToSuperview()
        }
        
        map.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        mapWrapper.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalTo(width * 9 / 16)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        let addBookmarkView = AddBookmarkView()
        
        view.addSubview(addBookmarkView)
        
        addBookmarkView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        print(service?.mapUI?.frame)
//        print(service?.mapUI?.bounds)
//        self.view.layoutIfNeeded()
    }
    
}

extension PlaceEditViewController: GMSMapViewDelegate {
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
            print(gesture)
        }
        
        
        public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
//
//            })
            
//            mapView.animate(toLocation: marker.position)
            
            return true
        }

        public func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
            print("didTap")
        }
        
        
        public func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            service?.setLocation(position: position.target)
        }
        
        public func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
    
        }

}
