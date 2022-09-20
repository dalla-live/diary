//
//  GPSLocation.swift
//  ServiceTests
//
//  Created by inforex_imac on 2022/09/18.
//

import Foundation
import CoreLocation
import Util

public protocol LocationService {
    func getLocation() -> CLLocationCoordinate2D
    func setDelegate(delegate: LocationServiceDelegate)
}

public protocol LocationServiceDelegate: AnyObject {
    func setLocation(location: CLLocationCoordinate2D)
}

public class GPSLocationServiceProvider : NSObject, LocationService ,  CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    var currentLocation : CLLocationCoordinate2D!
    
    weak var delegate : LocationServiceDelegate?
    
    override public init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        updateLocation()
    }
    
    public func setDelegate(delegate: LocationServiceDelegate) {
        self.delegate = delegate
    }
    
    func updateLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse :
            print("권한이 있음")
            locationManager.startUpdatingLocation()
        case .restricted, .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            print("아직 선택 하지않음")
        case .denied:
            print("권한 없으니 다른 방식으로 ")
        default :
            print("default")
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last, self.currentLocation != location.coordinate {
            self.currentLocation = location.coordinate
            delegate?.setLocation(location: location.coordinate)
        }
    }
    
    public func getLocation() -> CLLocationCoordinate2D {
        return currentLocation ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
}
