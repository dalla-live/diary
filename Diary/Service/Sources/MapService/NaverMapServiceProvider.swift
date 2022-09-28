//
//  NaverMapServiceProvider.swift
//  Service
//
//  Created by ejsong on 2022/09/26.
//

import Foundation
import UIKit
import NMapsMap

public class NaverMapServiceProvider : NSObject , MapService {

    public var mapUI: UIView?  {
        return self.naverMapView
    }
    
    var service: LocationService?
    var marker : NMFMarker!
    let coord = NMGLatLng(lat: 35.1798159, lng: 129.0750222)
    
    public weak var delegate : NMFMapViewCameraDelegate?
    
    lazy var naverMapView : NMFNaverMapView = {
        let mapView = NMFNaverMapView(frame: .zero)
        mapView.showLocationButton = true
        mapView.showZoomControls = true
        mapView.mapView.isZoomGestureEnabled = true
        mapView.mapView.isScrollGestureEnabled = true
        mapView.mapView.minZoomLevel = 7.0
        mapView.mapView.maxZoomLevel = 17
        return mapView
    }()
    
    public init(service: LocationService? = nil, delegate : NMFMapViewCameraDelegate? ) {
        super.init()
        self.service = service
        self.delegate = delegate
        service?.setDelegate(delegate: self)
        
        setDelegate()
    }
    
    func setDelegate() {
        // NMFMapVIewCameraDelegate 등록
        naverMapView.mapView.addCameraDelegate(delegate: delegate ?? self)
    }
    
    public func search(place: String) {
        
    }
    
    public func getLocation() -> CLLocationCoordinate2D {
        return self.service?.getLocation() ?? CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
    }
    
    public func setCurrentLocation() -> CLLocationCoordinate2D {
        let currentPosition =  self.service?.getLocation() ?? CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
        self.setLocation(position: currentPosition)
        return currentPosition
    }
    
    public func setLocation(position: CLLocationCoordinate2D) {
        naverMapView.mapView.moveCamera(NMFCameraUpdate(scrollTo: NMGLatLng(lat: position.latitude, lng: position.longitude)))
    }
    
    public func setLocation(position: [CLLocationCoordinate2D]) {
       
    }
}

extension NaverMapServiceProvider: LocationServiceDelegate {
    public func setLocation(location: CLLocationCoordinate2D) {
        if marker == nil {
            marker = NMFMarker(position: NMGLatLng(lat: location.latitude, lng: location.longitude))
            
            marker.mapView = naverMapView.mapView
            let cameraUpdate = NMFCameraUpdate(scrollTo: marker.position)
            cameraUpdate.animation = .easeIn
            naverMapView.mapView.moveCamera(cameraUpdate)
        }
        
        marker.position = NMGLatLng(lat: location.latitude, lng: location.longitude)
    }
}

extension NaverMapServiceProvider : NMFMapViewCameraDelegate {
    public func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
        //0: 개발자의 코드로 화면이 움직일때
        //-1: 사용자의 제스처로 화면 움직임
        //-2: 버튼 선택으로 카메라 움직였을 때
        //-3: 네이버 지도가 제공하는 위치 트래킹 기능으로 카메라가 움직였을때
        let camPosition = mapView.cameraPosition.target
        let cameraUpdate = NMFCameraUpdate(scrollTo: camPosition)

        naverMapView.mapView.moveCamera(cameraUpdate)
    }
    
    public func mapViewCameraIdle(_ mapView: NMFMapView) {
        //카메라 이동 멈췄을 때
//        print(#function)
    }

}
