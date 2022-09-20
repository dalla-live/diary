//
//  MapService.swift
//  Service
//
//  Created by inforex_imac on 2022/09/18.
//

import Foundation
import UIKit
import GoogleMaps
import GoogleMapsUtils



public protocol MapService: AnyObject {
    var mapUI : UIView? {get}
    func search(place: String)
    func getLocation() -> CLLocationCoordinate2D
    func setLocation(position: CLLocationCoordinate2D)
}

public class GoogleMapServiceProvider : NSObject, MapService {
    
    public weak var mapUI : UIView? {
        return self.mapView
    }
    
    private var mapView: GMSMapView!
    var clusterManager: GMUClusterManager!
    var marker : GMSMarker!
    var kClusterItemCount = 20
    var kCameraLatitude = -33.8
    var kCameraLongitude = 151.2
    public weak var delegate : GMSMapViewDelegate?
    
    // 맵서비스에는 기본적으로 GPS 좌표 시스템에 의존적이라고 생각하고 ..
    var service: LocationService?
    
    public init(service: LocationService? = nil, delegate : GMSMapViewDelegate? ) {
        super.init()
        self.delegate = delegate
        self.service = service
        
        service?.setDelegate(delegate: self)
        
        GMSServices.provideAPIKey("AIzaSyCufAiUM6o1EKSLquAZtZGa8WVRgr2iEiY")
        
        // 초기 세팅은 엉뚱한 곳으로
        let camera   = GMSCameraPosition.camera(withLatitude: kCameraLatitude, longitude: kCameraLongitude, zoom: 15, bearing: 0, viewingAngle: 45)
        self.mapView = GMSMapView(frame: .zero, camera: camera)
        
        setClusterManager()
        setDelegate()
    }
    
    
    // 마커 간략화 처리를 위한 클러스터 등록
    // GMSMarker(position: position)
    // self.addPlace
    private func setClusterManager() {
        let algorithm     = GMUNonHierarchicalDistanceBasedAlgorithm()
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let renderer      = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager    = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
    }
    
    public func setDelegate() {
        mapView.delegate = delegate ?? self
        clusterManager.setMapDelegate(delegate ?? self)
    }
    
    deinit {
        print("\(#file) \(#function)")
    }

    private func addPlace(places: [CLLocationCoordinate2D]){
        let _ = places.map{ [weak self] place in
            self?.clusterManager.add(GMSMarker(position: place))
        }
        clusterManager.cluster()
    }
    
    /// Returns a random value between -1.0 and 1.0.
      private func randomScale() -> Double {
        return Double(arc4random()) / Double(UINT32_MAX) * 2.0 - 1.0
      }
    
    public func didLoad(view: UIView) {
        
    }
    
    public func setLocation(position: CLLocationCoordinate2D){
        marker.position = position
    }
    
    public func getMap() -> UIView {
        return self.mapView
    }
    
    public func search(place: String) {
        
    }
    
    public func getLocation() -> CLLocationCoordinate2D {
        return self.service?.getLocation() ?? CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
    }
}

extension GoogleMapServiceProvider: LocationServiceDelegate {
    public func setLocation(location: CLLocationCoordinate2D) {
        
        if self.marker == nil {
            mapView.animate(toLocation: location)
            
            marker = GMSMarker(position: location)
            marker.title = "현재위치"
            marker.map = mapView
            return
        }
        
        self.marker.position = location
    }
}

extension GoogleMapServiceProvider: GMSMapViewDelegate {
    public func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        print(gesture)
    }
    
    public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.animate(toLocation: marker.position)
        return true
    }
    
    public func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        print("didTap")
    }
    public func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        print(position)
    }
    public func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {

    }
    
}
