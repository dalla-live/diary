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
import GooglePlaces
//import SnapKit

public protocol MapService: AnyObject {
    var mapUI : UIView? {get}
    func search(place: String)
    func getLocation() -> CLLocationCoordinate2D
    func setCurrentLocation() -> CLLocationCoordinate2D
    func setLocation(position: CLLocationCoordinate2D)
    func setLocation(position: [CLLocationCoordinate2D])
}

public class GoogleMapServiceProvider : NSObject, MapService {
    
    public weak var mapUI : UIView? {
        let mapInsets = UIEdgeInsets(top: 1, left: 0.0, bottom: 0.0, right: 0)
        mapView.padding = mapInsets
        
        return self.mapView
    }
    private var placesClient: GMSPlacesClient!

    private var mapView: GMSMapView!
    var clusterManager: GMUClusterManager!
    var marker : GMSMarker!
    var kClusterItemCount = 20
    var kCameraLatitude = 35.1268275
    var kCameraLongitude = 126.8810436
    public weak var delegate : GMSMapViewDelegate?
    
    // 맵서비스에는 기본적으로 GPS 좌표 시스템에 의존적이라고 생각하고 ..
    var service: LocationService?
    
    public init(service: LocationService? = nil, delegate : GMSMapViewDelegate? ) {
        super.init()
        self.delegate = delegate
        self.service = service
        
        service?.setDelegate(delegate: self)
        placesClient = GMSPlacesClient.shared()

        // 초기 세팅은 엉뚱한 곳으로
        let camera   = GMSCameraPosition.camera(withLatitude: kCameraLatitude, longitude: kCameraLongitude, zoom: 15)
        self.mapView = GMSMapView(frame: .zero, camera: camera)
              
//        self.mapView.isMyLocationEnabled = true
        setClusterManager()
        setDelegate()
        findPlace()
    }
    
    func findPlace(){
        let placeFields: GMSPlaceField = [.name, .formattedAddress, .coordinate]
        
            placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { [weak self] (placeLikelihoods, error) in
              guard let strongSelf = self else {
                return
              }

              guard error == nil else {
                print("Current place error: \(error?.localizedDescription ?? "")")
                return
              }

              guard let place = placeLikelihoods?.first?.place else {
                return
              }
                print("::::: \(place.name)")
                print("::::: \(place.formattedAddress)")
                print("::::: \(place.coordinate)")
            }
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
    
    public func setLocation(position: CLLocationCoordinate2D) {
        mapView.animate(toLocation: position)
        marker.position = position
    }
    
    public func setLocation(position: [CLLocationCoordinate2D]) {
        
    }
    
    public func getMap() -> UIView {
        return self.mapView
    }
    
    public func search(place: String) {
        
    }
    public func getLocation() -> CLLocationCoordinate2D {
        let currentPosition =  self.service?.getLocation() ?? CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
        return currentPosition
    }
    
    public func setCurrentLocation() -> CLLocationCoordinate2D {
        let currentPosition =  self.service?.getLocation() ?? CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
        self.setLocation(position: currentPosition)
        return currentPosition
    }
}

extension GoogleMapServiceProvider: LocationServiceDelegate {
    public func setLocation(location: CLLocationCoordinate2D) {
        
        if self.marker == nil {
            mapView.animate(toLocation: location)
            
            marker = GMSMarker(position: location)
//            marker.title = "현재위치"
//            marker.snippet = "Population: 4,169,103"
            marker.map = mapView
//            mapView.selectedMarker = marker
            
           //            $0.centerX.equalToSuperview()
           //            $0.centerY.equalToSuperview().offset(-100)
           //        }
            return
        }
        
        self.marker.position = location
    }
}

extension GoogleMapServiceProvider: GMSMapViewDelegate {
    public func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
       return nil
    }
    public func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        return nil
    }
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
        
        print(mapView.camera.target)
//        print(mapView.camera.target)
    }
    public func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {

    }
    
}
