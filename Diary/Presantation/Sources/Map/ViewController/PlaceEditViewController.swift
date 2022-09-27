//
//  AddBookMarkViewController.swift
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

class PlaceEditViewController: UIViewController {
    
    var service: MapService?
    
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
        GMSPlacesClient.provideAPIKey("AIzaSyCufAiUM6o1EKSLquAZtZGa8WVRgr2iEiY")
    }
    
    required init?(coder: NSCoder) {
         fatalError("init(coder:) is not supported")
     }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setLayout()
        
        print("print :: \(self.tabBarItem)")
//        setConstraint()
//
//
//        self.viewModel.viewDidLoad()
//
//        btnBind()
    }
    
    
    func setLayout(){
        let bue = UIView()
        guard let map = service?.mapUI as? GMSMapView else {
            return
        }
        
        let width = UIScreen.main.bounds.width
        
        self.view.addSubview(bue)
        bue.addSubview(map)
        
        bue.snp.makeConstraints{
            $0.width.height.equalTo(width)
            $0.center.equalToSuperview()
        }
        
        map.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
//        self.view.addSubview(bue)
//        bue.addSubview(map)
//        map.snp.makeConstraints{
//            $0.edges.equalToSuperview()
//        }
//        bue.snp.makeConstraints{
//            $0.width.height.equalToSuperview().dividedBy(2)
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.layoutIfNeeded()
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                
            })
            
            mapView.animate(toLocation: marker.position)
            
            return true
        }

        public func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
            print("didTap")
        }
        
        
        public func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            print(mapView.camera.target)
//            mapView.animate(toLocation: mapView.camera.target)
//            service?.setLocation(position: mapView.camera.target)
        }
        
        public func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
    
        }

}
